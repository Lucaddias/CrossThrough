import Foundation

/// Versão do Windows que a bottle informa aos programas. Os valores são os
/// nomes que o `winecfg /v` do Wine 11 aceita.
public enum WindowsVersion: String, Codable, CaseIterable, Sendable, Identifiable {
    case win11, win10, win81, win8, win7, vista, winxp

    public var id: String { rawValue }

    public var displayName: String {
        switch self {
        case .win11: return "Windows 11"
        case .win10: return "Windows 10"
        case .win81: return "Windows 8.1"
        case .win8: return "Windows 8"
        case .win7: return "Windows 7"
        case .vista: return "Windows Vista"
        case .winxp: return "Windows XP"
        }
    }

    /// A versão que o `wineboot --init` do Wine 11 já configura.
    public static let wineDefault: WindowsVersion = .win10
}

/// Configuração própria do CrossThrough, em `<bottle>/crossthrough.json`.
public struct BottleConfig: Codable, Sendable, Hashable {
    public static let currentFormat = 1

    public var formatVersion: Int
    public var windowsVersion: WindowsVersion
    public var graphics: GraphicsBackend
    /// Sincronização via Mach (msync): bem mais rápida em jogos. `WINEMSYNC=1`.
    public var msync: Bool
    /// Ordem de carga extra por DLL, ex.: ["xinput1_3": "n,b"].
    public var dllOverrides: [String: String]
    /// Variáveis de ambiente extras para tudo o que roda nesta bottle.
    public var environment: [String: String]
    public var created: Date
    /// Versão do Wine que criou a bottle (`runtime.json`, campo `wine`).
    public var createdWith: String?
    /// Quando um prefixo de outro programa passou a ser esta bottle (nil se
    /// ela foi criada aqui).
    public var adopted: Date?
    /// Receitas do catálogo instaladas nesta bottle (ids).
    public var recipes: [String]

    public init(windowsVersion: WindowsVersion = .win10,
                graphics: GraphicsBackend = .dxmt,
                msync: Bool = true,
                dllOverrides: [String: String] = [:],
                environment: [String: String] = [:],
                created: Date = Date(),
                createdWith: String? = nil,
                adopted: Date? = nil,
                recipes: [String] = []) {
        self.formatVersion = Self.currentFormat
        self.windowsVersion = windowsVersion
        self.graphics = graphics
        self.msync = msync
        self.dllOverrides = dllOverrides
        self.environment = environment
        // O JSON guarda segundos inteiros (ISO 8601): truncar aqui faz a config
        // salva e a relida serem iguais.
        self.created = Date(timeIntervalSince1970: created.timeIntervalSince1970.rounded(.down))
        self.createdWith = createdWith
        self.adopted = adopted.map { Date(timeIntervalSince1970: $0.timeIntervalSince1970.rounded(.down)) }
        self.recipes = recipes
    }

    // Campos ausentes (arquivo de uma versão anterior) recebem o padrão.
    public init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        let defaults = BottleConfig()
        formatVersion = try c.decodeIfPresent(Int.self, forKey: .formatVersion) ?? Self.currentFormat
        windowsVersion = try c.decodeIfPresent(WindowsVersion.self, forKey: .windowsVersion) ?? defaults.windowsVersion
        graphics = try c.decodeIfPresent(GraphicsBackend.self, forKey: .graphics) ?? defaults.graphics
        msync = try c.decodeIfPresent(Bool.self, forKey: .msync) ?? defaults.msync
        dllOverrides = try c.decodeIfPresent([String: String].self, forKey: .dllOverrides) ?? [:]
        environment = try c.decodeIfPresent([String: String].self, forKey: .environment) ?? [:]
        created = try c.decodeIfPresent(Date.self, forKey: .created) ?? Date(timeIntervalSince1970: 0)
        createdWith = try c.decodeIfPresent(String.self, forKey: .createdWith)
        adopted = try c.decodeIfPresent(Date.self, forKey: .adopted)
        recipes = try c.decodeIfPresent([String].self, forKey: .recipes) ?? []
    }

    static func decoder() -> JSONDecoder {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601
        return d
    }

    static func encoder() -> JSONEncoder {
        let e = JSONEncoder()
        e.dateEncodingStrategy = .iso8601
        e.outputFormatting = [.prettyPrinted, .sortedKeys]
        return e
    }
}

