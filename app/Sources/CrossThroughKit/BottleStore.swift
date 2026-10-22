import Foundation

/// Etapas da criação de uma bottle, para mostrar o progresso.
public enum BottleCreationStep: Sendable, Equatable {
    /// `wineboot --init`: registro, system32/syswow64, Mono e Gecko. A mais demorada.
    case initializing
    case configuringWindows(WindowsVersion)
    case installingGraphics(GraphicsBackend)
    case finishing

    public var description: String {
        switch self {
        case .initializing: return "Criando o Windows da bottle"
        case .configuringWindows(let v): return "Configurando como \(v.displayName)"
        case .installingGraphics(let g): return "Instalando o backend gráfico \(g.displayName)"
        case .finishing: return "Concluindo"
        }
    }
}

/// O diretório onde ficam as bottles. Cada subdiretório com `crossthrough.json`
/// é uma bottle; o arquivo é gravado por último na criação, então uma criação
/// interrompida nunca aparece como bottle.
public struct BottleStore: Sendable {
    public let root: URL

    public static var defaultRoot: URL {
        FileManager.default.homeDirectoryForCurrentUser
            .appending(path: "Library/Application Support/CrossThrough/Bottles")
    }

    public init(root: URL = BottleStore.defaultRoot) {
        self.root = root.standardizedFileURL
    }

    public func url(for name: String) -> URL { root.appending(path: name, directoryHint: .isDirectory) }

