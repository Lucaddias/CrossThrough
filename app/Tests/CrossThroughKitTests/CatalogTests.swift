import Foundation
import ImageIO
import Testing
@testable import CrossThroughKit

@Suite("Winetricks")
struct WinetricksTests {
    @Test("lê as declarações w_metadata")
    func parseMetadata() {
        let script = """
        w_metadata()
        {
            :
        }

        w_metadata vcrun2022 dlls \\
            title="Visual C++ 2015-2022 libraries (mfc140.dll)" \\
            publisher="Microsoft" \\
            year="2022" \\
            media="download" \\
            file1="vc_redist.x86.exe"

        load_vcrun2022()
        {
            w_metadata nao_e_declaracao dlls
        }

        w_metadata win7 settings \\
            title_uk="Windows 7" \\
            title="Set Windows version to Windows 7"
        w_metadata qualquer categoria_inexistente \\
            title="ignorado"
        """
        let verbs = Winetricks.parse(script: script)
        #expect(verbs.map(\.name) == ["vcrun2022", "nao_e_declaracao", "win7"])
        #expect(verbs[0] == WinetricksVerb(name: "vcrun2022", category: .dlls,
                                          title: "Visual C++ 2015-2022 libraries (mfc140.dll)",
                                          publisher: "Microsoft", year: "2022", media: "download"))
        #expect(verbs[2].title == "Set Windows version to Windows 7")
    }

    @Test("o script do runtime tem os verbos que o catálogo usa", .enabled(if: builtRuntime != nil))
    func runtimeVerbs() throws {
        let verbs = try Winetricks.verbs(runtime: try #require(builtRuntime))
        let names = Set(verbs.map(\.name))
        for verb in ["vcrun2022", "dotnet48", "corefonts", "d3dx9", "win7", "fontsmooth=rgb"] {
            #expect(names.contains(verb), "falta \(verb)")
        }
        #expect(verbs.count > 400)
    }

    @Test("verbos instalados vêm do winetricks.log da bottle")
    func installed() throws {
        let tmp = try TempDirectory()
        let bottle = try makeFakeBottle(in: tmp.url)
        #expect(Winetricks.installedVerbs(in: bottle).isEmpty)
        try touch(bottle.url.appending(path: "winetricks.log"), "vcrun2022\narial\n\ncorefonts\n")
        #expect(Winetricks.installedVerbs(in: bottle) == ["vcrun2022", "arial", "corefonts"])
    }
}