public enum BottleError: LocalizedError, Equatable {
    case invalidName(String, reason: String)
    case alreadyExists(String)
    case notFound(String)
    case incomplete(name: String, missing: String)
    case commandFailed(command: String, status: Int32, log: String?)

    public var errorDescription: String? {
        switch self {
        case .invalidName(let name, let reason): return "“\(name)” não serve como nome de bottle: \(reason)."
        case .alreadyExists(let name): return "Já existe uma bottle chamada “\(name)”."
        case .notFound(let name): return "A bottle “\(name)” não existe."
        case .incomplete(let name, let missing): return "A bottle “\(name)” está incompleta (falta \(missing))."
        case .commandFailed(let command, let status, let log):
            var text = "\(command) terminou com código \(status)."
            if let log { text += " Detalhes em \(log)." }
            return text
        }
    }
}

/// Uma bottle: um prefixo do Wine (o próprio diretório) com o nosso `crossthrough.json`.
public struct Bottle: Sendable, Hashable, Identifiable {
    public let url: URL
    public var config: BottleConfig

    public init(url: URL, config: BottleConfig) {
        self.url = url.standardizedFileURL
        self.config = config
    }

    public var id: String { url.path }
    public var name: String { url.lastPathComponent }
    public var configURL: URL { Self.configURL(in: url) }
    public var driveC: URL { url.appending(path: "drive_c") }
    public var windowsDirectory: URL { driveC.appending(path: "windows") }

    static func configURL(in url: URL) -> URL { url.appending(path: "crossthrough.json") }

    /// Lê a bottle de um diretório; nil se ele não for uma bottle do CrossThrough.
    public static func load(from url: URL) throws -> Bottle? {
        let configURL = configURL(in: url)
        guard FileManager.default.fileExists(atPath: configURL.path) else { return nil }
        let config = try BottleConfig.decoder().decode(BottleConfig.self, from: Data(contentsOf: configURL))
        return Bottle(url: url, config: config)
    }

    /// Grava `crossthrough.json` de forma atômica.
    public func save() throws {
        try BottleConfig.encoder().encode(config).write(to: configURL, options: .atomic)
    }

    /// Caminho Windows (`C:\...`, `Z:\...`) para o caminho Unix correspondente,
    /// pelos links de `dosdevices`. Não confere se o arquivo existe.
    public func unixPath(forWindowsPath windowsPath: String) -> URL? {
        let path = windowsPath.replacingOccurrences(of: "/", with: "\\")
        guard path.count >= 2, path.dropFirst().first == ":",
              let letter = path.first?.lowercased(), ("a"..."z").contains(letter) else { return nil }
        let drive = url.appending(path: "dosdevices/\(letter):").resolvingSymlinksInPath()
        let rest = path.dropFirst(2).split(separator: "\\").map(String.init)
        return rest.reduce(drive) { $0.appending(path: $1) }
    }

    /// Como `unixPath(forWindowsPath:)`, mas expande `%VAR%` e só devolve o que
    /// existe. Cada componente é casado sem diferenciar maiúsculas, como no
    /// Windows (o volume do Mac pode diferenciar), e links e junções do NTFS
    /// que o Wine gravou são seguidos como ele segue.
    public func existingUnixPath(forWindowsPath windowsPath: String) -> URL? {
        resolve(expandEnvironment(windowsPath), hops: 0)
    }

    private func resolve(_ windowsPath: String, hops: Int) -> URL? {
        let path = windowsPath.replacingOccurrences(of: "/", with: "\\")
        guard path.count >= 2, path.dropFirst().first == ":",
              let letter = path.first?.lowercased(), ("a"..."z").contains(letter) else { return nil }
        var current = url.appending(path: "dosdevices/\(letter):").resolvingSymlinksInPath()
        guard FileManager.default.fileExists(atPath: current.path) else { return nil }
        let components = path.dropFirst(2).split(separator: "\\").map(String.init)
        var walked: [String] = []
        for (i, component) in components.enumerated() {
            if component == "." { continue }
            if component == ".." {
                if !walked.isEmpty { walked.removeLast(); current.deleteLastPathComponent() }
                continue
            }
            if let match = Self.entry(named: component, in: current) {
                current = current.appending(path: match)
                walked.append(component)
                continue
            }
            // Um ponto de reparse: "<nome>?" com o destino no atributo estendido.
            guard hops < ReparsePoint.maximumHops, let match = Self.entry(named: component + "?", in: current),
                  let reparse = ReparsePoint(contentsOf: current.appending(path: match)) else { return nil }
            let rest = components[(i + 1)...]
            switch reparse.target {
            case .relative(let target):
                let parent = "\(letter):\\" + walked.joined(separator: "\\")
                return resolve(([parent, target] + rest).joined(separator: "\\"), hops: hops + 1)
            case .absolute(let target):
                return resolve(([target] + rest).joined(separator: "\\"), hops: hops + 1)
            }
        }
        return current
    }

