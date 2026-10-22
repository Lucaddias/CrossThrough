import CryptoKit
import Foundation
import ImageIO

/// Ícones de programas Windows: os recursos RT_GROUP_ICON/RT_ICON de um
/// executável PE viram um .ico, que o ImageIO do macOS lê.
public enum IconExtractor {
    private static let rtIcon: UInt32 = 3
    private static let rtGroupIcon: UInt32 = 14

    /// O ícone de `reference` como .ico: o próprio arquivo, se já for um .ico,
    /// ou o grupo de ícones do .exe/.dll. nil se o arquivo não tiver ícone.
    public static func icoData(for reference: IconReference) throws -> Data? {
        let data = try Data(contentsOf: reference.file, options: .mappedIfSafe)
        if isICO(data) { return data }
        return try icoData(fromPE: data, index: reference.index)
    }

    static func isICO(_ data: Data) -> Bool {
        data.count >= 6 && data.prefix(4) == Data([0, 0, 1, 0])
    }

    public static func icoData(fromPE data: Data, index: Int32) throws -> Data? {
        let pe = try PEResources(data)
        guard let groups = try pe.entries(type: rtGroupIcon), !groups.isEmpty else { return nil }
        // index >= 0 é a posição na ordem do arquivo (nomes, depois IDs); < 0 é o ID.
        let group: PEResources.Entry?
        if index < 0 {
            group = groups.first { $0.id == UInt32(-Int64(index)) }
        } else {
            group = Int(index) < groups.count ? groups[Int(index)] : groups.first
        }
        guard let group, let directory = try pe.data(of: group) else { return nil }
        let icons = try pe.entries(type: rtIcon) ?? []

        // GRPICONDIR (6 bytes) + GRPICONDIRENTRY (14 bytes cada) -> ICONDIR + ICONDIRENTRY (16 bytes).
        let g = BinaryReader(directory)
        guard try g.u16(2) == 1 else { return nil }
        let count = Int(try g.u16(4))
        var images: [(header: Data, image: Data)] = []
        for i in 0..<min(count, 256) {
            let e = 6 + i * 14
            let id = UInt32(try g.u16(e + 12))
            guard let entry = icons.first(where: { $0.id == id }), let image = try pe.data(of: entry) else { continue }
            images.append((try g.bytes(e, 12).dropLast(4) + le32(UInt32(image.count)), image))
        }
        guard !images.isEmpty else { return nil }
        var ico = Data([0, 0, 1, 0]) + le16(UInt16(images.count))
        var offset = 6 + images.count * 16
        for (header, image) in images {
            ico += header + le32(UInt32(offset))
            offset += image.count
        }
        for (_, image) in images { ico += image }
        return ico
    }