@Suite("Catálogo")
struct CatalogTests {
    static var repoCatalog: URL {
        var dir = URL(fileURLWithPath: #filePath)
        for _ in 0..<3 { dir.deleteLastPathComponent() }
        return dir.deletingLastPathComponent().appending(path: "catalog/catalog.json")
    }

    @Test("o catálogo do repositório é válido")
    func repository() throws {
        let catalog = try Catalog.load(from: Self.repoCatalog)
        #expect(!catalog.recipes.isEmpty)
        let known = builtRuntime.flatMap { try? Set(Winetricks.verbs(runtime: $0).map(\.name)) }
        #expect(catalog.problems(knownVerbs: known) == [])
        // Toda receita do catálogo do projeto fixa o arquivo que baixa.
        for recipe in catalog.recipes where recipe.download != nil {
            #expect(recipe.download?.sha256 != nil, "\(recipe.id) sem sha256")
        }
    }

    @Test("tipos de instalação vão e voltam pelo JSON")
    func installSteps() throws {
        let steps: [Recipe.InstallStep] = [.run(arguments: ["/S"]), .msi(arguments: ["/qn"]),
                                           .extract(destination: #"C:\Jogo"#, stripTopLevel: true), .none]
        for step in steps {
            let data = try JSONEncoder().encode(step)
            #expect(try JSONDecoder().decode(Recipe.InstallStep.self, from: data) == step)
        }
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(Recipe.InstallStep.self, from: Data(#"{"type": "magica"}"#.utf8))
        }
    }

    @Test("aponta receitas inconsistentes")
    func problems() throws {
        let ok = Recipe(id: "ok", name: "Ok", summary: "", category: .utilities,
                        download: .init(url: URL(string: "https://example.org/a.exe")!,
                                        sha256: String(repeating: "a", count: 64)),
                        install: .run(arguments: []))
        var duplicated = ok
        duplicated.name = "Outra"
        let noDownload = Recipe(id: "sem-download", name: "", summary: "", category: .games, install: .msi(arguments: []))
        let nothing = Recipe(id: "nada", name: "", summary: "", category: .games)
        let badSha = Recipe(id: "Sha_Ruim", name: "", summary: "", category: .games,
                            download: .init(url: URL(string: "http://example.org/b.exe")!, sha256: "123"),
                            install: .run(arguments: []))
        let verb = Recipe(id: "verbo", name: "", summary: "", category: .games, winetricks: ["naoexiste"])
        let problems = Catalog(recipes: [ok, duplicated, noDownload, nothing, badSha, verb])
            .problems(knownVerbs: ["vcrun2022"])
        #expect(problems == [
            "ok: id repetido",
            "sem-download: instalação msi sem download",
            "nada: não instala nada",
            "Sha_Ruim: id deve ter só a-z, 0-9 e hífen",
            "Sha_Ruim: sha256 inválido",
            "Sha_Ruim: download sem HTTPS",
            "verbo: verbo do winetricks desconhecido: naoexiste",
        ])
    }
}

@Suite("Downloads")
struct DownloaderTests {
    @Test("baixa, confere o SHA-256 e reaproveita o cache")
    func fetch() async throws {
        let tmp = try TempDirectory()
        let source = try touch(tmp.url.appending(path: "origem/instalador.exe"), "conteúdo do instalador")
        let sha = try Downloader.sha256(of: source)
        let cache = tmp.url.appending(path: "cache")
        let download = Recipe.Download(url: source, sha256: sha)
        let file = try await Downloader.fetch(download, folder: "teste", cacheDirectory: cache)
        #expect(file.lastPathComponent == "instalador.exe")
        #expect(try String(contentsOf: file, encoding: .utf8) == "conteúdo do instalador")
        // Com o arquivo certo no cache, não baixa de novo (a origem pode até sumir).
        try FileManager.default.removeItem(at: source)
        #expect(try await Downloader.fetch(download, folder: "teste", cacheDirectory: cache) == file)
    }

    @Test("SHA-256 errado apaga o arquivo e dá erro")
    func mismatch() async throws {
        let tmp = try TempDirectory()
        let source = try touch(tmp.url.appending(path: "a.exe"), "outro conteúdo")
        let cache = tmp.url.appending(path: "cache")
        let download = Recipe.Download(url: source, sha256: String(repeating: "0", count: 64), fileName: "b.exe")
        await #expect(throws: DownloadError.self) {
            try await Downloader.fetch(download, folder: "x", cacheDirectory: cache)
        }
        let left = try FileManager.default.contentsOfDirectory(atPath: cache.appending(path: "x").path)
        #expect(left.isEmpty)
    }

    @Test("SHA-256 conhecido")
    func knownHash() throws {
        let tmp = try TempDirectory()
        let file = try touch(tmp.url.appending(path: "abc"), "abc")
        #expect(try Downloader.sha256(of: file) == "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad")
    }
}

@Suite("Ícones")
struct IconTests {
    @Test("extrai o ícone de um .exe do Wine e converte para PNG", .enabled(if: builtRuntime != nil))
    func wineExecutable() throws {
        let runtime = try #require(builtRuntime)
        let notepad = runtime.wineDLLDirectory(.x86_64).appending(path: "notepad.exe")
        let ico = try #require(try IconExtractor.icoData(for: IconReference(file: notepad)))
        #expect(IconExtractor.isICO(ico))
        let png = try #require(IconExtractor.pngData(fromICO: ico, maxPixelSize: 64))
        #expect(png.prefix(8) == Data([0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]))
        // Índice fora do intervalo cai no primeiro grupo; ID negativo inexistente não acha nada.
        #expect(try IconExtractor.icoData(for: IconReference(file: notepad, index: 999)) != nil)
        #expect(try IconExtractor.icoData(for: IconReference(file: notepad, index: -65000)) == nil)
    }

