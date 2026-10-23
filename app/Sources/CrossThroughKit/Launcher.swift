import Foundation

extension Wine {
    /// Abre um programa da bottle. O processo devolvido vive enquanto o
    /// programa estiver aberto, inclusive o que um launcher abre antes de sair.
    ///
    /// Quem abre é o ctlaunch.exe do runtime (runtime/helpers/ctlaunch.c), que
    /// acompanha a árvore de processos inteira. O código de saída é o do
    /// último processo da árvore a fechar: o do programa, quando ele é o único;
    /// o do jogo, quando um launcher o abriu e saiu; 127 quando nada abriu.
    ///
    /// O atalho é resolvido aqui: o alvo roda direto, com a linha de argumentos
    /// do atalho exatamente como está (sem expandir `%VAR%`, como o shell32),
    /// no diretório de trabalho dele. Atalhos do Windows Installer não têm
    /// caminho (só o msi sabe o alvo) e abrem pelo shell do Windows.
    public func open(_ program: Program, log: URL,
                     onExit: (@Sendable (Int32) -> Void)? = nil) throws -> RunningProcess {
        let cwd = program.workingDirectory ?? program.target?.deletingLastPathComponent() ?? bottle.driveC
        guard let target = program.target else {
            return try track(.shell(file: bottle.windowsPath(forUnixPath: program.shortcut), parameters: nil),
                             workingDirectory: cwd, log: log, onExit: onExit)
        }
        let path = bottle.windowsPath(forUnixPath: target)
        guard Self.isExecutable(target) else {
            return try track(.shell(file: path, parameters: program.arguments), workingDirectory: cwd,
                             log: log, onExit: onExit)
        }
        let line = Self.quoteArgument(path) + (program.arguments.map { " " + $0 } ?? "")
        return try track(.run(application: path, commandLine: line), workingDirectory: cwd, log: log, onExit: onExit)
    }

    /// Abre um arquivo qualquer da bottle ou do Mac: .exe direto, .msi pelo
    /// msiexec, o resto (.lnk, .bat, documentos) pelo shell do Windows. Como em
    /// `open(_:)`, o processo vive até a árvore inteira fechar.
    public func open(file: URL, arguments: [String] = [], log: URL,
                     onExit: (@Sendable (Int32) -> Void)? = nil) throws -> RunningProcess {
        let file = file.absoluteURL.standardizedFileURL
        let cwd = file.deletingLastPathComponent()
        let path = bottle.windowsPath(forUnixPath: file)
        let request: LaunchRequest
        switch file.pathExtension.lowercased() {
        case "exe", "com":
            request = .run(application: path, commandLine: Self.joinCommandLine([path] + arguments))
        case "msi":
            let msiexec = #"C:\windows\system32\msiexec.exe"#
            request = .run(application: msiexec, commandLine: Self.joinCommandLine([msiexec, "/i", path] + arguments))
        default:
            request = .shell(file: path, parameters: arguments.isEmpty ? nil : Self.joinCommandLine(arguments))
        }
        return try track(request, workingDirectory: cwd, log: log, onExit: onExit)
    }

    /// Como o ctlaunch.exe abre: CreateProcess com a linha de comando exata,
    /// ou ShellExecuteEx (atalhos, documentos, scripts).
    enum LaunchRequest: Equatable {
        case run(application: String, commandLine: String)
        case shell(file: String, parameters: String?)
    }

    /// Os argumentos do `wine` para o ctlaunch.exe abrir `request` com o `id`
    /// dado, no diretório do Windows `directory`.
    func launcherArguments(_ request: LaunchRequest, id: String, directory: String) -> [String] {
        switch request {
        case .run(let application, let commandLine):
            return [runtime.launcher.path, "run", id, directory, application, commandLine]
        case .shell(let file, let parameters):
            return [runtime.launcher.path, "shell", id, directory, file] + (parameters.map { [$0] } ?? [])
        }
    }

