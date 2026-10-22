import Foundation

/// Um ponto de reparse do NTFS (link simbólico ou junção) como o Wine grava:
/// um item chamado `<nome>?` com o REPARSE_DATA_BUFFER do Windows no atributo
/// estendido `user.WINEREPARSE` (dlls/ntdll/unix/file.c). Instaladores como o
/// do EA app criam um link para a pasta da versão atual, e os atalhos apontam
/// através dele.
struct ReparsePoint: Equatable {
    enum Target: Equatable {
        /// Relativo à pasta onde está o link (pode ter `..`).
        case relative(String)
        /// Caminho do Windows completo (`C:\...`), já sem o prefixo `\??\`.
        case absolute(String)
    }

    var target: Target

    static let xattrName = "user.WINEREPARSE"
    /// O mesmo limite do Wine para links que apontam para links.
    static let maximumHops = 63

    private static let tagMountPoint: UInt32 = 0xA000_0003
    private static let tagSymlink: UInt32 = 0xA000_000C
    private static let symlinkFlagRelative: UInt32 = 1

    /// O ponto de reparse de um item, ou nil se ele não for um.
    init?(contentsOf url: URL) {
        let size = getxattr(url.path, Self.xattrName, nil, 0, 0, 0)
        guard size > 0, size <= 16 * 1024 else { return nil }
        var data = Data(count: size)
        let read = data.withUnsafeMutableBytes { getxattr(url.path, Self.xattrName, $0.baseAddress, size, 0, 0) }
        guard read == size else { return nil }
        self.init(data: data)
    }

    /// REPARSE_DATA_BUFFER: tag, tamanho, reservado e o buffer do tipo. Só
    /// links simbólicos e junções têm destino; os outros tipos ficam nil.
    init?(data: Data) {
        let r = BinaryReader(data)
        guard let tag = try? r.u32(0) else { return nil }
        let pathBuffer: Int
        switch tag {
        case Self.tagSymlink: pathBuffer = 20
        case Self.tagMountPoint: pathBuffer = 16
        default: return nil
        }
        guard let offset = try? Int(r.u16(8)), let length = try? Int(r.u16(10)), length > 0,
              let bytes = try? r.bytes(pathBuffer + offset, length),
              let name = String(data: bytes, encoding: .utf16LittleEndian) else { return nil }
        if tag == Self.tagSymlink, let flags = try? r.u32(16), flags & Self.symlinkFlagRelative != 0 {
            target = .relative(name)
        } else {
            target = .absolute(name.hasPrefix(#"\??\"#) ? String(name.dropFirst(4)) : name)
        }
    }

    /// Monta o buffer (para testes e para gravar um link como o Wine grava).
    static func data(for target: Target) -> Data {
        func le16(_ v: Int) -> Data { Data([UInt8(v & 0xFF), UInt8(v >> 8 & 0xFF)]) }
        func le32(_ v: UInt32) -> Data { Data((0..<4).map { UInt8(v >> (8 * $0) & 0xFF) }) }
        switch target {
        case .relative(let path):
            let name = Data(path.utf16.flatMap { [UInt8($0 & 0xFF), UInt8($0 >> 8)] })
            let body = le16(0) + le16(name.count) + le16(name.count) + le16(name.count) + le32(symlinkFlagRelative)
                + name + name
            return le32(tagSymlink) + le16(body.count) + le16(0) + body
        case .absolute(let path):
            let name = Data((#"\??\"# + path).utf16.flatMap { [UInt8($0 & 0xFF), UInt8($0 >> 8)] })
            let body = le16(0) + le16(name.count) + le16(name.count + 2) + le16(0) + name + Data([0, 0])
            return le32(tagMountPoint) + le16(body.count) + le16(0) + body
        }
    }
}