    @Test("um .ico passa direto")
    func icoFile() throws {
        let tmp = try TempDirectory()
        let ico = tmp.url.appending(path: "a.ico")
        try (Data([0, 0, 1, 0, 0, 0])).write(to: ico)
        #expect(try IconExtractor.icoData(for: IconReference(file: ico)) == Data([0, 0, 1, 0, 0, 0]))
    }

    @Test("no mesmo tamanho, fica a imagem de mais cores, antes ou depois da de 1 bit", arguments: [false, true])
    func prefersColor(monoFirst: Bool) throws {
        // Como o putty.exe: 16x16 de 4 bits (vermelha) e 16x16 de 1 bit (preta).
        let color = Self.bitmap(bitCount: 4, palette: [0x000000, 0xFF0000], index: 1)
        let mono = Self.bitmap(bitCount: 1, palette: [0x000000, 0xFFFFFF], index: 0)
        #expect(IconExtractor.imageKey(color)! == (16, 4))
        #expect(IconExtractor.imageKey(mono)! == (16, 1))
        let png = try #require(IconExtractor.pngData(fromICO: Self.ico(monoFirst ? [mono, color] : [color, mono])))
        let source = try #require(CGImageSourceCreateWithData(png as CFData, nil))
        let image = try #require(CGImageSourceCreateImageAtIndex(source, 0, nil))
        #expect(image.width == 16 && image.height == 16)
        var pixels = [UInt8](repeating: 0, count: 16 * 16 * 4)
        let context = try #require(CGContext(data: &pixels, width: 16, height: 16, bitsPerComponent: 8, bytesPerRow: 16 * 4,
                                             space: CGColorSpace(name: CGColorSpace.sRGB)!,
                                             bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue))
        context.draw(image, in: CGRect(x: 0, y: 0, width: 16, height: 16))
        let red = stride(from: 0, to: pixels.count, by: 4).allSatisfy {
            pixels[$0] > 200 && pixels[$0 + 1] < 50 && pixels[$0 + 2] < 50 && pixels[$0 + 3] == 255
        }
        #expect(red, "a imagem escolhida não é a colorida e opaca")
    }

    /// Um .ico com estas imagens (cabeçalhos de 16 bytes, dados em seguida).
    static func ico(_ images: [Data]) -> Data {
        var ico = Data([0, 0, 1, 0, UInt8(images.count), 0])
        var offset = 6 + images.count * 16
        for image in images {
            ico += Data([16, 16, 0, 0, 1, 0, 0, 0]) + le32(image.count) + le32(offset)
            offset += image.count
        }
        return images.reduce(ico, +)
    }

    /// Bitmap de ícone 16x16 (BITMAPINFOHEADER, paleta, cores, máscara AND
    /// zerada = opaco), todo com a cor `index` da paleta (0xRRGGBB).
    static func bitmap(bitCount: Int, palette: [UInt32], index: UInt8) -> Data {
        var d = le32(40) + le32(16) + le32(32) + Data([1, 0, UInt8(bitCount), 0]) + Data(count: 24)
        for i in 0..<(1 << bitCount) {
            let rgb = i < palette.count ? palette[i] : 0
            d += Data([UInt8(rgb & 0xFF), UInt8((rgb >> 8) & 0xFF), UInt8(rgb >> 16), 0])
        }
        let pixelsPerByte = 8 / bitCount
        var byte: UInt8 = 0
        for p in 0..<pixelsPerByte { byte |= index << UInt8(8 - bitCount * (p + 1)) }
        let rowBytes = (16 * bitCount + 31) / 32 * 4
        for _ in 0..<16 { d += Data(repeating: byte, count: 16 / pixelsPerByte) + Data(count: rowBytes - 16 / pixelsPerByte) }
        return d + Data(count: 16 * 4)
    }

    private static func le32(_ v: Int) -> Data { Data((0..<4).map { UInt8((v >> (8 * $0)) & 0xFF) }) }

    @Test("arquivo que não é PE dá erro, não trava")
    func notPE() throws {
        #expect(throws: BinaryFormatError.self) { try IconExtractor.icoData(fromPE: Data("texto".utf8), index: 0) }
        var mz = Data(count: 0x40)
        mz[0] = 0x4D; mz[1] = 0x5A; mz[0x3C] = 0xFF
        #expect(throws: BinaryFormatError.self) { try IconExtractor.icoData(fromPE: mz, index: 0) }
    }
}
