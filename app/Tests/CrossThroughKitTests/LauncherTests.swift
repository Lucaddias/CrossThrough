import Foundation
import Testing
@testable import CrossThroughKit

@Suite("Abrir programas")
struct LauncherTests {
    @Test("divide a linha de comando como o Windows", arguments: [
        ("/c exit 7", ["/c", "exit", "7"]),
        ("  -a   -b\t-c  ", ["-a", "-b", "-c"]),
        (#""C:\Program Files\App\a.exe" -y"#, [#"C:\Program Files\App\a.exe"#, "-y"]),
        (#"-path="C:\a b" -x"#, [#"-path=C:\a b"#, "-x"]),
        (#"a\\b c\"#, [#"a\\b"#, #"c\"#]),       // barras fora de aspas ficam como estão
        (#"a\"b"#, [#"a"b"#]),                   // \" é aspa literal
        (#"a\\\"b"#, [#"a\"b"#]),                // 2n+1 barras: n barras e uma aspa
        (#"a\\"b c""#, [#"a\b c"#]),             // 2n barras: n barras, e a aspa abre
        (#"x "" y"#, ["x", "", "y"]),            // argumento vazio
        (#""a""b""#, [#"a"b"#]),                 // "" dentro de aspas é uma aspa
        ("", []),
    ])
    func splitCommandLine(line: String, expected: [String]) {
        #expect(Wine.splitCommandLine(line) == expected)
    }

    @Test("monta a linha de comando que o Windows divide de volta", arguments: [
        [#"C:\Program Files\App\a.exe"#, "-y"],
        ["", "x", ""],
        [#"a"b"#, #"c\"#, #"d\\"#, #"e f\"#, #"g\"h"#],
        [#"-path=C:\a b\"#, #"\\server\share\x"#],
        ["tab\taqui", "nova\nlinha"],
    ])
    func joinCommandLine(arguments: [String]) {
        #expect(Wine.splitCommandLine(Wine.joinCommandLine(arguments)) == arguments)
    }

    @Test("aspas só onde precisa")
    func quoteArgument() {
        #expect(Wine.joinCommandLine([#"C:\Program Files\a.exe"#, "-y"]) == #""C:\Program Files\a.exe" -y"#)
        #expect(Wine.quoteArgument(#"C:\dir\"#) == #"C:\dir\"#)
        #expect(Wine.quoteArgument(#"C:\a b\"#) == #""C:\a b\\""#)
        #expect(Wine.quoteArgument("") == #""""#)
    }

    /// Um `wine` que imprime os argumentos e fica aberto até alguém pedir
    /// `stop` com o mesmo id (que só funciona se `stops/` existir).
    static let fakeWine = """
        #!/bin/sh
        dir=$(cd "$(dirname "$0")/.." && pwd)
        case "$2" in
          run|shell) printf '[%s]\\n' "$@"; while [ ! -f "$dir/stops/$3" ]; do sleep 0.1; done; exit 0 ;;
          stop) [ -d "$dir/stops" ] || exit 1; touch "$dir/stops/$3"; exit 0 ;;
        esac
        exit 9
        """

    @Test("um atalho abre pelo ctlaunch com a linha de argumentos dele, sem mexer")
    func openProgram() async throws {
        let tmp = try TempDirectory()
        let runtime = try makeFakeRuntime(in: tmp.url, wine: Self.fakeWine)
        try FileManager.default.createDirectory(at: runtime.root.appending(path: "stops"), withIntermediateDirectories: true)
        let bottle = try makeFakeBottle(in: tmp.url)
        let exe = try touch(bottle.driveC.appending(path: "Program Files/App/app.exe"))
        let program = Program(name: "App", shortcut: bottle.driveC.appending(path: "App.lnk"), source: .startMenu,
                              folder: [], target: exe, arguments: #"-mode "a  b" %TEMP%"#,
                              workingDirectory: nil, icon: nil)
        let log = tmp.url.appending(path: "app.log")
        let running = try Wine(runtime: runtime, bottle: bottle).open(program, log: log)
        let lines = try await waitForLines(in: log, count: 6)
        #expect(lines[0] == "[\(runtime.launcher.path)]")
        #expect(lines[1] == "[run]")
        #expect(lines[3] == #"[C:\Program Files\App]"#)
        #expect(lines[4] == #"[C:\Program Files\App\app.exe]"#)
        #expect(lines[5] == #"["C:\Program Files\App\app.exe" -mode "a  b" %TEMP%]"#)
        #expect(running.isRunning)

        // Encerrar pede o stop ao ctlaunch, com o mesmo id.
        running.terminate()
        #expect(await running.waitUntilExit() == 0)
        let id = String(lines[2].dropFirst().dropLast())
        #expect(FileManager.default.fileExists(atPath: runtime.root.appending(path: "stops/\(id)").path))
    }

    @Test("arquivos: .exe direto, .msi pelo msiexec, o resto pelo shell")
    func openFile() async throws {
        let tmp = try TempDirectory()
        let runtime = try makeFakeRuntime(in: tmp.url, wine: Self.fakeWine)
        try FileManager.default.createDirectory(at: runtime.root.appending(path: "stops"), withIntermediateDirectories: true)
        let bottle = try makeFakeBottle(in: tmp.url)
        let wine = Wine(runtime: runtime, bottle: bottle)
        let cases: [(String, [String], [String])] = [
            ("Meu Setup.exe", ["/S", "a b"], ["[run]", #"[C:\Meu Setup.exe]"#, #"["C:\Meu Setup.exe" /S "a b"]"#]),
            ("setup.exe", [], ["[run]", #"[C:\setup.exe]"#, #"[C:\setup.exe]"#]),
            ("pacote.msi", [], ["[run]", #"[C:\windows\system32\msiexec.exe]"#,
                                #"[C:\windows\system32\msiexec.exe /i C:\pacote.msi]"#]),
            ("instalar.bat", [], ["[shell]", #"[C:\instalar.bat]"#]),
            ("Leia me.txt", ["x y"], ["[shell]", #"[C:\Leia me.txt]"#, #"["x y"]"#]),
        ]
        for (name, arguments, expected) in cases {
            let file = try touch(bottle.driveC.appending(path: name))
            let log = tmp.url.appending(path: "\(name).log")
            let running = try wine.open(file: file, arguments: arguments, log: log)
            let lines = try await waitForLines(in: log, count: 4 + expected.count - 1)
            #expect(lines[1] == expected[0], "\(name)")
            #expect(lines[3] == #"[C:\]"#, "\(name)")
            #expect(Array(lines[4...]) == Array(expected.dropFirst()), "\(name)")
            running.terminate()
            _ = await running.waitUntilExit()
        }
    }

    @Test("se o ctlaunch não atende o stop, o processo é encerrado mesmo assim")
    func stopFallback() async throws {
        let tmp = try TempDirectory()
        let runtime = try makeFakeRuntime(in: tmp.url, wine: Self.fakeWine) // sem stops/: o stop falha
        let bottle = try makeFakeBottle(in: tmp.url)
        let file = try touch(bottle.driveC.appending(path: "a.exe"))
        let log = tmp.url.appending(path: "a.log")
        let running = try Wine(runtime: runtime, bottle: bottle).open(file: file, log: log)
        _ = try await waitForLines(in: log, count: 6)
        running.terminate()
        #expect(await running.waitUntilExit() == SIGTERM)
        #expect(!running.isRunning)
    }

    @Test("runtime sem o ctlaunch.exe está incompleto")
    func runtimeNeedsLauncher() throws {
        let tmp = try TempDirectory()
        let runtime = try makeFakeRuntime(in: tmp.url, wine: "#!/bin/sh\n")
        try FileManager.default.removeItem(at: runtime.launcher)
        #expect(throws: RuntimeError.invalid(path: runtime.root.path, reason: "lib/crossthrough/ctlaunch.exe ausente")) {
            try Runtime(root: runtime.root)
        }
    }

    @Test("encerrar antes de começar impede que comece")
    func terminateBeforeStart() throws {
        let tmp = try TempDirectory()
        let process = try Wine.makeProcess(URL(fileURLWithPath: "/bin/sh"), ["-c", "echo rodou"], environment: [:],
                                           workingDirectory: tmp.url, output: tmp.url.appending(path: "log"))
        let running = RunningProcess(process: process, log: tmp.url.appending(path: "log"))
        running.terminate()
        #expect(throws: CancellationError.self) { try running.start() }
        #expect(!running.isRunning)
        #expect(!process.isRunning)
    }
}

struct LogTimeout: Error, CustomStringConvertible {
    var lines: [String]
    var description: String { "o log não chegou ao esperado: \(lines)" }
}

/// Espera o log ter `count` linhas (o processo de teste escreveu tudo).
func waitForLines(in log: URL, count: Int, timeout: Duration = .seconds(10)) async throws -> [String] {
    let deadline = ContinuousClock.now + timeout
    while true {
        let text = (try? String(contentsOf: log, encoding: .utf8)) ?? ""
        let lines = text.split(separator: "\n", omittingEmptySubsequences: false).dropLast().map(String.init)
        if lines.count >= count { return lines }
        if ContinuousClock.now >= deadline { throw LogTimeout(lines: lines) }
        try await Task.sleep(for: .milliseconds(50))
    }
}

@Suite("Processos da bottle")
struct ProcessListTests {
    @Test("lê os nomes do CSV do tasklist, sem as mensagens do Wine")
    func tasklist() {
        let output = """
        msync: bootstrapped mach port on wine-48ab64d-msync.
        "services.exe","48","Console","1","0 K"
        "WinMergeU.exe","364","Console","1","0 K"
        "explorer.exe","216","Console","1","0 K"

        """
        #expect(Wine.parseTasklist(output) == ["services.exe", "winmergeu.exe", "explorer.exe"])
        let busy = Wine.parseTasklist(output).filter { !Wine.backgroundProcesses.contains($0) }
        #expect(busy == ["winmergeu.exe"])
    }
}
