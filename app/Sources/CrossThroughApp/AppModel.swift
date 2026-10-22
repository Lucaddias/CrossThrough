import AppKit
import CrossThroughKit
import Observation

/// O que está selecionado na barra lateral.
enum SidebarItem: Hashable {
    case catalog
    case bottle(Bottle.ID)
    /// Um prefixo do Wine de outro programa (pelo caminho, como o id da bottle).
    case foreign(ForeignBottle.ID)
}

struct AppAlert: Identifiable {
    let id = UUID()
    var title: String
    var message: String
    var log: URL?

    init(_ title: String, _ error: Error, log: URL? = nil) {
        self.title = title
        self.message = error.localizedDescription
        self.log = log
    }

    init(_ title: String, message: String, log: URL? = nil) {
        self.title = title
        self.message = message
        self.log = log
    }
}

/// Uma tarefa longa (instalar, criar bottle, winetricks, rodar um instalador),
/// mostrada no rodapé da barra lateral.
@MainActor @Observable
final class Job: Identifiable {
    enum State: Equatable {
        case running
        case succeeded
        case failed(String)
        case cancelled
    }

    let id = UUID()
    let title: String
    let bottleID: Bottle.ID?
    let recipeID: String?
    /// O nome da bottle que esta tarefa está criando.
    let creatingBottle: String?
    var detail = ""
    var fraction: Double?
    var state = State.running
    var log: URL?
    fileprivate var task: Task<Void, Never>?

    init(title: String, bottleID: Bottle.ID?, recipeID: String?, creatingBottle: String?) {
        self.title = title
        self.bottleID = bottleID
        self.recipeID = recipeID
        self.creatingBottle = creatingBottle
    }

    var isRunning: Bool { state == .running }

    func cancel() { task?.cancel() }

    /// Atualiza o texto e a fração de qualquer thread, na ordem em que chegam.
    nonisolated func report(_ detail: String, fraction: Double? = nil) {
        DispatchQueue.main.async {
            MainActor.assumeIsolated {
                self.detail = detail
                self.fraction = fraction
            }
        }
    }
}

/// Repassa o progresso de uma instalação para o Job sem inundar a fila
/// principal: o download avisa a cada pedaço recebido.
final class InstallProgress: @unchecked Sendable {
    private let job: Job
    private let lock = NSLock()
    private var last = Date.distantPast

    init(job: Job) { self.job = job }

    func send(_ phase: InstallPhase) {
        if case .downloading = phase {
            let now = Date()
            let due = lock.withLock {
                guard now.timeIntervalSince(last) >= 0.1 else { return false }
                last = now
                return true
            }
            guard due else { return }
        }
        job.report(phase.description, fraction: phase.fraction)
    }
}

/// Um programa aberto pelo app.
struct RunningProgram {
    let process: RunningProcess
    let bottleID: Bottle.ID
    let log: URL
}

/// Estado do app: runtime, catálogo, bottles, programas e tarefas.
@MainActor @Observable
final class AppModel {
    let store: BottleStore
    private(set) var runtime: Runtime?
    private(set) var runtimeProblem: String?
    private(set) var catalog = Catalog(recipes: [])
    private(set) var catalogProblem: String?
    private(set) var bottles: [Bottle] = []
    private(set) var damagedBottles: [String] = []
    private(set) var foreignBottles: [ForeignBottle] = []
    private(set) var programs: [Bottle.ID: [Program]] = [:]
    private(set) var running: [Program.ID: RunningProgram] = [:]
    private(set) var jobs: [Job] = []
    var selection: SidebarItem? = .catalog
    /// A pilha de navegação do catálogo (ids de receitas).
    var catalogPath: [String] = []
    var alert: AppAlert?
    /// Folhas e painéis pedidos pelo menu ou pela barra de ferramentas.
    var presentingNewBottle = false
    var presentingRunFile = false
    var presentingBottleSettings = false
    var presentingWinetricks = false

    @ObservationIgnored private var watcher: DirectoryWatcher?
    @ObservationIgnored private var verbs: [WinetricksVerb]?

    init(environment: [String: String] = ProcessInfo.processInfo.environment) {
        if let path = environment["CROSSTHROUGH_BOTTLES"], !path.isEmpty {
            store = BottleStore(root: URL(fileURLWithPath: path))
        } else {
            store = BottleStore()
        }
        do { runtime = try Runtime.locate() } catch { runtimeProblem = error.localizedDescription }
        do { catalog = try Catalog.load(from: try Catalog.locate()) } catch { catalogProblem = error.localizedDescription }
        try? FileManager.default.createDirectory(at: store.root, withIntermediateDirectories: true)
        watcher = DirectoryWatcher(paths: [store.root]) { [weak self] paths in
            MainActor.assumeIsolated { self?.storeChanged(paths) }
        }
    }

