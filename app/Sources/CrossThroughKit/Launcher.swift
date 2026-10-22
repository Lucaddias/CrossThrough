import Foundation

extension Wine {
    /// Abre um programa da bottle. O processo devolvido vive enquanto o
    /// programa estiver aberto.
    ///
    /// O atalho é resolvido aqui, não pelo `start` do Wine: o shell32 abre um
    /// .lnk sem devolver o processo, então o `start /wait` volta na hora e o
    /// código de saída se perde. O alvo roda direto, com os argumentos do
    /// atalho (sem expandir `%VAR%`, como o shell32), no diretório de trabalho dele.
    ///
    /// Atalhos do Windows Installer não têm caminho (só o msi sabe o alvo). Esses
    /// vão pelo `start`, e o processo acompanhado passa a ser o `wineserver -w`
    /// da bottle, que termina quando tudo nela fecha.
    public func open(_ program: Program, log: URL,
                     onExit: (@Sendable (Int32) -> Void)? = nil) throws -> RunningProcess {
        let cwd = program.workingDirectory ?? program.target?.deletingLastPathComponent() ?? bottle.driveC
        guard let target = program.target else {
            return try launchUntracked(["start", "/unix", program.shortcut.path], workingDirectory: cwd,
                                       log: log, onExit: onExit)
        }
        let arguments = program.arguments.map(Self.splitCommandLine) ?? []
        if Self.isExecutable(target) {
            return try launch([target.path] + arguments, workingDirectory: cwd, log: log, onExit: onExit)
        }
        return try launch(["start", "/wait", "/unix", target.path] + arguments,
                          workingDirectory: cwd, log: log, onExit: onExit)
    }

    /// Abre um arquivo qualquer da bottle ou do Mac: .exe direto, .msi pelo
    /// msiexec, o resto pela associação do Windows (`start`).
    public func open(file: URL, arguments: [String] = [], log: URL,
                     onExit: (@Sendable (Int32) -> Void)? = nil) throws -> RunningProcess {
        let file = file.absoluteURL.standardizedFileURL
        let cwd = file.deletingLastPathComponent()
        switch file.pathExtension.lowercased() {
        case "exe", "com":
            return try launch([file.path] + arguments, workingDirectory: cwd, log: log, onExit: onExit)
        case "msi":
            return try launch(["msiexec", "/i", file.path] + arguments, workingDirectory: cwd, log: log, onExit: onExit)
        case "lnk":
            return try launchUntracked(["start", "/unix", file.path] + arguments, workingDirectory: cwd,
                                       log: log, onExit: onExit)
        default:
            return try launch(["start", "/wait", "/unix", file.path] + arguments,
                              workingDirectory: cwd, log: log, onExit: onExit)
        }
    }

    /// Roda `wine <arguments>` e, se ele abrir algo, acompanha a bottle com
    /// `wineserver -w` até tudo nela fechar (código 0). Se o `start` falhar,
    /// o código é o dele.
    func launchUntracked(_ arguments: [String], workingDirectory: URL, log: URL,
                         onExit: (@Sendable (Int32) -> Void)?) throws -> RunningProcess {
        let env = environment()
        let starter = try Self.makeProcess(runtime.wine, arguments, environment: env,
                                           workingDirectory: workingDirectory, output: log)
        let waiter = try Self.makeProcess(runtime.wineserver, ["-w"], environment: env,
                                          workingDirectory: bottle.url, output: log)
        let running = RunningProcess(process: starter, log: log)
        let finish: @Sendable (Int32) -> Void = { running.didExit($0); onExit?($0) }
        waiter.terminationHandler = { _ in finish(0) }
        starter.terminationHandler = { p in
            // O -w só depois do `start`: antes, ele podia não achar o wineserver e voltar na hora.
            guard p.terminationStatus == 0 else { finish(p.terminationStatus); return }
            do { try running.handOff(to: waiter) } catch { finish(p.terminationStatus) }
        }
        try running.start()
        return running
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
}
