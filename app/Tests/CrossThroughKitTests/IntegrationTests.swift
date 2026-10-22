import Foundation
import Testing
@testable import CrossThroughKit

/// Testes com o Wine de verdade. Levam alguns minutos e precisam do runtime
/// compilado: rodam com `CROSSTHROUGH_INTEGRATION=1 swift test`.
let integrationEnabled = builtRuntime != nil && ProcessInfo.processInfo.environment["CROSSTHROUGH_INTEGRATION"] == "1"

@Suite("Integração com o Wine", .serialized, .enabled(if: integrationEnabled))
struct IntegrationTests {
    @Test("cria, configura, roda, renomeia e apaga uma bottle")
    func bottleLifecycle() async throws {
        let runtime = try #require(builtRuntime)
        let tmp = try TempDirectory()
        let store = BottleStore(root: tmp.url)

        let steps = StepRecorder()
        var bottle = try await store.create(name: "Integração", windowsVersion: .win7, graphics: .dxvk,
                                            runtime: runtime) { steps.append($0) }
        #expect(steps.all == [.initializing, .configuringWindows(.win7), .installingGraphics(.dxvk), .finishing])
        #expect(try store.list().map(\.name) == ["Integração"])
        #expect(bottle.config.createdWith == runtime.manifest.wine)
        #expect(GraphicsBackend.dxvk.isInstalled(in: bottle, runtime: runtime))
        #expect(!GraphicsBackend.dxmt.isInstalled(in: bottle, runtime: runtime))

        // A versão do Windows que o winecfg gravou é a que o programa vê.
        let wine = Wine(runtime: runtime, bottle: bottle)
        let ver = try await wine.run(["cmd", "/c", "ver"], timeout: .seconds(120))
        #expect(ver.output.contains("6.1"), "cmd /c ver: \(ver.output)")

        // Trocar o backend troca as DLLs.
        try bottle.setGraphics(.dxmt, runtime: runtime)
        #expect(GraphicsBackend.dxmt.isInstalled(in: bottle, runtime: runtime))
        #expect(try #require(try Bottle.load(from: bottle.url)).config.graphics == .dxmt)

        // Um atalho gravado pelo Kit: o alvo roda direto e o código de saída volta.
        let target = bottle.windowsDirectory.appending(path: "system32/cmd.exe")
        #expect(FileManager.default.fileExists(atPath: target.path))
        let menu = bottle.driveC.appending(path: "ProgramData/Microsoft/Windows/Start Menu/Programs")
        try ShellLink.make(target: #"C:\windows\system32\cmd.exe"#, arguments: "/c exit 7").write(to: menu.appending(path: "Teste.lnk"))
        let program = try #require(ProgramScanner.scan(bottle).first { $0.name == "Teste" })
        let log = tmp.url.appending(path: "teste.log")
        let status = await (try wine.open(program, log: log)).waitUntilExit()
        #expect(status == 7, "o código de saída do programa: \(status)")

        // Um .lnk aberto como arquivo vai pelo `start`, que volta antes de o
        // programa terminar: o Kit espera a bottle. O programa só grava o
        // arquivo depois de uns 2 s (o ping espera 1 s entre um e outro).
        let marker = bottle.driveC.appending(path: "fim.txt")
        let slow = tmp.url.appending(path: "Lento.lnk")
        try ShellLink.make(target: #"C:\windows\system32\cmd.exe"#,
                           arguments: #"/c "ping -n 3 127.0.0.1 > nul & echo fim > C:\fim.txt""#).write(to: slow)
        let untracked = try wine.open(file: slow, log: log)
        #expect(untracked.isRunning)
        #expect(await untracked.waitUntilExit() == 0)
        #expect(FileManager.default.fileExists(atPath: marker.path), "voltou antes de o programa terminar")
        #expect(!untracked.isRunning)

        let renamed = try await store.rename(bottle, to: "Integração 2", runtime: runtime)
        #expect(try store.list().map(\.name) == ["Integração 2"])
        let after = try await Wine(runtime: runtime, bottle: renamed).run(["cmd", "/c", "echo", "ainda funciona"],
                                                                        timeout: .seconds(120))
        #expect(after.output.contains("ainda funciona"))
        try await Wine(runtime: runtime, bottle: renamed).stopAll()
    }

    @Test("criação que falha não deixa nada no disco")
    func failedCreation() async throws {
        let runtime = try #require(builtRuntime)
        let tmp = try TempDirectory()
        let store = BottleStore(root: tmp.url)
        _ = try makeFakeBottle(in: tmp.url, name: "Ocupada")
        await #expect(throws: BottleError.alreadyExists("Ocupada")) {
            try await store.create(name: "Ocupada", runtime: runtime)
        }
        await #expect(throws: BottleError.self) { try await store.create(name: "a/b", runtime: runtime) }
        #expect(try FileManager.default.contentsOfDirectory(atPath: tmp.url.path) == ["Ocupada"])
    }
}

final class StepRecorder: @unchecked Sendable {
    private let lock = NSLock()
    private var steps: [BottleCreationStep] = []
    func append(_ step: BottleCreationStep) { lock.lock(); steps.append(step); lock.unlock() }
    var all: [BottleCreationStep] { lock.lock(); defer { lock.unlock() }; return steps }
}