    /// O nome do item em `directory` igual a `name` sem diferenciar maiúsculas.
    private static func entry(named name: String, in directory: URL) -> String? {
        let fm = FileManager.default
        if fm.fileExists(atPath: directory.appending(path: name).path) { return name }
        let lower = name.lowercased()
        return (try? fm.contentsOfDirectory(atPath: directory.path))?.first { $0.lowercased() == lower }
    }

    /// O usuário do Windows da bottle. O Wine usa o nome do usuário do macOS
    /// que criou a bottle; se ela veio de outro usuário, vale o diretório que existe.
    public var windowsUserName: String {
        let users = driveC.appending(path: "users")
        let me = NSUserName()
        if FileManager.default.fileExists(atPath: users.appending(path: me).path) { return me }
        let others = ((try? FileManager.default.contentsOfDirectory(atPath: users.path)) ?? [])
            .filter { $0 != "Public" && !$0.hasPrefix(".") }.sorted()
        return others.first ?? me
    }

    /// As variáveis de ambiente do Windows que aparecem em caminhos de atalhos,
    /// com os valores de uma bottle de 64 bits do Wine. Chaves em maiúsculas.
    public var windowsEnvironment: [String: String] {
        let profile = "C:\\users\\\(windowsUserName)"
        return [
            "SYSTEMDRIVE": "C:", "HOMEDRIVE": "C:",
            "SYSTEMROOT": "C:\\windows", "WINDIR": "C:\\windows",
            "PROGRAMFILES": "C:\\Program Files", "PROGRAMW6432": "C:\\Program Files",
            "PROGRAMFILES(X86)": "C:\\Program Files (x86)",
            "COMMONPROGRAMFILES": "C:\\Program Files\\Common Files",
            "COMMONPROGRAMW6432": "C:\\Program Files\\Common Files",
            "COMMONPROGRAMFILES(X86)": "C:\\Program Files (x86)\\Common Files",
            "PROGRAMDATA": "C:\\ProgramData", "ALLUSERSPROFILE": "C:\\ProgramData",
            "PUBLIC": "C:\\users\\Public",
            "USERPROFILE": profile, "HOMEPATH": "\\users\\\(windowsUserName)",
            "APPDATA": profile + "\\AppData\\Roaming",
            "LOCALAPPDATA": profile + "\\AppData\\Local",
            "TEMP": profile + "\\AppData\\Local\\Temp", "TMP": profile + "\\AppData\\Local\\Temp",
            "USERNAME": windowsUserName,
        ]
    }

    /// Troca `%VAR%` pelos valores de `windowsEnvironment`; as desconhecidas ficam como estão.
    public func expandEnvironment(_ text: String) -> String {
        guard text.contains("%") else { return text }
        let env = windowsEnvironment
        var result = ""
        var rest = Substring(text)
        while let start = rest.firstIndex(of: "%") {
            result += rest[..<start]
            let afterStart = rest.index(after: start)
            guard let end = rest[afterStart...].firstIndex(of: "%") else { result += rest[start...]; return result }
            let name = String(rest[afterStart..<end])
            if let value = env[name.uppercased()] {
                result += value
            } else {
                result += rest[start...end]
            }
            rest = rest[rest.index(after: end)...]
        }
        return result + rest
    }

    /// Caminho Unix para Windows. Dentro de drive_c vira `C:\...`; fora, `Z:\...`.
    public func windowsPath(forUnixPath unix: URL) -> String {
        let path = unix.standardizedFileURL.resolvingSymlinksInPath().path
        let driveCPath = driveC.resolvingSymlinksInPath().path
        if path == driveCPath { return "C:\\" } // "C:" sozinho é o diretório atual do drive, não a raiz
        if path.hasPrefix(driveCPath + "/") {
            return "C:" + path.dropFirst(driveCPath.count).replacingOccurrences(of: "/", with: "\\")
        }
        return "Z:" + path.replacingOccurrences(of: "/", with: "\\")
    }
}
