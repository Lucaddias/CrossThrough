import Foundation

/// Como rodar coisas numa bottle: o ambiente, a execução e a espera.
///
/// O ambiente é mínimo e montado do zero, como no `env -i` de
/// runtime/scripts/smoke.sh: nada do ambiente de quem chamou vaza para o Wine
/// (DYLD_*, variáveis do Xcode, um WINEPREFIX de outro lugar).
public struct Wine: Sendable {
    public let runtime: Runtime
    public let bottle: Bottle
    /// Log do Wine/DXVK/MoltenVK detalhado em vez de silencioso.
    public var verbose: Bool

    public init(runtime: Runtime, bottle: Bottle, verbose: Bool = false) {
        self.runtime = runtime
        self.bottle = bottle
        self.verbose = verbose
    }

    /// WINEDLLOVERRIDES: backend gráfico, os da bottle e os extras, nesta ordem
    /// de precedência crescente. O winemenubuilder fica desligado: ele criaria
    /// atalhos e associações do freedesktop fora da bottle.
    public func dllOverrides(extra: [String: String] = [:]) -> String {
        var entries: [String] = ["winemenubuilder.exe=d"]
        if let backend = bottle.config.graphics.dllOverride { entries.append(backend) }
        let custom = bottle.config.dllOverrides.merging(extra) { _, new in new }
        entries += custom.keys.sorted().map { "\($0)=\(custom[$0]!)" }
        return entries.joined(separator: ";")
    }

    public func environment(extra: [String: String] = [:], dllOverrides extraOverrides: [String: String] = [:]) -> [String: String] {
        let current = ProcessInfo.processInfo.environment
        var env: [String: String] = [
            "HOME": current["HOME"] ?? NSHomeDirectory(),
            "USER": current["USER"] ?? NSUserName(),
            "LOGNAME": current["LOGNAME"] ?? NSUserName(),
            "TMPDIR": current["TMPDIR"] ?? NSTemporaryDirectory(),
            "LANG": current["LANG"].flatMap { $0.isEmpty ? nil : $0 } ?? "en_US.UTF-8",
            "PATH": [runtime.binDirectory.path, "/usr/bin", "/bin", "/usr/sbin", "/sbin"].joined(separator: ":"),
            "WINEPREFIX": bottle.url.path,
            "WINEDEBUG": verbose ? "err+all,warn+module,fixme-all" : "-all",
            "WINEDLLOVERRIDES": dllOverrides(extra: extraOverrides),
            "DXVK_LOG_LEVEL": verbose ? "info" : "none",
            "MVK_CONFIG_LOG_LEVEL": verbose ? "2" : "1",
        ]
        if bottle.config.msync { env["WINEMSYNC"] = "1" }
        env.merge(bottle.config.environment) { _, new in new }
        env.merge(extra) { _, new in new }
        return env
    }

    /// Roda `wine <arguments>` e espera terminar. A saída vai para `log` (ou para
    /// um temporário) e não para um pipe: processos que o programa deixa vivos
    /// (wineserver, services.exe, conhost) segurariam o pipe aberto.
    @discardableResult
    public func run(_ arguments: [String],
                    workingDirectory: URL? = nil,
                    environment extra: [String: String] = [:],
                    log: URL? = nil,
                    timeout: Duration? = nil) async throws -> ProcessResult {
        try await Self.execute(runtime.wine, arguments, environment: environment(extra: extra),
                               workingDirectory: workingDirectory ?? bottle.driveC, log: log, timeout: timeout,
                               onTimeout: { try? await stopAll() })
    }

    /// Espera todos os processos da bottle terminarem (`wineserver -w`). Se o
    /// tempo acabar, encerra a bottle; com `stopOnTimeout: false` só para de esperar.
    public func waitForAll(timeout: Duration? = nil, stopOnTimeout: Bool = true) async throws {
        var stop: (@Sendable () async -> Void)?
        if stopOnTimeout { stop = { [self] in _ = try? await stopAll() } }
        try await Self.execute(runtime.wineserver, ["-w"], environment: environment(),
                               workingDirectory: bottle.url, log: nil, timeout: timeout, onTimeout: stop)
    }

    /// Processos que o Wine mantém em toda bottle (serviços e a área de
    /// trabalho) e os que a consulta do `tasklist` cria. O explorer.exe sem
    /// /desktop também conta: instaladores costumam deixar um aberto, e ele não
    /// é o programa de ninguém.
    static let backgroundProcesses: Set<String> = [
        "services.exe", "winedevice.exe", "plugplay.exe", "svchost.exe", "rpcss.exe",
        "explorer.exe", "conhost.exe", "start.exe", "tasklist.exe",
    ]

