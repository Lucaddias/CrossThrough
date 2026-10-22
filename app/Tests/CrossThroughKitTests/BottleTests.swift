import Foundation
import Testing
@testable import CrossThroughKit

@Suite("Bottles")
struct BottleTests {
    @Test("crossthrough.json de uma versão anterior recebe os padrões")
    func tolerantDecoding() throws {
        let json = #"{"graphics": "dxvk", "created": "2026-01-02T03:04:05Z"}"#
        let config = try BottleConfig.decoder().decode(BottleConfig.self, from: Data(json.utf8))
        #expect(config.graphics == .dxvk)
        #expect(config.windowsVersion == .win10)
        #expect(config.msync)
        #expect(config.recipes.isEmpty)
        #expect(config.formatVersion == BottleConfig.currentFormat)
    }

    @Test("salvar e carregar preserva a configuração")
    func saveAndLoad() throws {
        let tmp = try TempDirectory()
        var bottle = try makeFakeBottle(in: tmp.url)
        try bottle.update {
            $0.windowsVersion = .win7
            $0.dllOverrides = ["xinput1_3": "n,b"]
            $0.environment = ["DXVK_HUD": "fps"]
            $0.recipes = ["7zip"]
        }
        let loaded = try #require(try Bottle.load(from: bottle.url))
        #expect(loaded.config == bottle.config)
        #expect(try Bottle.load(from: tmp.url) == nil) // diretório sem crossthrough.json
    }

    @Test("regras de nome", arguments: [
        ("Jogos", true), ("Steam 2", true), ("Ação & Aventura", true),
        ("", false), ("   ", false), (" espaço", false), ("espaço ", false), (".oculta", false),
        ("a/b", false), ("a:b", false), ("tab\there", false), (String(repeating: "x", count: 65), false),
    ])
    func names(name: String, valid: Bool) {
        if valid {
            #expect(throws: Never.self) { try BottleStore.validateName(name) }
        } else {
            #expect(throws: BottleError.self) { try BottleStore.validateName(name) }
        }
    }

    @Test("lista só diretórios com crossthrough.json e reporta os ilegíveis")
    func scan() throws {
        let tmp = try TempDirectory()
        let store = BottleStore(root: tmp.url)
        _ = try makeFakeBottle(in: tmp.url, name: "b")
        _ = try makeFakeBottle(in: tmp.url, name: "A")
        try FileManager.default.createDirectory(at: tmp.url.appending(path: "criação interrompida"),
                                                withIntermediateDirectories: true)
        try touch(tmp.url.appending(path: "quebrada/crossthrough.json"), "{ não é json")
        let (bottles, damaged) = try store.scan()
        #expect(bottles.map(\.name) == ["A", "b"])
        #expect(damaged.map(\.name) == ["quebrada"])
        #expect(store.availableName(base: "A") == "A 2")
        #expect(store.availableName(base: "Nova") == "Nova")
    }

    @Test("variáveis de ambiente do Windows em caminhos")
    func environmentExpansion() throws {
        let tmp = try TempDirectory()
        let bottle = try makeFakeBottle(in: tmp.url)
        #expect(bottle.windowsUserName == "crossover")
        #expect(bottle.expandEnvironment(#"%ProgramFiles%\App\a.exe"#) == #"C:\Program Files\App\a.exe"#)
        #expect(bottle.expandEnvironment(#"%PROGRAMFILES(X86)%\x"#) == #"C:\Program Files (x86)\x"#)
        #expect(bottle.expandEnvironment(#"%APPDATA%\y"#) == #"C:\users\crossover\AppData\Roaming\y"#)
        #expect(bottle.expandEnvironment("%NAO_EXISTE%\\z") == "%NAO_EXISTE%\\z")
        #expect(bottle.expandEnvironment("100% certo") == "100% certo")
    }