    var verbose: Bool { UserDefaults.standard.bool(forKey: "verboseLogs") }

    func bottle(id: Bottle.ID) -> Bottle? { bottles.first { $0.id == id } }

    func foreignBottle(id: ForeignBottle.ID) -> ForeignBottle? { foreignBottles.first { $0.id == id } }

    var selectedBottle: Bottle? {
        if case .bottle(let id) = selection { return bottle(id: id) }
        return nil
    }

    func bottles(with recipe: Recipe) -> [Bottle] { bottles.filter { $0.config.recipes.contains(recipe.id) } }

    func runningCount(in bottle: Bottle) -> Int { running.values.filter { $0.bottleID == bottle.id }.count }

    func isBusy(_ bottle: Bottle) -> Bool { jobs.contains { $0.isRunning && $0.bottleID == bottle.id } }

    /// A tarefa que roda numa bottle ou num prefixo de fora (pelo id, que é o caminho).
    func job(forBottle id: Bottle.ID) -> Job? { jobs.last { $0.bottleID == id && $0.isRunning } }

    func job(forRecipe id: String) -> Job? { jobs.last { $0.recipeID == id && $0.isRunning } }

    // MARK: - Leitura do disco

    func reload() async {
        let store = self.store
        do {
            let (found, damaged, foreign) = try await Task.detached {
                let scan = try store.scan()
                return (scan.bottles, scan.damaged.map(\.name), scan.foreign)
            }.value
            bottles = found
            damagedBottles = damaged
            // Uma bottle sendo criada aqui já tem registro e disco C: antes do crossthrough.json.
            let creating = Set(jobs.filter(\.isRunning).compactMap(\.creatingBottle))
            foreignBottles = foreign.filter { !creating.contains($0.name) }
        } catch {
            alert = AppAlert("Não foi possível ler as bottles", error)
        }
        let ids = Set(bottles.map(\.id))
        programs = programs.filter { ids.contains($0.key) }
        switch selection {
        case .bottle(let id) where !ids.contains(id):
            selection = foreignBottles.contains { $0.id == id } ? .foreign(id) : .catalog
        case .foreign(let id) where !foreignBottles.contains(where: { $0.id == id }):
            selection = ids.contains(id) ? .bottle(id) : .catalog
        default:
            break
        }
        for bottle in bottles where programs[bottle.id] != nil { await refreshPrograms(bottle) }
    }

    func refreshPrograms(_ bottle: Bottle) async {
        programs[bottle.id] = await Task.detached { ProgramScanner.scan(bottle) }.value
    }

    private func storeChanged(_ paths: [String]) {
        let changes = store.changes(forEventPaths: paths)
        guard !changes.isEmpty else { return }
        Task {
            if changes.bottles { await reload() }
            for bottle in bottles where changes.programs.contains(bottle.name) { await refreshPrograms(bottle) }
        }
    }

    func winetricksVerbs() async throws -> [WinetricksVerb] {
        if let verbs { return verbs }
        guard let runtime else { return [] }
        let loaded = try await Task.detached { try Winetricks.verbs(runtime: runtime) }.value
        verbs = loaded
        return loaded
    }

    // MARK: - Tarefas

    /// Roda `work` como uma tarefa do rodapé. No fim relê as bottles; um erro
    /// vira alerta (a não ser que a tarefa tenha sido cancelada).
    @discardableResult
    func start(_ title: String, bottle: Bottle? = nil, bottleID: Bottle.ID? = nil, recipe: String? = nil,
               creating: String? = nil, _ work: @escaping @MainActor (Job) async throws -> Void) -> Job {
        let job = Job(title: title, bottleID: bottleID ?? bottle?.id, recipeID: recipe, creatingBottle: creating)
        jobs.append(job)
        job.task = Task {
            do {
                try await work(job)
                job.state = .succeeded
            } catch {
                if Task.isCancelled || error is CancellationError {
                    job.state = .cancelled
                } else {
                    job.state = .failed(error.localizedDescription)
                    alert = AppAlert("\(title): erro", error, log: job.log)
                }
            }
            await reload()
            // Concluídas somem do rodapé depois de um tempo; as com erro ficam até fechar.
            if case .failed = job.state { return }
            try? await Task.sleep(for: .seconds(4))
            dismiss(job)
        }
        return job
    }