    /// PNG da maior imagem do .ico, reduzida para no máximo `maxPixelSize`.
    public static func pngData(fromICO ico: Data, maxPixelSize: Int = 256) -> Data? {
        // Só a imagem escolhida vai para o ImageIO: ele devolve as imagens do
        // .ico na ordem dele, não na do arquivo, e diz profundidade 8 para todas.
        let chosen = bestImage(inICO: ico) ?? ico
        guard let source = CGImageSourceCreateWithData(chosen as CFData, nil) else { return nil }
        let count = CGImageSourceGetCount(source)
        guard count > 0 else { return nil }
        // Num .ico que não deu para ler aqui, a primeira das maiores.
        var best = 0, bestWidth = -1
        for i in 0..<count {
            let props = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [CFString: Any]
            let width = props?[kCGImagePropertyPixelWidth] as? Int ?? 0
            if width > bestWidth { best = i; bestWidth = width }
        }
        let options: [CFString: Any] = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: maxPixelSize,
        ]
        guard let decoded = bestWidth > maxPixelSize
                ? CGImageSourceCreateThumbnailAtIndex(source, best, options as CFDictionary)
                : CGImageSourceCreateImageAtIndex(source, best, nil),
              let image = rgba8(decoded) else { return nil }
        let out = NSMutableData()
        guard let dest = CGImageDestinationCreateWithData(out, "public.png" as CFString, 1, nil) else { return nil }
        CGImageDestinationAddImage(dest, image, nil)
        guard CGImageDestinationFinalize(dest) else { return nil }
        return out as Data
    }

    /// A imagem redesenhada em RGBA de 8 bits. Os bitmaps de paleta do .ico
    /// (4 e 1 bit) saem do ImageIO com 4 bits por componente, e o PNG gravado
    /// direto deles fica com alfa 15 de 255: quase invisível.
    private static func rgba8(_ image: CGImage) -> CGImage? {
        guard let space = CGColorSpace(name: CGColorSpace.sRGB),
              let context = CGContext(data: nil, width: image.width, height: image.height, bitsPerComponent: 8,
                                      bytesPerRow: 0, space: space,
                                      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else { return nil }
        context.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
        return context.makeImage()
    }

    /// A imagem que o Windows mostraria no maior tamanho, sozinha num .ico:
    /// a maior e, entre as do mesmo tamanho, a de mais cores. Ícones antigos
    /// (o do PuTTY) trazem versões de 1 bit do mesmo tamanho depois das
    /// coloridas. nil se o diretório não der para ler.
    static func bestImage(inICO ico: Data) -> Data? {
        let r = BinaryReader(ico)
        var best: (entry: Data, image: Data, key: (width: Int, depth: Int))?
        for (entry, image) in images(inICO: r) {
            guard let key = imageKey(image) else { continue }
            if best == nil || key > best!.key { best = (entry, image, key) }
        }
        guard let best else { return nil }
        return Data([0, 0, 1, 0, 1, 0]) + best.entry.prefix(8) + le32(UInt32(best.image.count)) + le32(22) + best.image
    }

    /// As entradas do diretório (16 bytes) e os dados de cada imagem.
    private static func images(inICO r: BinaryReader) -> [(entry: Data, image: Data)] {
        guard let count = try? Int(r.u16(4)) else { return [] }
        return (0..<count).compactMap { i in
            guard let entry = try? r.bytes(6 + i * 16, 16) else { return nil }
            let e = BinaryReader(entry)
            guard let size = try? Int(e.u32(8)), let offset = try? Int(e.u32(12)),
                  let image = try? r.bytes(offset, size) else { return nil }
            return (entry, image)
        }
    }

    /// Largura e bits por pixel tirados da própria imagem (o BITMAPINFOHEADER
    /// ou o IHDR do PNG): os campos do diretório vêm zerados em muitos .ico.
    static func imageKey(_ image: Data) -> (width: Int, depth: Int)? {
        let h = BinaryReader(image)
        if (try? h.bytes(0, 8)) == Data([0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]) {
            guard let b = try? h.bytes(16, 10) else { return nil }
            let width = b.prefix(4).reduce(0) { $0 << 8 | Int($1) }
            let channels = [0: 1, 2: 3, 3: 1, 4: 2, 6: 4][Int(b[9])] ?? 1
            return (width, Int(b[8]) * channels)
        }
        guard let width = try? h.u32(4), let bitCount = try? h.u16(14) else { return nil }
        return (Int(Int32(bitPattern: width)), Int(bitCount))
    }
}

/// Cache em disco dos ícones em PNG, em ~/Library/Caches/CrossThrough/Icons.
/// A chave inclui a data de modificação do arquivo: um programa atualizado
/// ganha o ícone novo.
public enum IconCache {
    public static var directory: URL {
        FileManager.default.homeDirectoryForCurrentUser.appending(path: "Library/Caches/CrossThrough/Icons")
    }

    public static func png(for reference: IconReference, maxPixelSize: Int = 256) -> Data? {
        let fm = FileManager.default
        let modified = (try? fm.attributesOfItem(atPath: reference.file.path)[.modificationDate] as? Date)?
            .timeIntervalSince1970 ?? 0
        // A versão muda quando a extração muda: senão o cache serve o PNG antigo.
        let key = "2|\(reference.file.path)|\(reference.index)|\(modified)|\(maxPixelSize)"
        let name = SHA256.hash(data: Data(key.utf8)).map { String(format: "%02x", $0) }.joined()
        let cached = directory.appending(path: "\(name).png")
        if let data = try? Data(contentsOf: cached) { return data }
        guard let ico = try? IconExtractor.icoData(for: reference),
              let png = IconExtractor.pngData(fromICO: ico, maxPixelSize: maxPixelSize) else { return nil }
        try? fm.createDirectory(at: directory, withIntermediateDirectories: true)
        try? png.write(to: cached, options: .atomic)
        return png
    }
}

