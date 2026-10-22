import Foundation

/// Variáveis de ambiente e ordem de carga de DLLs como texto, uma por linha
/// (`NOME=valor`), para editar numa caixa de texto. Linhas vazias e as que
/// começam com `#` são ignoradas.
public enum ConfigText {
    public enum ParseError: LocalizedError, Equatable {
        case missingEquals(line: Int)
        case invalidName(line: Int, name: String)
        case invalidLoadOrder(line: Int, value: String)

        public var errorDescription: String? {
            switch self {
            case .missingEquals(let line): return "Linha \(line): falta o “=”."
            case .invalidName(let line, let name): return "Linha \(line): “\(name)” não serve como nome."
            case .invalidLoadOrder(let line, let value):
                return "Linha \(line): “\(value)” não é uma ordem de carga (use n, b, n,b, b,n ou vazio para desligar)."
            }
        }
    }

    public static func format(_ values: [String: String]) -> String {
        values.keys.sorted().map { "\($0)=\(values[$0]!)" }.joined(separator: "\n")
    }

    /// `NOME=valor` por linha. O nome não pode ter espaço nem `=`; o valor é o
    /// resto da linha, sem os espaços das pontas.
    public static func parseEnvironment(_ text: String) throws -> [String: String] {
        try parse(text) { name, value, line in
            guard name.range(of: #"^[A-Za-z_][A-Za-z0-9_]*$"#, options: .regularExpression) != nil else {
                throw ParseError.invalidName(line: line, name: name)
            }
            return value
        }
    }

    /// `dll=ordem` por linha, no formato do WINEDLLOVERRIDES: n (nativa),
    /// b (do Wine), as duas em alguma ordem, ou vazio (desligada).
    public static func parseDLLOverrides(_ text: String) throws -> [String: String] {
        try parse(text) { name, value, line in
            let dll = name.lowercased().hasSuffix(".dll") ? String(name.dropLast(4)) : name
            guard dll.range(of: #"^[A-Za-z0-9_.+-]+$"#, options: .regularExpression) != nil else {
                throw ParseError.invalidName(line: line, name: name)
            }
            let order = value.replacingOccurrences(of: " ", with: "").lowercased()
            guard ["", "n", "b", "n,b", "b,n"].contains(order) else {
                throw ParseError.invalidLoadOrder(line: line, value: value)
            }
            return order
        } key: { name in
            name.lowercased().hasSuffix(".dll") ? String(name.dropLast(4)) : name
        }
    }

    private static func parse(_ text: String,
                              value transform: (String, String, Int) throws -> String,
                              key: (String) -> String = { $0 }) throws -> [String: String] {
        var result: [String: String] = [:]
        for (index, raw) in text.components(separatedBy: .newlines).enumerated() {
            let line = raw.trimmingCharacters(in: .whitespaces)
            if line.isEmpty || line.hasPrefix("#") { continue }
            guard let equals = line.firstIndex(of: "=") else { throw ParseError.missingEquals(line: index + 1) }
            let name = line[..<equals].trimmingCharacters(in: .whitespaces)
            let value = line[line.index(after: equals)...].trimmingCharacters(in: .whitespaces)
            result[key(name)] = try transform(name, value, index + 1)
        }
        return result
    }
}