    func dismiss(_ job: Job) {
        guard !job.isRunning else { return }
        jobs.removeAll { $0 === job }
    }

    private func requireRuntime() throws -> Runtime {
        guard let runtime else { throw RuntimeError.notFound(searched: []) }
        return runtime
    }

    private func refuseIfBusy(_ bottle: Bottle) -> Bool {
        guard isBusy(bottle) else { return false }
        alert = AppAlert("A bottle “\(bottle.name)” está ocupada",
                         message: "Espere a tarefa em andamento nela terminar (veja o rodapé da barra lateral).")
        return true
    }

    // MARK: - Bottles

    func createBottle(name: String, windowsVersion: WindowsVersion, graphics: GraphicsBackend) {
        let store = self.store
        start("Criando “\(name)”", creating: name) { [self] job in
            let runtime = try requireRuntime()
            job.log = Logs.directory(for: Bottle(url: store.url(for: name), config: BottleConfig()))
            let bottle = try await store.create(name: name, windowsVersion: windowsVersion, graphics: graphics,
                                                runtime: runtime) { job.report($0.description) }
            await reload()
            selection = .bottle(bottle.id)
        }
    }

    /// Passa a usar um prefixo de outro programa como bottle.
    func adopt(_ foreign: ForeignBottle, graphics: GraphicsBackend) {
        guard job(forBottle: foreign.id) == nil else { return }
        let store = self.store
        start("Adotando “\(foreign.name)”", bottleID: foreign.id) { [self] job in
            let runtime = try requireRuntime()
            job.log = Logs.directory(for: Bottle(url: foreign.url, config: BottleConfig()))
            let bottle = try await store.adopt(foreign, graphics: graphics, runtime: runtime) { job.report($0.description) }
            await reload()
            await refreshPrograms(bottle)
            selection = .bottle(bottle.id)
        }
    }

    func delete(_ bottle: Bottle) {
        guard !refuseIfBusy(bottle) else { return }
        let store = self.store
        start("Apagando “\(bottle.name)”", bottle: bottle) { [self] job in
            job.report("Encerrando os programas")
            try await store.delete(bottle, runtime: try requireRuntime())
            running = running.filter { $0.value.bottleID != bottle.id }
        }
    }

    func rename(_ bottle: Bottle, to newName: String) {
        guard newName != bottle.name, !refuseIfBusy(bottle) else { return }
        let store = self.store
        start("Renomeando “\(bottle.name)”", bottle: bottle) { [self] job in
            job.report("Encerrando os programas")
            let renamed = try await store.rename(bottle, to: newName, runtime: try requireRuntime())
            running = running.filter { $0.value.bottleID != bottle.id }
            await reload()
            if selection == .bottle(bottle.id) { selection = .bottle(renamed.id) }
        }
    }

    func stopAll(_ bottle: Bottle) {
        start("Encerrando “\(bottle.name)”", bottle: bottle) { [self] _ in
            try await Wine(runtime: try requireRuntime(), bottle: bottle).stopAll()
        }
    }

    /// As mudanças da janela de configurações, da mais rápida para a mais lenta.
    struct Settings: Equatable {
        var name: String
        var windowsVersion: WindowsVersion
        var graphics: GraphicsBackend
        var msync: Bool
        var environment: [String: String]
        var dllOverrides: [String: String]

        init(_ bottle: Bottle) {
            name = bottle.name
            windowsVersion = bottle.config.windowsVersion
            graphics = bottle.config.graphics
            msync = bottle.config.msync
            environment = bottle.config.environment
            dllOverrides = bottle.config.dllOverrides
        }
    }

    func apply(_ settings: Settings, to original: Bottle) {
        guard settings != Settings(original), !refuseIfBusy(original) else { return }
        let store = self.store
        start("Configurando “\(original.name)”", bottle: original) { [self] job in
            let runtime = try requireRuntime()
            var bottle = original
            try bottle.update {
                $0.msync = settings.msync
                $0.environment = settings.environment
                $0.dllOverrides = settings.dllOverrides
            }
            if settings.graphics != bottle.config.graphics {
                job.report("Instalando \(settings.graphics.displayName)")
                let snapshot = bottle
                bottle = try await Task.detached {
                    var copy = snapshot
                    try copy.setGraphics(settings.graphics, runtime: runtime)
                    return copy
                }.value
            }
            if settings.windowsVersion != bottle.config.windowsVersion {
                job.report("Configurando como \(settings.windowsVersion.displayName)")
                try await bottle.setWindowsVersion(settings.windowsVersion, runtime: runtime)
            }
            if settings.name != bottle.name {
                job.report("Renomeando")
                let renamed = try await store.rename(bottle, to: settings.name, runtime: runtime)
                running = running.filter { $0.value.bottleID != bottle.id }
                await reload()
                if selection == .bottle(original.id) { selection = .bottle(renamed.id) }
            }
        }
    }

