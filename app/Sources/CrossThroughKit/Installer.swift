import Foundation

/// Fases de uma instalação pelo catálogo, para mostrar o progresso.
public enum InstallPhase: Sendable, Equatable {
    case creatingBottle(BottleCreationStep)
    case configuringBottle
    case winetricks([String])
    case downloading(received: Int64, total: Int64?)
    case installing(String)
    case extracting
    case waitingForInstaller
    case creatingShortcut
    case finished

    public var description: String {
        switch self {
        case .creatingBottle(let step): return step.description
        case .configuringBottle: return "Configurando a bottle"
        case .winetricks(let verbs): return "Instalando dependências: \(verbs.joined(separator: ", "))"
        case .downloading(let received, let total):
            let fmt = ByteCountFormatter()
            if let total { return "Baixando: \(fmt.string(fromByteCount: received)) de \(fmt.string(fromByteCount: total))" }
            return "Baixando: \(fmt.string(fromByteCount: received))"
        case .installing(let name): return "Instalando \(name)"
        case .extracting: return "Extraindo os arquivos"
        case .waitingForInstaller: return "Esperando o instalador terminar"
        case .creatingShortcut: return "Criando o atalho"
        case .finished: return "Pronto"
        }
    }

    /// Fração concluída, quando a fase sabe (só o download sabe).
    public var fraction: Double? {
        if case .downloading(let received, let total?) = self, total > 0 { return Double(received) / Double(total) }
        return nil
    }
}

public enum InstallTarget: Sendable {
    case newBottle(name: String)
    case existing(Bottle)
}

public enum InstallError: LocalizedError, Equatable {
    case installerFailed(recipe: String, status: Int32, log: String)
    case shortcutTargetMissing(recipe: String, target: String)
    case extractFailed(recipe: String, log: String)

    public var errorDescription: String? {
        switch self {
        case .installerFailed(let recipe, let status, let log):
            return "O instalador de \(recipe) terminou com código \(status). Detalhes em \(log)."
        case .shortcutTargetMissing(let recipe, let target):
            return "A instalação de \(recipe) terminou, mas \(target) não existe na bottle."
        case .extractFailed(let recipe, let log):
            return "Não foi possível extrair o arquivo de \(recipe). Detalhes em \(log)."
        }
    }
}

/// Instala uma receita do catálogo numa bottle nova ou existente.
public struct Installer: Sendable {
    public let runtime: Runtime
    public let store: BottleStore

    public init(runtime: Runtime, store: BottleStore) {
        self.runtime = runtime
        self.store = store
    }

    /// Códigos de saída de instalador que significam sucesso: 0, e 3010/1641
    /// (o Windows Installer pedindo reinício, que numa bottle não faz falta).
    static let successStatuses: Set<Int32> = [0, 1641, 3010]

    /// Numa bottle nova, a receita define versão do Windows, backend e msync.
    /// Numa existente, só soma variáveis e ordem de DLLs: o resto da bottle é
    /// de quem já a usa. Se a instalação falhar numa bottle nova, ela vai para o Lixo.
    public func install(_ recipe: Recipe, into target: InstallTarget,
                        progress: (@Sendable (InstallPhase) -> Void)? = nil) async throws -> Bottle {
        let spec = recipe.bottle
        var bottle: Bottle
        let isNew: Bool
        switch target {
        case .newBottle(let name):
            bottle = try await store.create(name: name,
                                            windowsVersion: spec?.windowsVersion ?? .wineDefault,
                                            graphics: spec?.graphics ?? .dxmt,
                                            runtime: runtime) { progress?(.creatingBottle($0)) }
            isNew = true
        case .existing(let existing):
            bottle = existing
            isNew = false
        }

        do {
            progress?(.configuringBottle)
            try bottle.update { config in
                if let env = spec?.environment { config.environment.merge(env) { _, new in new } }
                if let overrides = spec?.dllOverrides { config.dllOverrides.merge(overrides) { _, new in new } }
                if isNew, let msync = spec?.msync { config.msync = msync }
            }
            let wine = Wine(runtime: runtime, bottle: bottle)
            let log = Logs.newLog(for: bottle, named: "instalação \(recipe.id)")

            let installed = Set(Winetricks.installedVerbs(in: bottle))
            let pending = recipe.winetricks.filter { !installed.contains($0) }
            if !pending.isEmpty {
                progress?(.winetricks(pending))
                try await Winetricks(wine: wine).run(pending, log: log)
            }

            if let download = recipe.download {
                let file = try await Downloader.fetch(download, folder: recipe.id) { received, total in
                    progress?(.downloading(received: received, total: total))
                }
                switch recipe.install {
                case .run(let arguments):
                    progress?(.installing(recipe.name))
                    try await runInstaller(recipe, wine: wine, [file.path] + arguments, in: file, log: log)
                case .msi(let arguments):
                    progress?(.installing(recipe.name))
                    try await runInstaller(recipe, wine: wine, ["msiexec", "/i", file.path] + arguments, in: file, log: log)
                case .extract(let destination, let strip):
                    progress?(.extracting)
                    try await extract(recipe, zip: file, to: destination, stripTopLevel: strip, bottle: bottle, log: log)
                case .none:
                    break
                }
                progress?(.waitingForInstaller)
                // Instaladores deixam filhos rodando (msiexec, o instalador de verdade
                // depois do que se extrai). Espera esses, sem matar nada: o explorer.exe
                // que alguns deixam aberto não conta, e se o programa abriu sozinho no
                // fim, ele continua aberto.
                try await wine.waitForPrograms(timeout: .seconds(1800))
            }

            if let shortcut = recipe.shortcut {
                progress?(.creatingShortcut)
                try createShortcut(shortcut, recipe: recipe, in: bottle)
            }

            try bottle.update { config in
                if !config.recipes.contains(recipe.id) { config.recipes.append(recipe.id) }
            }
            progress?(.finished)
            return bottle
        } catch {
            if isNew { try? await store.delete(bottle, runtime: runtime) }
            throw error
        }
    }

