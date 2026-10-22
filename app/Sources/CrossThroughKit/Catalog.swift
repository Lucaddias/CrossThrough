import Foundation

/// Uma receita do catálogo: como instalar um programa numa bottle.
///
/// O formato é o de catalog/catalog.json (ver catalog/README.md). Toda receita
/// do catálogo do projeto foi instalada e aberta de verdade antes de entrar.
public struct Recipe: Codable, Sendable, Hashable, Identifiable {
    public enum Category: String, Codable, Sendable, CaseIterable {
        case games, launchers, productivity, utilities, development, multimedia, internet

        public var displayName: String {
            switch self {
            case .games: return "Jogos"
            case .launchers: return "Lojas e launchers"
            case .productivity: return "Produtividade"
            case .utilities: return "Utilitários"
            case .development: return "Desenvolvimento"
            case .multimedia: return "Multimídia"
            case .internet: return "Internet"
            }
        }
    }

    /// Configuração da bottle que a receita pede.
    public struct BottleSpec: Codable, Sendable, Hashable {
        public var windowsVersion: WindowsVersion?
        public var graphics: GraphicsBackend?
        public var msync: Bool?
        public var environment: [String: String]?
        public var dllOverrides: [String: String]?

        public init(windowsVersion: WindowsVersion? = nil, graphics: GraphicsBackend? = nil, msync: Bool? = nil,
                    environment: [String: String]? = nil, dllOverrides: [String: String]? = nil) {
            self.windowsVersion = windowsVersion
            self.graphics = graphics
            self.msync = msync
            self.environment = environment
            self.dllOverrides = dllOverrides
        }
    }

    public struct Download: Codable, Sendable, Hashable {
        public var url: URL
        /// Ausente só para instaladores que o fabricante troca no mesmo endereço
        /// (aí vale o TLS); sempre que possível a receita fixa o arquivo.
        public var sha256: String?
        public var fileName: String?

        public init(url: URL, sha256: String? = nil, fileName: String? = nil) {
            self.url = url
            self.sha256 = sha256
            self.fileName = fileName
        }

        public var resolvedFileName: String {
            if let fileName, !fileName.isEmpty { return fileName }
            let last = url.lastPathComponent
            return last.isEmpty || last == "/" ? "download" : last
        }
    }

    /// O que fazer com o arquivo baixado.
    public enum InstallStep: Sendable, Hashable {
        /// Roda o .exe baixado (ex.: argumentos de instalação silenciosa).
        case run(arguments: [String])
        /// `msiexec /i <arquivo> <argumentos>`.
        case msi(arguments: [String])
        /// Extrai um .zip em `destination` (caminho Windows). Com `stripTopLevel`,
        /// a pasta única do zip some e o conteúdo vai direto para o destino.
        case extract(destination: String, stripTopLevel: Bool)
        /// Nada a instalar além do winetricks.
        case none
    }

    /// Atalho criado no Menu Iniciar depois de instalar, para programas que não
    /// criam o seu (ex.: um zip extraído).
    public struct Shortcut: Codable, Sendable, Hashable {
        public var name: String
        /// Caminho Windows do executável.
        public var target: String
        public var arguments: String?
        public var workingDirectory: String?
    }

    public var id: String
    public var name: String
    public var summary: String
    public var category: Category
    public var homepage: URL?
    public var license: String?
    public var bottle: BottleSpec?
    public var winetricks: [String]
    public var download: Download?
    public var install: InstallStep
    public var shortcut: Shortcut?
    /// Avisos para o usuário (limitações conhecidas no Wine).
    public var notes: String?

    public init(id: String, name: String, summary: String, category: Category, homepage: URL? = nil,
                license: String? = nil, bottle: BottleSpec? = nil, winetricks: [String] = [],
                download: Download? = nil, install: InstallStep = .none, shortcut: Shortcut? = nil,
                notes: String? = nil) {
        self.id = id
        self.name = name
        self.summary = summary
        self.category = category
        self.homepage = homepage
        self.license = license
        self.bottle = bottle
        self.winetricks = winetricks
        self.download = download
        self.install = install
        self.shortcut = shortcut
        self.notes = notes
    }

    private enum CodingKeys: String, CodingKey {
        case id, name, summary, category, homepage, license, bottle, winetricks, download, install, shortcut, notes
    }

    public init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decode(String.self, forKey: .id)
        name = try c.decode(String.self, forKey: .name)
        summary = try c.decode(String.self, forKey: .summary)
        category = try c.decode(Category.self, forKey: .category)
        homepage = try c.decodeIfPresent(URL.self, forKey: .homepage)
        license = try c.decodeIfPresent(String.self, forKey: .license)
        bottle = try c.decodeIfPresent(BottleSpec.self, forKey: .bottle)
        winetricks = try c.decodeIfPresent([String].self, forKey: .winetricks) ?? []
        download = try c.decodeIfPresent(Download.self, forKey: .download)
        install = try c.decodeIfPresent(InstallStep.self, forKey: .install) ?? .none
        shortcut = try c.decodeIfPresent(Shortcut.self, forKey: .shortcut)
        notes = try c.decodeIfPresent(String.self, forKey: .notes)
    }
}

extension Recipe.InstallStep: Codable {
    /// O "type" do JSON.
    public var kind: String {
        switch self {
        case .run: return "run"
        case .msi: return "msi"
        case .extract: return "extract"
        case .none: return "none"
        }
    }

