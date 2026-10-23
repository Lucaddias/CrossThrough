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
        // Prefixo do Wine de outro programa: registro e disco C:, sem crossthrough.json.
        try touch(tmp.url.appending(path: "De Fora/system.reg"), "WINE REGISTRY Version 2\n")
        try FileManager.default.createDirectory(at: tmp.url.appending(path: "De Fora/drive_c"),
                                                withIntermediateDirectories: true)
        let scan = try store.scan()
        #expect(scan.bottles.map(\.name) == ["A", "b"])
        #expect(scan.damaged.map(\.name) == ["quebrada"])
        #expect(scan.foreign.map(\.name) == ["De Fora"])
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
        #expect(bottle.windowsPath(forUnixPath: bottle.driveC) == #"C:\"#)
        #expect(bottle.windowsPath(forUnixPath: URL(fileURLWithPath: "/")) == #"Z:\"#)
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

@Suite("Configuração como texto")
struct ConfigTextTests {
    @Test("variáveis de ambiente, uma por linha")
    func environment() throws {
        let text = """
        # comentário
        DXVK_HUD=fps,memory

          MVK_CONFIG_LOG_LEVEL = 2
        VAZIA=
        COM_IGUAL=a=b
        """
        let env = try ConfigText.parseEnvironment(text)
        #expect(env == ["DXVK_HUD": "fps,memory", "MVK_CONFIG_LOG_LEVEL": "2", "VAZIA": "", "COM_IGUAL": "a=b"])
        #expect(try ConfigText.parseEnvironment(ConfigText.format(env)) == env)
        #expect(throws: ConfigText.ParseError.missingEquals(line: 2)) { try ConfigText.parseEnvironment("A=1\nsem igual") }
        #expect(throws: ConfigText.ParseError.invalidName(line: 1, name: "COM ESPAÇO")) {
            try ConfigText.parseEnvironment("COM ESPAÇO=1")
        }
    }

    @Test("ordem de carga de DLLs no formato do WINEDLLOVERRIDES")
    func overrides() throws {
        let parsed = try ConfigText.parseDLLOverrides("xinput1_3=n,b\nd3dcompiler_47.dll = n\nmscoree=\nwinegstreamer=B, N")
        #expect(parsed == ["xinput1_3": "n,b", "d3dcompiler_47": "n", "mscoree": "", "winegstreamer": "b,n"])
        #expect(throws: ConfigText.ParseError.invalidLoadOrder(line: 1, value: "nativa")) {
            try ConfigText.parseDLLOverrides("x=nativa")
        }
    }
}

@Suite("Mudanças no diretório das bottles")
struct StoreChangesTests {
    @Test("separa o que muda a lista de bottles do que muda os programas")
    func classify() {
        let store = BottleStore(root: URL(fileURLWithPath: "/private/var/tmp/Bottles"))
        let root = "/private/var/tmp/Bottles"
        func changes(_ paths: String...) -> StoreChanges { store.changes(forEventPaths: paths) }
        #expect(changes(root + "/") == StoreChanges(bottles: true))
        #expect(changes(root + "/Jogos/") == StoreChanges(bottles: true))
        #expect(changes(root + "/Jogos/drive_c/ProgramData/Microsoft/Windows/Start Menu/Programs/Steam/")
                == StoreChanges(programs: ["Jogos"]))
        #expect(changes(root + "/Jogos/drive_c/users/crossover/Desktop/") == StoreChanges(programs: ["Jogos"]))
        #expect(changes(root + "/A/drive_c/users/crossover/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/",
                        "/var/tmp/Bottles/B/drive_c/users/Public/Desktop")
                == StoreChanges(programs: ["A", "B"]))
        // O resto da bottle (registro, arquivos de jogo, subpastas da Área de Trabalho) não importa.
        #expect(changes(root + "/Jogos/drive_c/windows/system32/",
                        root + "/Jogos/drive_c/users/crossover/Desktop/My Mac Desktop/fotos/",
                        root + "/Jogos/drive_c/users/crossover/AppData/Local/Temp/",
                        "/outro/lugar/").isEmpty)
    }
}

@Suite("Bottles de outro programa")
struct ForeignBottleTests {
    @Test("número de build do Windows para a versão", arguments: [
        (22631, WindowsVersion?.some(.win11)), (19045, .win10), (10240, .win10), (9600, .win81),
        (9200, .win8), (7601, .win7), (6002, .vista), (2600, .winxp), (1000, nil),
    ])
    func build(number: Int, expected: WindowsVersion?) {
        #expect(WindowsVersion(build: number) == expected)
    }