    private func runInstaller(_ recipe: Recipe, wine: Wine, _ arguments: [String], in file: URL, log: URL) async throws {
        let result = try await wine.run(arguments, workingDirectory: file.deletingLastPathComponent(), log: log)
        guard Self.successStatuses.contains(result.status) else {
            throw InstallError.installerFailed(recipe: recipe.name, status: result.status, log: log.path)
        }
    }

    /// Extrai o .zip com o `ditto` do macOS num temporário dentro da bottle e
    /// move o conteúdo para o destino (substituindo o que já existir).
    func extract(_ recipe: Recipe, zip: URL, to destination: String, stripTopLevel: Bool,
                 bottle: Bottle, log: URL) async throws {
        guard let target = bottle.unixPath(forWindowsPath: destination) else {
            throw BottleError.incomplete(name: bottle.name, missing: destination)
        }
        let fm = FileManager.default
        let temp = bottle.driveC.appending(path: ".crossthrough-extract-\(UUID().uuidString)")
        try fm.createDirectory(at: temp, withIntermediateDirectories: true)
        defer { try? fm.removeItem(at: temp) }
        let result = try await Wine.execute(URL(fileURLWithPath: "/usr/bin/ditto"), ["-x", "-k", zip.path, temp.path],
                                            environment: ["PATH": "/usr/bin:/bin"], workingDirectory: temp,
                                            log: log, timeout: .seconds(600), onTimeout: nil)
        guard result.succeeded else { throw InstallError.extractFailed(recipe: recipe.name, log: log.path) }

        var source = temp
        let items = try fm.contentsOfDirectory(atPath: temp.path).filter { $0 != "__MACOSX" && !$0.hasPrefix(".") }
        if stripTopLevel, items.count == 1 {
            var isDirectory: ObjCBool = false
            let only = temp.appending(path: items[0])
            if fm.fileExists(atPath: only.path, isDirectory: &isDirectory), isDirectory.boolValue { source = only }
        }
        try fm.createDirectory(at: target, withIntermediateDirectories: true)
        for item in try fm.contentsOfDirectory(atPath: source.path) where item != "__MACOSX" {
            let destinationItem = target.appending(path: item)
            if fm.fileExists(atPath: destinationItem.path) { try fm.removeItem(at: destinationItem) }
            try fm.moveItem(at: source.appending(path: item), to: destinationItem)
        }
    }

    /// Grava o atalho no Menu Iniciar de todos os usuários da bottle.
    func createShortcut(_ shortcut: Recipe.Shortcut, recipe: Recipe, in bottle: Bottle) throws {
        guard bottle.existingUnixPath(forWindowsPath: shortcut.target) != nil else {
            throw InstallError.shortcutTargetMissing(recipe: recipe.name, target: shortcut.target)
        }
        let target = bottle.expandEnvironment(shortcut.target)
        let workingDirectory = shortcut.workingDirectory.map(bottle.expandEnvironment)
            ?? String(target[..<(target.lastIndex(of: "\\") ?? target.endIndex)])
        let data = ShellLink.make(target: target, workingDirectory: workingDirectory,
                                  arguments: shortcut.arguments, iconLocation: target)
        let dir = bottle.driveC.appending(path: "ProgramData/Microsoft/Windows/Start Menu/Programs")
        try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        try data.write(to: dir.appending(path: "\(shortcut.name).lnk"), options: .atomic)
    }
}