    func winetricks(_ verbs: [String], in bottle: Bottle) {
        guard !verbs.isEmpty, !refuseIfBusy(bottle) else { return }
        start("Winetricks em “\(bottle.name)”", bottle: bottle) { [self] job in
            let wine = Wine(runtime: try requireRuntime(), bottle: bottle, verbose: verbose)
            let log = Logs.newLog(for: bottle, named: "winetricks")
            job.log = log
            job.report("Instalando \(verbs.joined(separator: ", "))")
            try await Winetricks(wine: wine).run(verbs, log: log)
            await refreshPrograms(bottle)
        }
    }

    // MARK: - Catálogo

    func install(_ recipe: Recipe, into target: InstallTarget) {
        if case .existing(let bottle) = target, refuseIfBusy(bottle) { return }
        let store = self.store
        var existing: Bottle?
        var creating: String?
        switch target {
        case .existing(let bottle): existing = bottle
        case .newBottle(let name): creating = name
        }
        start("Instalando \(recipe.name)", bottle: existing, recipe: recipe.id, creating: creating) { [self] job in
            let runtime = try requireRuntime()
            let progress = InstallProgress(job: job)
            let bottle = try await Installer(runtime: runtime, store: store)
                .install(recipe, into: target) { progress.send($0) }
            await reload()
            await refreshPrograms(bottle)
            selection = .bottle(bottle.id)
        }
    }

    // MARK: - Programas

    func open(_ program: Program, in bottle: Bottle) {
        guard running[program.id] == nil else { return }
        do {
            let wine = Wine(runtime: try requireRuntime(), bottle: bottle, verbose: verbose)
            let log = Logs.newLog(for: bottle, named: program.name)
            let opened = Date()
            let process = try wine.open(program, log: log) { [weak self] status in
                DispatchQueue.main.async {
                    MainActor.assumeIsolated {
                        self?.programExited(program, in: bottle, status: status, after: Date().timeIntervalSince(opened))
                    }
                }
            }
            running[program.id] = RunningProgram(process: process, bottleID: bottle.id, log: log)
        } catch {
            alert = AppAlert("Não foi possível abrir \(program.name)", error)
        }
    }

    private func programExited(_ program: Program, in bottle: Bottle, status: Int32, after seconds: TimeInterval) {
        let log = running.removeValue(forKey: program.id)?.log
        // Fechar logo depois de abrir, com erro, quase sempre é falha ao iniciar.
        if status != 0 && seconds < 5 {
            alert = AppAlert("\(program.name) fechou ao abrir",
                             message: "O programa terminou com código \(status) em \(Int(seconds.rounded())) s.",
                             log: log)
        }
        Task { await refreshPrograms(bottle) }
    }

    func terminate(_ program: Program) {
        running[program.id]?.process.terminate()
    }

    /// Roda um .exe, .msi, .bat ou .lnk na bottle (um instalador, normalmente).
    func run(file: URL, in bottle: Bottle) {
        start("Executando \(file.lastPathComponent)", bottle: bottle) { [self] job in
            let wine = Wine(runtime: try requireRuntime(), bottle: bottle, verbose: verbose)
            let log = Logs.newLog(for: bottle, named: file.deletingPathExtension().lastPathComponent)
            job.log = log
            job.report("Aberto; a tarefa termina quando ele fechar")
            let process = try wine.open(file: file, log: log)
            let status = await withTaskCancellationHandler {
                await process.waitUntilExit()
            } onCancel: {
                process.terminate()
            }
            try Task.checkCancellation()
            await refreshPrograms(bottle)
            if status != 0 { throw RunError.exited(file: file.lastPathComponent, status: status) }
        }
    }

    enum RunError: LocalizedError {
        case exited(file: String, status: Int32)
        var errorDescription: String? {
            switch self {
            case .exited(let file, let status): return "\(file) terminou com código \(status)."
            }
        }
    }

    // MARK: - Finder

    func reveal(_ url: URL) {
        if FileManager.default.fileExists(atPath: url.path) {
            NSWorkspace.shared.activateFileViewerSelecting([url])
        } else {
            NSWorkspace.shared.open(url.deletingLastPathComponent())
        }
    }

    func openFolder(_ url: URL) {
        try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        NSWorkspace.shared.open(url)
    }
}