    @Test("lê a versão do system.reg, só na chave certa")
    func registry() throws {
        let text = #"""
        WINE REGISTRY Version 2
        ;; All keys relative to \\Machine

        [Software\\Microsoft\\Windows NT\\CurrentVersion\\AeDebug] 1784105040
        "CurrentBuild"="2600"

        [Software\\Microsoft\\Windows NT\\CurrentVersion] 1784105040
        #time=1dc6b2e1f2a3b4c
        "CurrentBuild"="19045"
        "CurrentBuildNumber"="19045"

        [Software\\Microsoft\\Windows NT\\CurrentVersion\\Fonts] 1784105040
        """#
        #expect(ForeignBottle.windowsVersion(inSystemRegistry: text) == .win10)
        #expect(ForeignBottle.windowsVersion(inSystemRegistry: "WINE REGISTRY Version 2\n") == nil)
        let noBuild = #"[Software\\Microsoft\\Windows NT\\CurrentVersion] 1"# + "\n\"ProductName\"=\"x\"\n[Outra] 1\n\"CurrentBuild\"=\"7601\"\n"
        #expect(ForeignBottle.windowsVersion(inSystemRegistry: noBuild) == nil)

        let tmp = try TempDirectory()
        try touch(tmp.url.appending(path: "Velha/system.reg"), text)
        #expect(ForeignBottle(url: tmp.url.appending(path: "Velha")).windowsVersion == .win10)
    }

    @Test("o campo adopted vai e volta pelo JSON; arquivos antigos ficam sem ele")
    func adoptedField() throws {
        let config = BottleConfig(adopted: Date(timeIntervalSince1970: 1_800_000_000.7))
        let decoded = try BottleConfig.decoder().decode(BottleConfig.self, from: BottleConfig.encoder().encode(config))
        #expect(decoded == config)
        #expect(decoded.adopted == Date(timeIntervalSince1970: 1_800_000_000))
        let old = try BottleConfig.decoder().decode(BottleConfig.self, from: Data(#"{"windowsVersion":"win7"}"#.utf8))
        #expect(old.adopted == nil)
    }
}

@Suite("Links e junções do NTFS gravados pelo Wine")
struct ReparsePointTests {
    @Test("lê o link relativo que o instalador do EA app cria")
    func eaJunction() throws {
        // O user.WINEREPARSE de "EA Desktop?" numa bottle de verdade.
        let hex = "0C0000A07000000000003000320030000100000031003300" + "2E003800310033002E0030002E0036003300320036005C00"
            + "4500410020004400650073006B0074006F00700000003100" + "33002E003800310033002E0030002E0036003300320036005C00"
            + "4500410020004400650073006B0074006F0070000000"
        let bytes = stride(from: 0, to: hex.count, by: 2).map { i -> UInt8 in
            let start = hex.index(hex.startIndex, offsetBy: i)
            return UInt8(hex[start..<hex.index(start, offsetBy: 2)], radix: 16)!
        }
        #expect(ReparsePoint(data: Data(bytes))?.target == .relative(#"13.813.0.6326\EA Desktop"#))
        #expect(ReparsePoint(data: ReparsePoint.data(for: .absolute(#"C:\Jogos"#)))?.target == .absolute(#"C:\Jogos"#))
        #expect(ReparsePoint(data: Data([1, 2, 3])) == nil)
    }

    @Test("caminhos do Windows atravessam links relativos e junções")
    func resolve() throws {
        let tmp = try TempDirectory()
        let bottle = try makeFakeBottle(in: tmp.url)
        let fm = FileManager.default
        let base = bottle.driveC.appending(path: "Program Files/Electronic Arts/EA Desktop")
        let real = try touch(base.appending(path: "13.813.0.6326/EA Desktop/EALauncher.exe"))
        try Self.link(base.appending(path: "EA Desktop?"), to: .relative(#"13.813.0.6326\EA Desktop"#))
        let resolved = bottle.existingUnixPath(forWindowsPath: #"C:\Program Files\Electronic Arts\EA Desktop\EA Desktop\EALauncher.exe"#)
        #expect(resolved?.resolvingSymlinksInPath() == real.resolvingSymlinksInPath())

        // Junção absoluta, com ".." no relativo e um link que aponta para outro.
        try fm.createDirectory(at: bottle.driveC.appending(path: "Jogos/Um"), withIntermediateDirectories: true)
        try touch(bottle.driveC.appending(path: "Jogos/Um/jogo.exe"))
        try Self.link(bottle.driveC.appending(path: "Atalho?"), to: .absolute(#"C:\Jogos"#))
        try Self.link(bottle.driveC.appending(path: "Jogos/Volta?"), to: .relative(#"..\Atalho\Um"#))
        #expect(bottle.existingUnixPath(forWindowsPath: #"C:\atalho\um\JOGO.exe"#) != nil)
        #expect(bottle.existingUnixPath(forWindowsPath: #"C:\Jogos\Volta\jogo.exe"#) != nil)
        #expect(bottle.existingUnixPath(forWindowsPath: #"C:\Atalho\Um\nada.exe"#) == nil)

        // Um link para si mesmo acaba no limite, sem laço infinito.
        try Self.link(bottle.driveC.appending(path: "Laço?"), to: .relative("Laço"))
        #expect(bottle.existingUnixPath(forWindowsPath: #"C:\Laço\x"#) == nil)
    }

    /// Um diretório `<nome>?` com o atributo, como o Wine grava.
    static func link(_ url: URL, to target: ReparsePoint.Target) throws {
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        let data = ReparsePoint.data(for: target)
        let status = data.withUnsafeBytes { setxattr(url.path, ReparsePoint.xattrName, $0.baseAddress, data.count, 0, 0) }
        #expect(status == 0)
    }
}

@Suite("Backend recomendado")
struct GraphicsAdviceTests {
    @Test("o EA app pede o backend do Wine; outros programas não pedem nada")
    func ea() {
        func program(_ name: String, _ path: String) -> Program {
            Program(name: name, shortcut: URL(fileURLWithPath: "/x/\(name).lnk"), source: .startMenu, folder: [],
                    target: URL(fileURLWithPath: path))
        }
        let notepad = program("Notepad++", "/b/drive_c/Program Files/Notepad++/notepad++.exe")
        let ea = program("EA", "/b/drive_c/Program Files/Electronic Arts/EA Desktop/13.8/EA Desktop/EALauncher.exe")
        #expect(GraphicsBackend.advice(for: [notepad]) == nil)
        let advice = GraphicsBackend.advice(for: [notepad, ea])
        #expect(advice?.backend == .wined3d && advice?.program == "EA")
    }
}