    @Test("caminho Windows para Unix sem diferenciar maiúsculas")
    func caseInsensitivePaths() throws {
        let tmp = try TempDirectory()
        let bottle = try makeFakeBottle(in: tmp.url)
        let exe = try touch(bottle.driveC.appending(path: "Program Files/My App/Game.exe"))
        let resolved = bottle.existingUnixPath(forWindowsPath: #"c:\PROGRAM FILES\my app\game.EXE"#)
        #expect(resolved?.resolvingSymlinksInPath().path == exe.resolvingSymlinksInPath().path)
        #expect(bottle.existingUnixPath(forWindowsPath: #"C:\Program Files\nada.exe"#) == nil)
        #expect(bottle.existingUnixPath(forWindowsPath: "sem drive") == nil)
        #expect(bottle.windowsPath(forUnixPath: exe) == #"C:\Program Files\My App\Game.exe"#)
        #expect(bottle.windowsPath(forUnixPath: URL(fileURLWithPath: "/Users")) == #"Z:\Users"#)
    }

    @Test("WINEDLLOVERRIDES: backend, os da bottle e os extras", .enabled(if: builtRuntime != nil))
    func dllOverrides() throws {
        let tmp = try TempDirectory()
        var bottle = try makeFakeBottle(in: tmp.url)
        bottle.config.graphics = .dxmt
        bottle.config.dllOverrides = ["xinput1_3": "n,b", "d3dcompiler_47": "n"]
        let wine = Wine(runtime: try #require(builtRuntime), bottle: bottle)
        #expect(wine.dllOverrides(extra: ["xinput1_3": "b"]) ==
                "winemenubuilder.exe=d;d3d10core,d3d11,dxgi=n,b;d3dcompiler_47=n;xinput1_3=b")
        let env = wine.environment()
        #expect(env["WINEPREFIX"] == bottle.url.path)
        #expect(env["WINEMSYNC"] == "1")
        #expect(env["WINEDEBUG"] == "-all")
        #expect(env["PATH"]?.hasPrefix(wine.runtime.binDirectory.path) == true)
        #expect(env["DYLD_LIBRARY_PATH"] == nil)
    }

    @Test("backends gráficos")
    func backends() {
        #expect(GraphicsBackend.dxvk.dllOverride == "d3d9,d3d10,d3d10_1,d3d10core,d3d11,dxgi=n,b")
        #expect(GraphicsBackend.dxmt.dllOverride == "d3d10core,d3d11,dxgi=n,b")
        #expect(GraphicsBackend.wined3d.dllOverride == nil)
        for backend in GraphicsBackend.allCases {
            #expect(Set(backend.nativeDLLs).isSubset(of: GraphicsBackend.managedDLLs))
        }
    }
}

@Suite("Programas")
struct ProgramTests {
    @Test("acha programas no Menu Iniciar e na Área de Trabalho, sem desinstaladores e documentos")
    func scanner() throws {
        let tmp = try TempDirectory()
        let bottle = try makeFakeBottle(in: tmp.url)
        let c = bottle.driveC
        try touch(c.appending(path: "Program Files/Jogo/jogo.exe"))
        try touch(c.appending(path: "Program Files/Jogo/unins000.exe"))
        try touch(c.appending(path: "Program Files/Jogo/manual.pdf"))
        try touch(c.appending(path: "Program Files/Editor/editor.exe"))

        let menu = c.appending(path: "ProgramData/Microsoft/Windows/Start Menu/Programs")
        func lnk(_ url: URL, _ target: String, args: String? = nil) throws {
            try FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
            try ShellLink.make(target: target, arguments: args).write(to: url)
        }
        try lnk(menu.appending(path: "Jogo/Jogo.lnk"), #"C:\Program Files\Jogo\jogo.exe"#)
        try lnk(menu.appending(path: "Jogo/Jogo (janela).lnk"), #"C:\Program Files\Jogo\jogo.exe"#, args: "-window")
        try lnk(menu.appending(path: "Jogo/Desinstalar Jogo.lnk"), #"C:\Program Files\Jogo\unins000.exe"#)
        try lnk(menu.appending(path: "Jogo/Remover.lnk"), #"C:\Program Files\Jogo\unins000.exe"#)
        try lnk(menu.appending(path: "Jogo/Manual.lnk"), #"C:\Program Files\Jogo\manual.pdf"#)
        try lnk(menu.appending(path: "Jogo/Quebrado.lnk"), #"C:\Program Files\Jogo\sumiu.exe"#)
        try lnk(menu.appending(path: "Pasta.lnk"), #"C:\Program Files\Jogo"#)
        // O mesmo jogo na Área de Trabalho não aparece duas vezes.
        try lnk(c.appending(path: "users/crossover/Desktop/Jogo.lnk"), #"%ProgramFiles%\Jogo\jogo.exe"#)
        try lnk(c.appending(path: "users/Public/Desktop/Editor.lnk"), #"C:\Program Files\Editor\editor.exe"#)
        // Link para a Área de Trabalho do Mac: não pode ser varrido.
        try FileManager.default.createSymbolicLink(at: c.appending(path: "users/crossover/Desktop/My Mac Desktop"),
                                                   withDestinationURL: tmp.url)
        try touch(c.appending(path: "Program Files/Mac/mac.exe"))
        try lnk(tmp.url.appending(path: "Atalho do Mac.lnk"), #"C:\Program Files\Mac\mac.exe"#)

        let programs = ProgramScanner.scan(bottle)
        #expect(programs.map(\.name) == ["Editor", "Jogo", "Jogo (janela)"])
        let jogo = try #require(programs.first { $0.name == "Jogo" })
        #expect(jogo.source == .startMenu)
        #expect(jogo.folder == ["Jogo"])
        #expect(jogo.target?.lastPathComponent == "jogo.exe")
        #expect(jogo.icon?.file.lastPathComponent == "jogo.exe")
        #expect(programs.first { $0.name == "Jogo (janela)" }?.arguments == "-window")
        #expect(programs.first { $0.name == "Editor" }?.source == .desktop)
    }
}