    /// Abre pelo ctlaunch.exe. Encerrar o processo devolvido pede ao ctlaunch
    /// que encerre a árvore (`ctlaunch.exe stop <id>`).
    func track(_ request: LaunchRequest, workingDirectory: URL, log: URL,
               onExit: (@Sendable (Int32) -> Void)?) throws -> RunningProcess {
        let id = UUID().uuidString
        let arguments = launcherArguments(request, id: id,
                                          directory: bottle.windowsPath(forUnixPath: workingDirectory))
        let process = try Self.makeProcess(runtime.wine, arguments, environment: environment(),
                                           workingDirectory: workingDirectory, output: log)
        let running = RunningProcess(process: process, log: log) { [self] running in
            Task.detached { await stopTree(id: id, of: running) }
        }
        process.terminationHandler = { p in
            running.didExit(p.terminationStatus)
            onExit?(p.terminationStatus)
        }
        try running.start()
        return running
    }

    /// Pede ao ctlaunch que encerre a árvore `id`. Se ele não atender (ainda
    /// não estava pronto, ou não fechou em 15 s), encerra o próprio ctlaunch:
    /// o que ele abriu continua aberto, mas o app não fica preso esperando.
    private func stopTree(id: String, of running: RunningProcess) async {
        let result = try? await Self.execute(runtime.wine, [runtime.launcher.path, "stop", id],
                                             environment: environment(), workingDirectory: bottle.url,
                                             log: nil, timeout: .seconds(30), onTimeout: nil)
        if result?.status == 0 {
            let deadline = ContinuousClock.now + .seconds(15)
            while running.isRunning && ContinuousClock.now < deadline {
                try? await Task.sleep(for: .milliseconds(200))
            }
        }
        if running.isRunning { running.kill() }
    }

    static func isExecutable(_ url: URL) -> Bool {
        ["exe", "com"].contains(url.pathExtension.lowercased())
    }

    /// Divide uma linha de comando do Windows em argumentos, com as regras do
    /// CommandLineToArgvW/msvcrt: aspas agrupam, `\"` é aspa literal, 2n barras
    /// antes de aspas viram n, e `""` dentro de aspas é uma aspa. O Wine monta
    /// a linha de volta a partir dos argumentos.
    static func splitCommandLine(_ line: String) -> [String] {
        var args: [String] = []
        var current = ""
        var inQuotes = false
        var hasArgument = false
        let chars = Array(line)
        var i = 0
        while i < chars.count {
            let c = chars[i]
            if c == "\\" {
                var slashes = 0
                while i < chars.count && chars[i] == "\\" { slashes += 1; i += 1 }
                if i < chars.count && chars[i] == "\"" {
                    current += String(repeating: "\\", count: slashes / 2)
                    if slashes % 2 == 1 { current.append("\""); i += 1 }
                } else {
                    current += String(repeating: "\\", count: slashes)
                }
                hasArgument = true
                continue
            }
            if c == "\"" {
                if inQuotes && i + 1 < chars.count && chars[i + 1] == "\"" {
                    current.append("\"")
                    i += 2
                    continue
                }
                inQuotes.toggle()
                hasArgument = true
                i += 1
                continue
            }
            if (c == " " || c == "\t") && !inQuotes {
                if hasArgument { args.append(current); current = ""; hasArgument = false }
                i += 1
                continue
            }
            current.append(c)
            hasArgument = true
            i += 1
        }
        if hasArgument { args.append(current) }
        return args
    }

    /// Um argumento como o CommandLineToArgvW/msvcrt o lê de volta (o inverso
    /// de `splitCommandLine`): entre aspas se tiver espaço, tab ou aspa (ou
    /// for vazio), com as aspas e as barras antes delas escapadas.
    static func quoteArgument(_ argument: String) -> String {
        if !argument.isEmpty && !argument.contains(where: { " \t\n\u{0B}\"".contains($0) }) { return argument }
        var result = "\""
        var slashes = 0
        for c in argument {
            if c == "\\" { slashes += 1; continue }
            if c == "\"" {
                result += String(repeating: "\\", count: slashes * 2 + 1) + "\""
            } else {
                result += String(repeating: "\\", count: slashes)
                result.append(c)
            }
            slashes = 0
        }
        return result + String(repeating: "\\", count: slashes * 2) + "\""
    }

    /// A linha de comando do Windows para estes argumentos.
    static func joinCommandLine(_ arguments: [String]) -> String {
        arguments.map(quoteArgument).joined(separator: " ")
    }
}