/// O diretório de recursos de um executável PE (32 ou 64 bits).
struct PEResources {
    struct Entry {
        var id: UInt32?        // nil para entradas com nome
        var dataEntryOffset: Int
    }

    private let r: BinaryReader
    private let sections: [(va: UInt32, size: UInt32, raw: UInt32, rawSize: UInt32)]
    private let root: Int?

    init(_ data: Data) throws {
        r = BinaryReader(data)
        guard try r.u16(0) == 0x5A4D else { throw BinaryFormatError.invalid("não é um executável do Windows") }
        let pe = Int(try r.u32(0x3C))
        guard try r.u32(pe) == 0x0000_4550 else { throw BinaryFormatError.invalid("cabeçalho PE ausente") }
        let coff = pe + 4
        let sectionCount = Int(try r.u16(coff + 2))
        let optionalSize = Int(try r.u16(coff + 16))
        let opt = coff + 20
        let magic = try r.u16(opt)
        let directories: Int, rvaCount: UInt32
        switch magic {
        case 0x10B: directories = opt + 96; rvaCount = try r.u32(opt + 92)
        case 0x20B: directories = opt + 112; rvaCount = try r.u32(opt + 108)
        default: throw BinaryFormatError.invalid("cabeçalho opcional PE desconhecido (\(magic))")
        }
        var list: [(UInt32, UInt32, UInt32, UInt32)] = []
        let table = opt + optionalSize
        for i in 0..<min(sectionCount, 96) {
            let s = table + i * 40
            list.append((try r.u32(s + 12), try r.u32(s + 8), try r.u32(s + 20), try r.u32(s + 16)))
        }
        sections = list
        // Diretório de dados 2: recursos.
        let rva = rvaCount > 2 ? try r.u32(directories + 16) : 0
        root = rva != 0 ? Self.offset(of: rva, in: list) : nil
    }

    private static func offset(of rva: UInt32, in sections: [(va: UInt32, size: UInt32, raw: UInt32, rawSize: UInt32)]) -> Int? {
        for s in sections {
            let span = max(s.size, s.rawSize)
            if rva >= s.va && rva - s.va < span { return Int(s.raw) + Int(rva - s.va) }
        }
        return nil
    }

    /// Entradas de um diretório de recursos: nomes primeiro, depois IDs (a ordem do arquivo).
    private func directoryEntries(at offset: Int) throws -> [(name: UInt32, target: UInt32)] {
        let named = Int(try r.u16(offset + 12)), ids = Int(try r.u16(offset + 14))
        let total = min(named + ids, 4096)
        return try (0..<total).map { i in
            let e = offset + 16 + i * 8
            return (try r.u32(e), try r.u32(e + 4))
        }
    }

    /// Os recursos de um tipo (RT_ICON, RT_GROUP_ICON), já no idioma escolhido
    /// (o primeiro de cada um). nil se o executável não tiver recursos.
    func entries(type: UInt32) throws -> [Entry]? {
        guard let root else { return nil }
        guard let typeEntry = try directoryEntries(at: root).first(where: { $0.name == type }),
              typeEntry.target & 0x8000_0000 != 0 else { return [] }
        var result: [Entry] = []
        for (name, target) in try directoryEntries(at: root + Int(typeEntry.target & 0x7FFF_FFFF)) {
            let id: UInt32? = name & 0x8000_0000 == 0 ? name : nil
            var node = target
            // Nível do idioma: o primeiro.
            if node & 0x8000_0000 != 0 {
                guard let first = try directoryEntries(at: root + Int(node & 0x7FFF_FFFF)).first,
                      first.target & 0x8000_0000 == 0 else { continue }
                node = first.target
            }
            result.append(Entry(id: id, dataEntryOffset: root + Int(node)))
        }
        return result
    }

    func data(of entry: Entry) throws -> Data? {
        let rva = try r.u32(entry.dataEntryOffset)
        let size = Int(try r.u32(entry.dataEntryOffset + 4))
        guard let offset = Self.offset(of: rva, in: sections), size > 0 else { return nil }
        return try r.bytes(offset, size)
    }
}

private func le16(_ v: UInt16) -> Data { Data([UInt8(v & 0xFF), UInt8(v >> 8)]) }
private func le32(_ v: UInt32) -> Data { Data((0..<4).map { UInt8((v >> (8 * $0)) & 0xFF) }) }
