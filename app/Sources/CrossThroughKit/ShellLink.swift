import Foundation

/// Um atalho do Windows (.lnk), no formato MS-SHLLINK.
///
/// O alvo pode estar em três lugares, e cada criador de atalho preenche um
/// conjunto diferente: o LinkInfo (caminho local, em ANSI ou Unicode), o bloco
/// de variáveis de ambiente (`%ProgramFiles%\...`) e a lista de IDs do shell
/// (um item por componente do caminho, com o nome longo em Unicode). Os
/// candidatos ficam em `targetCandidates`, do mais para o menos confiável; quem
/// conhece a bottle escolhe o primeiro que existe.
public struct ShellLink: Sendable, Equatable {
    /// Caminhos Windows do alvo, em ordem de preferência. Podem ter variáveis (`%VAR%`).
    public var targetCandidates: [String] = []
    public var name: String?
    public var relativePath: String?
    public var workingDirectory: String?
    public var arguments: String?
    public var iconLocation: String?
    public var iconIndex: Int32 = 0
    public var showCommand: UInt32 = 1
    /// Atalho "anunciado" do Windows Installer: não tem caminho, quem resolve é o msi.
    public var isAdvertised = false

    public init() {}

    public init(contentsOf url: URL) throws {
        self = try Self.parse(Data(contentsOf: url))
    }

    // LinkFlags
    private static let hasLinkTargetIDList: UInt32 = 0x1
    private static let hasLinkInfo: UInt32 = 0x2
    private static let hasName: UInt32 = 0x4
    private static let hasRelativePath: UInt32 = 0x8
    private static let hasWorkingDir: UInt32 = 0x10
    private static let hasArguments: UInt32 = 0x20
    private static let hasIconLocation: UInt32 = 0x40
    private static let isUnicode: UInt32 = 0x80
    private static let forceNoLinkInfo: UInt32 = 0x100
    private static let hasExpString: UInt32 = 0x200

    /// {00021401-0000-0000-C000-000000000046}, como gravado no arquivo.
    private static let clsid = Data([0x01, 0x14, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00,
                                     0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46])

    public static func parse(_ data: Data) throws -> ShellLink {
        let r = BinaryReader(data)
        guard r.count >= 0x4C, try r.u32(0) == 0x4C, try r.bytes(4, 16) == clsid else {
            throw BinaryFormatError.invalid("não é um atalho do Windows (.lnk)")
        }
        var link = ShellLink()
        let flags = try r.u32(0x14)
        link.iconIndex = try r.i32(0x38)
        link.showCommand = try r.u32(0x3C)

        var offset = 0x4C
        var idListPath: String?
        if flags & hasLinkTargetIDList != 0 {
            let size = Int(try r.u16(offset))
            idListPath = try? parseIDList(BinaryReader(r.bytes(offset + 2, size)))
            offset += 2 + size
        }

        var linkInfoPaths: [String] = []
        if flags & hasLinkInfo != 0 {
            let size = Int(try r.u32(offset))
            if flags & forceNoLinkInfo == 0 {
                linkInfoPaths = (try? parseLinkInfo(BinaryReader(r.bytes(offset, size)))) ?? []
            }
            offset += size
        }

        let unicode = flags & isUnicode != 0
        func stringData() throws -> String {
            let units = Int(try r.u16(offset))
            offset += 2
            defer { offset += unicode ? units * 2 : units }
            return unicode ? try r.utf16(offset, units: units) : decodeANSI(try r.bytes(offset, units))
        }
        if flags & hasName != 0 { link.name = try stringData() }
        if flags & hasRelativePath != 0 { link.relativePath = try stringData() }
        if flags & hasWorkingDir != 0 { link.workingDirectory = try stringData() }
        if flags & hasArguments != 0 { link.arguments = try stringData() }
        if flags & hasIconLocation != 0 { link.iconLocation = try stringData() }

        // ExtraData: blocos até um terminador (tamanho < 4) ou o fim do arquivo.
        var expandable: String?
        while offset + 8 <= r.count {
            let size = Int(try r.u32(offset))
            guard size >= 8, offset + size <= r.count else { break }
            let signature = try r.u32(offset + 4)
            switch signature {
            case 0xA000_0001 where flags & hasExpString != 0 && size >= 0x314:
                expandable = environmentBlockTarget(r, at: offset)
            case 0xA000_0007 where link.iconLocation == nil && size >= 0x314:
                link.iconLocation = environmentBlockTarget(r, at: offset)
            case 0xA000_0006:
                link.isAdvertised = true
            default:
                break
            }
            offset += size
        }

        var candidates = linkInfoPaths
        if let expandable { candidates.append(expandable) }
        if let idListPath { candidates.append(idListPath) }
        var seen = Set<String>()
        link.targetCandidates = candidates.filter { !$0.isEmpty && seen.insert($0.lowercased()).inserted }
        return link
    }