    private enum CodingKeys: String, CodingKey { case type, arguments, destination, stripTopLevel }

    public init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        let type = try c.decode(String.self, forKey: .type)
        switch type {
        case "run": self = .run(arguments: try c.decodeIfPresent([String].self, forKey: .arguments) ?? [])
        case "msi": self = .msi(arguments: try c.decodeIfPresent([String].self, forKey: .arguments) ?? [])
        case "extract":
            self = .extract(destination: try c.decode(String.self, forKey: .destination),
                            stripTopLevel: try c.decodeIfPresent(Bool.self, forKey: .stripTopLevel) ?? false)
        case "none": self = .none
        default:
            throw DecodingError.dataCorruptedError(forKey: .type, in: c,
                                                   debugDescription: "tipo de instalação desconhecido: \(type)")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .run(let arguments):
            try c.encode("run", forKey: .type)
            if !arguments.isEmpty { try c.encode(arguments, forKey: .arguments) }
        case .msi(let arguments):
            try c.encode("msi", forKey: .type)
            if !arguments.isEmpty { try c.encode(arguments, forKey: .arguments) }
        case .extract(let destination, let strip):
            try c.encode("extract", forKey: .type)
            try c.encode(destination, forKey: .destination)
            if strip { try c.encode(true, forKey: .stripTopLevel) }
        case .none:
            try c.encode("none", forKey: .type)
        }
    }
}

/// O catálogo de receitas.
public struct Catalog: Codable, Sendable {
    public static let currentFormat = 1

    public var formatVersion: Int
    public var recipes: [Recipe]

    public init(recipes: [Recipe]) {
        formatVersion = Self.currentFormat
        self.recipes = recipes
    }

    public func recipe(id: String) -> Recipe? { recipes.first { $0.id == id } }

    public static func load(from url: URL) throws -> Catalog {
        let catalog = try JSONDecoder().decode(Catalog.self, from: Data(contentsOf: url))
        guard catalog.formatVersion <= currentFormat else {
            throw CatalogError.unsupportedFormat(catalog.formatVersion)
        }
        return catalog
    }

    /// O catálogo que vem com o app: `Contents/Resources/catalog.json`, o que fica
    /// ao lado do CLI dentro do app, ou `catalog/catalog.json` do repositório
    /// (desenvolvimento). `CROSSTHROUGH_CATALOG` no ambiente tem precedência.
    public static func locate(environment: [String: String] = ProcessInfo.processInfo.environment,
                              bundle: Bundle = .main,
                              executable: URL? = Bundle.main.executableURL) throws -> URL {
        var candidates: [URL] = []
        if let path = environment["CROSSTHROUGH_CATALOG"], !path.isEmpty { candidates.append(URL(fileURLWithPath: path)) }
        if let url = bundle.url(forResource: "catalog", withExtension: "json") { candidates.append(url) }
        if let exe = executable?.resolvingSymlinksInPath() {
            candidates.append(exe.deletingLastPathComponent().deletingLastPathComponent()
                .appending(path: "Resources/catalog.json"))
            var dir = exe.deletingLastPathComponent()
            for _ in 0..<6 {
                candidates.append(dir.appending(path: "catalog/catalog.json"))
                dir = dir.deletingLastPathComponent()
            }
        }
        if let found = candidates.first(where: { FileManager.default.fileExists(atPath: $0.path) }) { return found }
        throw CatalogError.notFound(searched: candidates.map(\.path))
    }

    /// Problemas de consistência (ids repetidos, receitas sem o que instalar,
    /// SHA-256 malformado, verbos que o winetricks do runtime não conhece).
    public func problems(knownVerbs: Set<String>? = nil) -> [String] {
        var problems: [String] = []
        var ids = Set<String>()
        for r in recipes {
            if !ids.insert(r.id).inserted { problems.append("\(r.id): id repetido") }
            if r.id.range(of: #"^[a-z0-9][a-z0-9-]*$"#, options: .regularExpression) == nil {
                problems.append("\(r.id): id deve ter só a-z, 0-9 e hífen")
            }
            switch r.install {
            case .run, .msi, .extract:
                if r.download == nil { problems.append("\(r.id): instalação \(r.install.kind) sem download") }
            case .none:
                if r.winetricks.isEmpty { problems.append("\(r.id): não instala nada") }
            }
            if let sha = r.download?.sha256, sha.range(of: #"^[0-9a-f]{64}$"#, options: .regularExpression) == nil {
                problems.append("\(r.id): sha256 inválido")
            }
            if r.download?.url.scheme != nil && r.download?.url.scheme != "https" {
                problems.append("\(r.id): download sem HTTPS")
            }
            if let knownVerbs {
                for verb in r.winetricks where !knownVerbs.contains(verb) {
                    problems.append("\(r.id): verbo do winetricks desconhecido: \(verb)")
                }
            }
        }
        return problems
    }
}

public enum CatalogError: LocalizedError, Equatable {
    case notFound(searched: [String])
    case unsupportedFormat(Int)
    case unknownRecipe(String)

    public var errorDescription: String? {
        switch self {
        case .notFound(let searched): return "O catálogo não foi encontrado. Procurado em: \(searched.joined(separator: ", "))."
        case .unsupportedFormat(let v): return "O catálogo está no formato \(v), mais novo que este app."
        case .unknownRecipe(let id): return "Não há receita “\(id)” no catálogo."
        }
    }
}