    /// Os nomes dos processos da bottle, em minúsculas (`tasklist` do Wine).
    public func processNames() async throws -> [String] {
        let result = try await Self.execute(runtime.wine, ["tasklist", "/fo", "csv", "/nh"],
                                            environment: environment(), workingDirectory: bottle.driveC,
                                            log: nil, timeout: .seconds(60), onTimeout: nil)
        guard result.succeeded else {
            throw BottleError.commandFailed(command: "tasklist", status: result.status, log: nil)
        }
        return Self.parseTasklist(result.output)
    }

    /// A primeira coluna de cada linha do CSV do `tasklist` ("nome.exe","PID",...).
    static func parseTasklist(_ output: String) -> [String] {
        output.split(whereSeparator: \.isNewline).compactMap { line in
            guard line.first == "\"" else { return nil }
            let rest = line.dropFirst()
            guard let end = rest.firstIndex(of: "\"") else { return nil }
            return rest[..<end].lowercased()
        }
    }

    /// Espera os programas da bottle terminarem, sem contar os processos de
    /// fundo (`backgroundProcesses`). Ao contrário do `waitForAll`, não fica
    /// preso num explorer.exe que um instalador deixou aberto. Devolve false
    /// se o tempo acabar (sem encerrar nada).
    @discardableResult
    public func waitForPrograms(timeout: Duration, poll: Duration = .seconds(2)) async throws -> Bool {
        let clock = ContinuousClock()
        let deadline = clock.now + timeout
        while true {
            let busy = try await processNames().filter { !Self.backgroundProcesses.contains($0) }
            if busy.isEmpty { return true }
            if clock.now >= deadline { return false }
            try await Task.sleep(for: poll)
        }
    }

    /// Encerra à força tudo o que roda na bottle (`wineserver -k`).
    public func stopAll() async throws {
        try await Self.execute(runtime.wineserver, ["-k"], environment: environment(),
                               workingDirectory: bottle.url, log: nil, timeout: .seconds(30), onTimeout: nil)
    }

    /// Inicia `wine <arguments>` sem esperar. `onExit` roda numa fila de fundo.
    public func launch(_ arguments: [String],
                       workingDirectory: URL? = nil,
                       environment extra: [String: String] = [:],
                       log: URL,
                       onExit: (@Sendable (Int32) -> Void)? = nil) throws -> RunningProcess {
        let process = try Self.makeProcess(runtime.wine, arguments, environment: environment(extra: extra),
                                           workingDirectory: workingDirectory ?? bottle.driveC, output: log)
        let running = RunningProcess(process: process, log: log)
        process.terminationHandler = { p in
            running.didExit(p.terminationStatus)
            onExit?(p.terminationStatus)
        }
        try running.start()
        return running
    }

    // MARK: - Execução

    static func makeProcess(_ executable: URL, _ arguments: [String], environment: [String: String],
                            workingDirectory: URL, output: URL) throws -> Process {
        let fm = FileManager.default
        try fm.createDirectory(at: output.deletingLastPathComponent(), withIntermediateDirectories: true)
        if !fm.fileExists(atPath: output.path) { fm.createFile(atPath: output.path, contents: nil) }
        let handle = try FileHandle(forWritingTo: output)
        try handle.seekToEnd()

        let process = Process()
        process.executableURL = executable
        process.arguments = arguments
        process.environment = environment
        process.currentDirectoryURL = workingDirectory
        process.standardInput = FileHandle.nullDevice
        process.standardOutput = handle
        process.standardError = handle
        return process
    }