    /// LinkInfo: caminho local (ANSI e, se o cabeçalho for longo, Unicode) mais o sufixo.
    private static func parseLinkInfo(_ r: BinaryReader) throws -> [String] {
        let headerSize = Int(try r.u32(4))
        let flags = try r.u32(8)
        guard flags & 0x1 != 0 else { return [] } // só VolumeIDAndLocalBasePath; caminho de rede não mapeia
        var paths: [String] = []
        let suffixANSI = decodeANSI(try r.cString(Int(try r.u32(24))))
        if headerSize >= 0x24 {
            let base = try r.u32(28), suffix = try r.u32(32)
            if base != 0 {
                let baseText = try r.utf16CString(Int(base)).0
                let suffixText = suffix != 0 ? try r.utf16CString(Int(suffix)).0 : ""
                paths.append(joinWindowsPath(baseText, suffixText))
            }
        }
        let base = decodeANSI(try r.cString(Int(try r.u32(16))))
        paths.append(joinWindowsPath(base, suffixANSI))
        return paths
    }

    /// EnvironmentVariableDataBlock/IconEnvironmentDataBlock: 260 bytes ANSI, depois 260 WCHAR.
    private static func environmentBlockTarget(_ r: BinaryReader, at offset: Int) -> String? {
        if let unicode = try? r.utf16CString(offset + 268, limit: 520).0, !unicode.isEmpty { return unicode }
        if let ansi = try? r.cString(offset + 8, limit: 260), !ansi.isEmpty { return decodeANSI(ansi) }
        return nil
    }

    /// Lista de IDs do shell -> caminho. Entende o que o Wine e o Windows gravam
    /// para "Meu Computador\C:\pasta\arquivo"; outras raízes devolvem nil.
    static func parseIDList(_ r: BinaryReader) throws -> String? {
        var offset = 0
        var drive: String?
        var components: [String] = []
        while offset + 2 <= r.count {
            let size = Int(try r.u16(offset))
            if size == 0 { break }
            guard size >= 3 else { return nil }
            let item = BinaryReader(try r.bytes(offset, size))
            let type = try item.u8(2)
            switch type {
            case 0x1F:
                break // raiz com CLSID (Meu Computador)
            case 0x20...0x2F:
                // Volume: "C:\" em ANSI logo após o tipo.
                guard let text = try? decodeANSI(item.cString(3)), text.count >= 2 else { return nil }
                drive = String(text.prefix(2))
            case 0x30...0x3F:
                components.append(try fileEntryName(item, type: type))
            default:
                return nil
            }
            offset += size
        }
        guard let drive, drive.last == ":" else { return nil }
        return ([drive] + components).joined(separator: "\\")
    }

    /// Nome de um item de arquivo/pasta: o longo (Unicode) do bloco de extensão,
    /// ou o curto (8.3) se não houver bloco.
    private static func fileEntryName(_ item: BinaryReader, type: UInt8) throws -> String {
        let unicodeShort = type & 0x04 != 0
        let short: String
        if unicodeShort {
            short = try item.utf16CString(14).0
        } else {
            short = decodeANSI(try item.cString(14))
        }
        // O último WORD do item é o deslocamento do bloco de extensão.
        guard item.count >= 4, let extOffset = try? Int(item.u16(item.count - 2)),
              extOffset >= 14, extOffset % 2 == 0, extOffset + 22 <= item.count - 2 else { return short }
        let blockSize = Int(try item.u16(extOffset))
        let version = try item.u16(extOffset + 2)
        let signature = try item.u32(extOffset + 4)
        let nameOffset: Int
        if signature == 0xBEEF_0004 {
            switch version {
            case ..<3: return short
            case 3..<7: nameOffset = 20
            case 7: nameOffset = 38
            case 8: nameOffset = 42
            default: nameOffset = 46
            }
        } else if signature == 0 && version == 0 {
            nameOffset = 20 // o Wine grava o bloco sem versão nem assinatura (FileStructW)
        } else {
            return short
        }
        let limit = min(blockSize, item.count - 2 - extOffset) - nameOffset
        guard limit > 0, let long = try? item.utf16CString(extOffset + nameOffset, limit: limit).0,
              !long.isEmpty else { return short }
        return long
    }
}