    /// As bottles, em ordem de nome. Um diretório com `crossthrough.json`
    /// ilegível entra em `damaged`, não some em silêncio.
    public func scan() throws -> (bottles: [Bottle], damaged: [(name: String, error: Error)]) {
        let fm = FileManager.default
        guard fm.fileExists(atPath: root.path) else { return ([], []) }
        var bottles: [Bottle] = []
        var damaged: [(String, Error)] = []
        let entries = try fm.contentsOfDirectory(at: root, includingPropertiesForKeys: [.isDirectoryKey],
                                                 options: [.skipsHiddenFiles])
        for entry in entries where (try? entry.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) == true {
            do {
                if let bottle = try Bottle.load(from: entry) { bottles.append(bottle) }
            } catch {
                damaged.append((entry.lastPathComponent, error))
            }
        }
        bottles.sort { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
        return (bottles, damaged)
    }

    public func list() throws -> [Bottle] { try scan().bottles }

    public func bottle(named name: String) throws -> Bottle {
        guard let bottle = try Bottle.load(from: url(for: name)) else { throw BottleError.notFound(name) }
        return bottle
    }

    /// Regras de nome: vira nome de diretório e aparece no Finder e nos logs.
    public static func validateName(_ name: String) throws {
        func invalid(_ reason: String) -> BottleError { .invalidName(name, reason: reason) }
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { throw invalid("o nome está vazio") }
        if name != name.trimmingCharacters(in: .whitespaces) { throw invalid("começa ou termina com espaço") }
        if name.count > 64 { throw invalid("tem mais de 64 caracteres") }
        if name.hasPrefix(".") { throw invalid("começa com ponto") }
        if name.contains("/") || name.contains(":") { throw invalid("tem “/” ou “:”") }
        if name.unicodeScalars.contains(where: { CharacterSet.controlCharacters.contains($0) }) {
            throw invalid("tem caracteres de controle")
        }
    }

    /// Um nome livre a partir de `base`: "Jogos", "Jogos 2", "Jogos 3"...
    public func availableName(base: String) -> String {
        let fm = FileManager.default
        if !fm.fileExists(atPath: url(for: base).path) { return base }
        var n = 2
        while fm.fileExists(atPath: url(for: "\(base) \(n)").path) { n += 1 }
        return "\(base) \(n)"
    }

    /// Cria e inicializa uma bottle. Em caso de falha não sobra nada no disco
    /// (o log da tentativa fica em ~/Library/Logs/CrossThrough/<nome>/).
    public func create(name: String,
                       windowsVersion: WindowsVersion = .wineDefault,
                       graphics: GraphicsBackend = .dxmt,
                       runtime: Runtime,
                       progress: (@Sendable (BottleCreationStep) -> Void)? = nil) async throws -> Bottle {
        try Self.validateName(name)
        let fm = FileManager.default
        let url = url(for: name)
        if fm.fileExists(atPath: url.path) { throw BottleError.alreadyExists(name) }
        try fm.createDirectory(at: root, withIntermediateDirectories: true)
        // Sem intermediários: falha se outra criação chegou primeiro.
        try fm.createDirectory(at: url, withIntermediateDirectories: false)

        let config = BottleConfig(windowsVersion: windowsVersion, graphics: graphics,
                                  createdWith: runtime.manifest.wine)
        let bottle = Bottle(url: url, config: config)
        let wine = Wine(runtime: runtime, bottle: bottle)
        let log = Logs.newLog(for: bottle, named: "criação")
        do {
            progress?(.initializing)
            let boot = try await wine.run(["wineboot", "--init"], workingDirectory: url, log: log,
                                          timeout: .seconds(600))
            guard boot.succeeded else {
                throw BottleError.commandFailed(command: "wineboot --init", status: boot.status, log: log.path)
            }
            try await wine.waitForAll(timeout: .seconds(300))
            for sys in ["system32/kernel32.dll", "syswow64/kernel32.dll"]
            where !fm.fileExists(atPath: bottle.windowsDirectory.appending(path: sys).path) {
                throw BottleError.incomplete(name: name, missing: "windows/\(sys)")
            }

            if windowsVersion != .wineDefault {
                progress?(.configuringWindows(windowsVersion))
                try await Self.applyWindowsVersion(windowsVersion, wine: wine, log: log)
            }

            progress?(.installingGraphics(graphics))
            try graphics.install(in: bottle, runtime: runtime)

            progress?(.finishing)
            try bottle.save()
            return bottle
        } catch {
            try? await wine.stopAll()
            try? fm.removeItem(at: url)
            throw error
        }
    }

    /// Encerra tudo o que roda na bottle e a manda para o Lixo (recuperável).
    public func delete(_ bottle: Bottle, runtime: Runtime) async throws {
        try? await Wine(runtime: runtime, bottle: bottle).stopAll()
        try FileManager.default.trashItem(at: bottle.url, resultingItemURL: nil)
    }

    /// Renomeia o diretório (e o dos logs). Os programas da bottle precisam
    /// estar fechados: o wineserver guarda o diretório aberto.
    public func rename(_ bottle: Bottle, to newName: String, runtime: Runtime) async throws -> Bottle {
        if newName == bottle.name { return bottle }
        try Self.validateName(newName)
        let fm = FileManager.default
        let target = url(for: newName)
        // Só muda maiúsculas/minúsculas: no APFS o destino "existe" (é o mesmo diretório).
        let sameDirectory = newName.lowercased() == bottle.name.lowercased()
        if fm.fileExists(atPath: target.path) && !sameDirectory { throw BottleError.alreadyExists(newName) }
        try await Wine(runtime: runtime, bottle: bottle).stopAll()
        try fm.moveItem(at: bottle.url, to: target)
        let oldLogs = Logs.directory(for: bottle)
        let renamed = Bottle(url: target, config: bottle.config)
        let newLogs = Logs.directory(for: renamed)
        if fm.fileExists(atPath: oldLogs.path) && !fm.fileExists(atPath: newLogs.path) {
            try? fm.moveItem(at: oldLogs, to: newLogs)
        }
        return renamed
    }

    // MARK: - Configurações

    /// `winecfg /v <versão>` e espera o registro ser gravado.
    static func applyWindowsVersion(_ version: WindowsVersion, wine: Wine, log: URL) async throws {
        let result = try await wine.run(["winecfg", "/v", version.rawValue], log: log, timeout: .seconds(120))
        guard result.succeeded else {
            throw BottleError.commandFailed(command: "winecfg /v \(version.rawValue)", status: result.status, log: log.path)
        }
        try await wine.waitForAll(timeout: .seconds(120))
    }
}

extension Bottle {
    /// Troca o backend gráfico: as DLLs em system32/syswow64 e o crossthrough.json.
    /// Programas abertos continuam com o backend antigo até reabrir.
    public mutating func setGraphics(_ backend: GraphicsBackend, runtime: Runtime) throws {
        try backend.install(in: self, runtime: runtime)
        config.graphics = backend
        try save()
    }

    public mutating func setWindowsVersion(_ version: WindowsVersion, runtime: Runtime) async throws {
        let wine = Wine(runtime: runtime, bottle: self)
        try await BottleStore.applyWindowsVersion(version, wine: wine, log: Logs.newLog(for: self, named: "winecfg"))
        config.windowsVersion = version
        try save()
    }

    /// Grava uma mudança de configuração que não mexe em arquivos do Wine
    /// (msync, variáveis, ordem de carga de DLLs).
    public mutating func update(_ change: (inout BottleConfig) -> Void) throws {
        var copy = config
        change(&copy)
        let previous = config
        config = copy
        do { try save() } catch { config = previous; throw error }
    }
}
