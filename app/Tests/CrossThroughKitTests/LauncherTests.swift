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

    @Test("o processo acompanhado pode passar o bastão sem parecer parado")
    func handOff() async throws {
        let tmp = try TempDirectory()
        let log = tmp.url.appending(path: "log")
        let sh = URL(fileURLWithPath: "/bin/sh")
        let first = try Wine.makeProcess(sh, ["-c", "exit 0"], environment: [:], workingDirectory: tmp.url, output: log)
        let second = try Wine.makeProcess(sh, ["-c", "sleep 1; echo fim"], environment: [:],
                                          workingDirectory: tmp.url, output: log)
        let running = RunningProcess(process: first, log: log)
        let sawRunning = Flag()
        second.terminationHandler = { p in running.didExit(p.terminationStatus) }
        first.terminationHandler = { _ in
            if running.isRunning { sawRunning.set() }
            try? running.handOff(to: second)
        }
        #expect(!running.isRunning)
        try running.start()
        #expect(running.isRunning)
        #expect(await running.waitUntilExit() == 0)
        #expect(sawRunning.value, "entre um processo e outro, isRunning ficou falso")
        #expect(!running.isRunning)
        #expect(try String(contentsOf: log, encoding: .utf8).contains("fim"))
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

final class Flag: @unchecked Sendable {
    private let lock = NSLock()
    private var isSet = false
    func set() { lock.withLock { isSet = true } }
    var value: Bool { lock.withLock { isSet } }
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