extension ShellLink {
    /// Um .lnk para `target` (caminho Windows, ex.: `C:\Program Files\App\app.exe`):
    /// cabeçalho, LinkInfo com o caminho em ANSI e em Unicode, e os textos em
    /// Unicode. Sem lista de IDs, como o MS-SHLLINK permite; o Wine e o Windows
    /// leem o alvo do LinkInfo.
    public static func make(target: String, workingDirectory: String? = nil, arguments: String? = nil,
                            iconLocation: String? = nil, iconIndex: Int32 = 0, name: String? = nil) -> Data {
        var flags = hasLinkInfo | isUnicode
        let strings: [(UInt32, String?)] = [(hasName, name), (hasWorkingDir, workingDirectory),
                                            (hasArguments, arguments), (hasIconLocation, iconLocation)]
        for (flag, value) in strings where value?.isEmpty == false { flags |= flag }

        var out = Data()
        out += le32(0x4C) + clsid + le32(flags)
        out += le32(0)                       // FileAttributes
        out += Data(count: 24)               // datas de criação, acesso e escrita
        out += le32(0)                       // FileSize
        out += le32(UInt32(bitPattern: iconIndex))
        out += le32(1)                       // SW_SHOWNORMAL
        out += Data(count: 12)               // HotKey e reservados
        assert(out.count == 0x4C)

        // LinkInfo com cabeçalho de 0x24 bytes (tem os deslocamentos Unicode).
        let volume = le32(0x11) + le32(3) + le32(0) + le32(0x10) + Data([0]) // DRIVE_FIXED, rótulo vazio
        let ansi = (target.data(using: .windowsCP1252, allowLossyConversion: true) ?? Data(target.utf8)) + Data([0])
        let suffixANSI = Data([0])
        let unicode = utf16LE(target) + Data([0, 0])
        let suffixUnicode = Data([0, 0])
        let header = 0x24
        let volumeOffset = header
        let baseOffset = volumeOffset + volume.count
        let suffixOffset = baseOffset + ansi.count
        let baseUnicodeOffset = suffixOffset + suffixANSI.count
        let suffixUnicodeOffset = baseUnicodeOffset + unicode.count
        let size = suffixUnicodeOffset + suffixUnicode.count
        out += le32(UInt32(size)) + le32(UInt32(header)) + le32(1)
        out += le32(UInt32(volumeOffset)) + le32(UInt32(baseOffset)) + le32(0) + le32(UInt32(suffixOffset))
        out += le32(UInt32(baseUnicodeOffset)) + le32(UInt32(suffixUnicodeOffset))
        out += volume + ansi + suffixANSI + unicode + suffixUnicode

        // StringData, na ordem do formato.
        for (flag, value) in strings {
            guard flags & flag != 0, let value else { continue }
            out += le16(UInt16(value.utf16.count)) + utf16LE(value)
        }
        out += le32(0) // TerminalBlock
        return out
    }
}

private func le16(_ v: UInt16) -> Data { Data([UInt8(v & 0xFF), UInt8(v >> 8)]) }
private func le32(_ v: UInt32) -> Data { Data((0..<4).map { UInt8((v >> (8 * $0)) & 0xFF) }) }
private func utf16LE(_ s: String) -> Data { Data(s.utf16.flatMap { [UInt8($0 & 0xFF), UInt8($0 >> 8)] }) }

func joinWindowsPath(_ base: String, _ suffix: String) -> String {
    if suffix.isEmpty { return base }
    if base.hasSuffix("\\") { return base + suffix }
    return base + "\\" + suffix
}
