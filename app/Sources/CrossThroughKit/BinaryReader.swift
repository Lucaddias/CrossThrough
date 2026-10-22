import Foundation

public enum BinaryFormatError: LocalizedError, Equatable {
    case truncated(offset: Int, needed: Int, size: Int)
    case invalid(String)

    public var errorDescription: String? {
        switch self {
        case .truncated(let offset, let needed, let size):
            return "arquivo truncado: \(needed) bytes em \(offset), mas o arquivo tem \(size)"
        case .invalid(let reason):
            return reason
        }
    }
}

/// Leitura little-endian com limites conferidos, para os formatos do Windows
/// (.lnk, PE, .ico). Nenhum acesso passa do fim: um arquivo malformado vira
/// erro, nunca leitura fora do buffer.
struct BinaryReader {
    let data: Data

    init(_ data: Data) {
        // Índices a partir de 0, mesmo para uma fatia de outro Data.
        self.data = data.startIndex == 0 ? data : Data(data)
    }

    var count: Int { data.count }

    func check(_ offset: Int, _ length: Int) throws {
        guard offset >= 0, length >= 0, offset <= data.count, length <= data.count - offset else {
            throw BinaryFormatError.truncated(offset: offset, needed: length, size: data.count)
        }
    }

    func u8(_ offset: Int) throws -> UInt8 {
        try check(offset, 1)
        return data[offset]
    }

    func u16(_ offset: Int) throws -> UInt16 {
        try check(offset, 2)
        return UInt16(data[offset]) | UInt16(data[offset + 1]) << 8
    }

    func u32(_ offset: Int) throws -> UInt32 {
        try check(offset, 4)
        return (0..<4).reduce(UInt32(0)) { $0 | UInt32(data[offset + $1]) << (8 * $1) }
    }

    func i32(_ offset: Int) throws -> Int32 { Int32(bitPattern: try u32(offset)) }

    func u64(_ offset: Int) throws -> UInt64 {
        try check(offset, 8)
        return (0..<8).reduce(UInt64(0)) { $0 | UInt64(data[offset + $1]) << (8 * $1) }
    }

    func bytes(_ offset: Int, _ length: Int) throws -> Data {
        try check(offset, length)
        return data.subdata(in: offset..<(offset + length))
    }

    /// Bytes até o primeiro 0 (sem ele), dentro de `limit` bytes a partir de `offset`.
    func cString(_ offset: Int, limit: Int? = nil) throws -> Data {
        try check(offset, 0)
        let end = min(data.count, limit.map { offset + $0 } ?? data.count)
        guard let zero = data[offset..<end].firstIndex(of: 0) else {
            throw BinaryFormatError.invalid("texto sem terminador em \(offset)")
        }
        return data.subdata(in: offset..<zero)
    }

    /// `units` unidades UTF-16LE.
    func utf16(_ offset: Int, units: Int) throws -> String {
        let raw = try bytes(offset, units * 2)
        return String(decoding: stride(from: 0, to: raw.count, by: 2).map {
            UInt16(raw[$0]) | UInt16(raw[$0 + 1]) << 8
        }, as: UTF16.self)
    }

    /// UTF-16LE até o primeiro 0x0000, dentro de `limit` bytes. Devolve o texto
    /// e quantos bytes ocupou (com o terminador).
    func utf16CString(_ offset: Int, limit: Int? = nil) throws -> (String, Int) {
        let end = min(data.count, limit.map { offset + $0 } ?? data.count)
        var units: [UInt16] = []
        var o = offset
        while o + 1 < end {
            let unit = UInt16(data[o]) | UInt16(data[o + 1]) << 8
            o += 2
            if unit == 0 { return (String(decoding: units, as: UTF16.self), o - offset) }
            units.append(unit)
        }
        throw BinaryFormatError.invalid("texto UTF-16 sem terminador em \(offset)")
    }
}

/// Texto "ANSI" do Windows. O Wine usa a página de código do locale (LANG);
/// 1252 cobre os locales ocidentais. Bytes ASCII são iguais em qualquer uma.
func decodeANSI(_ bytes: Data) -> String {
    String(data: bytes, encoding: .windowsCP1252) ?? String(decoding: bytes, as: UTF8.self)
}