    @discardableResult
    static func execute(_ executable: URL, _ arguments: [String], environment: [String: String],
                        workingDirectory: URL, log: URL?, timeout: Duration?,
                        onTimeout: (@Sendable () async -> Void)?) async throws -> ProcessResult {
        let output = log ?? FileManager.default.temporaryDirectory
            .appending(path: "crossthrough-\(UUID().uuidString).log")
        defer { if log == nil { try? FileManager.default.removeItem(at: output) } }
        let start = (try? FileManager.default.attributesOfItem(atPath: output.path)[.size] as? Int) ?? 0

        let process = try makeProcess(executable, arguments, environment: environment,
                                      workingDirectory: workingDirectory, output: output)
        let running = RunningProcess(process: process, log: output)
        // Cancelar a Task encerra o processo; quem chamou decide se para a bottle.
        let status: Int32 = try await withTaskCancellationHandler {
            try await withCheckedThrowingContinuation { continuation in
                process.terminationHandler = { p in
                    running.didExit(p.terminationStatus)
                    continuation.resume(returning: p.terminationStatus)
                }
                do { try running.start() } catch {
                    process.terminationHandler = nil
                    continuation.resume(throwing: error)
                    return
                }
                if let timeout {
                    Task.detached {
                        try? await Task.sleep(for: timeout)
                        guard running.isRunning else { return }
                        await onTimeout?()
                        if running.isRunning { running.terminate() }
                    }
                }
            }
        } onCancel: {
            running.terminate()
        }
        try Task.checkCancellation()
        let data = (try? Data(contentsOf: output)) ?? Data()
        let text = String(decoding: data.dropFirst(start), as: UTF8.self)
        return ProcessResult(status: status, output: text, log: log)
    }
}

public struct ProcessResult: Sendable {
    public var status: Int32
    /// O que o processo escreveu nesta execução (stdout e stderr juntos).
    public var output: String
    public var log: URL?

    public var succeeded: Bool { status == 0 }
}

/// Um processo iniciado pelo Kit (`Wine.launch`, `Wine.open`).
public final class RunningProcess: @unchecked Sendable {
    public let log: URL
    private let lock = NSLock()
    private let process: Process
    /// Como encerrar, quando não basta o SIGTERM: o que o `Wine.open` abre
    /// pelo ctlaunch.exe é uma árvore de processos do Windows.
    private let stop: (@Sendable (RunningProcess) -> Void)?
    private var started = false
    private var stopRequested = false
    private var status: Int32?
    private var waiters: [CheckedContinuation<Int32, Never>] = []

    init(process: Process, log: URL, stop: (@Sendable (RunningProcess) -> Void)? = nil) {
        self.process = process
        self.log = log
        self.stop = stop
    }

    /// Já começou e ainda não terminou.
    public var isRunning: Bool { lock.withLock { started && status == nil } }
    public var processIdentifier: Int32 { process.processIdentifier }

    /// Encerra o processo e o que ele abriu. Antes de ele começar, impede que comece.
    public func terminate() {
        let wasStarted = lock.withLock { stopRequested = true; return started && status == nil }
        guard wasStarted else { return }
        if let stop { stop(self) } else { kill() }
    }

    /// Só o SIGTERM no processo, sem o `stop`.
    func kill() {
        if process.isRunning { process.terminate() }
    }

    func start() throws {
        try lock.withLock {
            guard !stopRequested else { throw CancellationError() }
            try process.run()
            started = true
        }
    }

    /// Espera o processo terminar e devolve o código de saída.
    public func waitUntilExit() async -> Int32 {
        await withCheckedContinuation { continuation in
            lock.lock()
            if let status {
                lock.unlock()
                continuation.resume(returning: status)
            } else {
                waiters.append(continuation)
                lock.unlock()
            }
        }
    }

    func didExit(_ status: Int32) {
        lock.lock()
        self.status = status
        let pending = waiters
        waiters = []
        lock.unlock()
        for waiter in pending { waiter.resume(returning: status) }
    }
}

/// Onde ficam os logs: ~/Library/Logs/CrossThrough/<bottle>/.
public enum Logs {
    public static var root: URL {
        FileManager.default.homeDirectoryForCurrentUser.appending(path: "Library/Logs/CrossThrough")
    }

    public static func directory(for bottle: Bottle) -> URL {
        root.appending(path: bottle.name)
    }

    /// Um arquivo novo por execução, com data e o nome do que rodou.
    public static func newLog(for bottle: Bottle, named name: String) -> URL {
        let stamp = Self.stampFormatter.string(from: Date())
        let safe = name.replacingOccurrences(of: "/", with: "-").replacingOccurrences(of: ":", with: "-")
        let dir = directory(for: bottle)
        var url = dir.appending(path: "\(stamp) \(safe).log")
        var n = 2
        while FileManager.default.fileExists(atPath: url.path) {
            url = dir.appending(path: "\(stamp) \(safe) \(n).log")
            n += 1
        }
        return url
    }

    private static var stampFormatter: DateFormatter {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "yyyy-MM-dd HH.mm.ss"
        return f
    }
}
