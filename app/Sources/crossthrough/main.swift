import CrossThroughKit
import Foundation

// crossthrough: o CrossThrough pela linha de comando, sobre o mesmo Kit do app.

let usage = """
uso: crossthrough <comando> [argumentos]

  runtime                              o runtime em uso e seus componentes
  bottles                              lista as bottles
  adopt <bottle> [--graphics <backend>] passa a usar uma bottle de outro programa
  create <bottle> [--windows <versão>] [--graphics dxmt|dxvk|wined3d]
  delete <bottle>                      manda a bottle para o Lixo
  rename <bottle> <novo nome>
  graphics <bottle> [backend]          mostra ou troca o backend gráfico
  windows <bottle> [versão]            mostra ou troca a versão do Windows
                                       (win11 win10 win81 win8 win7 vista winxp)
  programs <bottle>                    programas instalados (atalhos)
  open <bottle> <programa>             abre um programa pelo nome e espera fechar
  run <bottle> <arquivo> [args...]     roda um .exe/.msi/... e espera terminar
  icon <bottle> <programa> <saída.png> salva o ícone de um programa
  winetricks <bottle> <verbos...>      instala dependências com o winetricks
  verbs [categoria]                    verbos do winetricks (apps dlls fonts settings benchmarks)
  catalog                              receitas do catálogo
  install <receita> [--bottle <nome>]  instala uma receita (sem --bottle, numa bottle nova)
  stop <bottle>                        encerra tudo o que roda na bottle

opções gerais:
  --verbose                            log detalhado do Wine/DXVK/MoltenVK
  CROSSTHROUGH_RUNTIME, CROSSTHROUGH_CATALOG e CROSSTHROUGH_BOTTLES no ambiente
  apontam para outro runtime, catálogo ou diretório de bottles.
"""

struct UsageError: Error { var message: String }

/// Argumentos posicionais e opções `--nome valor` / `--flag`.
struct Arguments {
    var positional: [String] = []
    var options: [String: String] = [:]
    var flags: Set<String> = []

    static let valued: Set<String> = ["windows", "graphics", "bottle"]

    init(_ raw: [String]) throws {
        var i = 0
        var passthrough = false
        while i < raw.count {
            let arg = raw[i]
            if passthrough || !arg.hasPrefix("--") {
                positional.append(arg)
            } else if arg == "--" {
                passthrough = true
            } else {
                let name = String(arg.dropFirst(2))
                if Self.valued.contains(name) {
                    guard i + 1 < raw.count else { throw UsageError(message: "\(arg) precisa de um valor") }
                    options[name] = raw[i + 1]
                    i += 1
                } else {
                    flags.insert(name)
                }
            }
            i += 1
        }
    }

    func required(_ index: Int, _ what: String) throws -> String {
        guard index < positional.count else { throw UsageError(message: "falta \(what)") }
        return positional[index]
    }
}

func printError(_ text: String) {
    FileHandle.standardError.write(Data("crossthrough: \(text)\n".utf8))
}

let store: BottleStore = {
    if let path = ProcessInfo.processInfo.environment["CROSSTHROUGH_BOTTLES"], !path.isEmpty {
        return BottleStore(root: URL(fileURLWithPath: path))
    }
    return BottleStore()
}()

func program(named name: String, in bottle: Bottle) throws -> Program {
    let programs = ProgramScanner.scan(bottle)
    if let exact = programs.first(where: { $0.name.caseInsensitiveCompare(name) == .orderedSame }) { return exact }
    let partial = programs.filter { $0.name.localizedCaseInsensitiveContains(name) }
    if partial.count == 1 { return partial[0] }
    if partial.isEmpty { throw UsageError(message: "nenhum programa “\(name)” em \(bottle.name)") }
    throw UsageError(message: "“\(name)” é ambíguo: \(partial.map(\.name).joined(separator: ", "))")
}

func printProgress(_ text: String) {
    print("  \(text)")
}

/// O valor de `--graphics`, se veio.
func parseGraphics(_ value: String?) throws -> GraphicsBackend? {
    try value.map {
        guard let g = GraphicsBackend(rawValue: $0) else {
            throw UsageError(message: "backend desconhecido: \($0) (dxmt, dxvk ou wined3d)")
        }
        return g
    }
}

func run(_ args: Arguments) async throws -> Int32 {
    guard let command = args.positional.first else { print(usage); return 2 }
    let verbose = args.flags.contains("verbose")
    let rest = try Arguments(Array(args.positional.dropFirst()))

    switch command {
    case "help", "-h", "ajuda":
        print(usage)
        return 0

    case "runtime":
        let runtime = try Runtime.locate()
        print("Runtime: \(runtime.root.path)")
        print("Wine: \(runtime.manifest.wine), compilado em \(runtime.manifest.built)")
        print("Limite do caminho: \(runtime.manifest.maxInstallPathLength) caracteres (este: \(runtime.root.path.utf16.count))")
        for c in runtime.manifest.components { print("  \(c.name) \(c.version)  [\(c.license)]") }
        return 0

    case "bottles":
        let scan = try store.scan()
        if scan.bottles.isEmpty && scan.damaged.isEmpty && scan.foreign.isEmpty {
            print("Nenhuma bottle em \(store.root.path).")
        }
        for b in scan.bottles {
            let recipes = b.config.recipes.isEmpty ? "" : "  receitas: \(b.config.recipes.joined(separator: ", "))"
            print("\(b.name)  [\(b.config.windowsVersion.displayName), \(b.config.graphics.displayName)\(b.config.msync ? ", msync" : "")]\(recipes)")
        }
        for f in scan.foreign { print("\(f.name)  [de outro programa; para usar: crossthrough adopt \"\(f.name)\"]") }
        for d in scan.damaged { printError("\(d.name): crossthrough.json ilegível (\(d.error.localizedDescription))") }
        return 0

    case "adopt":
        let name = try rest.required(0, "o nome da bottle")
        guard let foreign = try store.scan().foreign.first(where: { $0.name == name }) else {
            if (try? store.bottle(named: name)) != nil { throw UsageError(message: "“\(name)” já é uma bottle do CrossThrough") }
            throw BottleError.notFound(name)
        }
        let advice = GraphicsBackend.advice(for: ProgramScanner.scan(Bottle(url: foreign.url, config: BottleConfig())))
        let graphics = try parseGraphics(args.options["graphics"]) ?? advice?.backend ?? .dxmt
        if let advice, advice.backend == graphics { print("\(advice.program): \(advice.reason)") }
        let runtime = try Runtime.locate()
        print("Adotando “\(name)”...")
        let clock = ContinuousClock.now
        let bottle = try await store.adopt(foreign, graphics: graphics, runtime: runtime) { printProgress($0.description) }
        print("Pronto em \(Int((ContinuousClock.now - clock).components.seconds)) s: \(bottle.config.windowsVersion.displayName), \(bottle.config.graphics.displayName)")
        return 0

    case "create":
        let name = try rest.required(0, "o nome da bottle")
        let windows = try args.options["windows"].map {
            guard let v = WindowsVersion(rawValue: $0) else { throw UsageError(message: "versão do Windows desconhecida: \($0)") }
            return v
        } ?? .wineDefault
        let graphics = try parseGraphics(args.options["graphics"]) ?? .dxmt
        let runtime = try Runtime.locate()
        print("Criando “\(name)”...")
        let clock = ContinuousClock.now
        let bottle = try await store.create(name: name, windowsVersion: windows, graphics: graphics, runtime: runtime) {
            printProgress($0.description)
        }
        print("Pronto em \(Int((ContinuousClock.now - clock).components.seconds)) s: \(bottle.url.path)")
        return 0

    case "delete":
        let bottle = try store.bottle(named: try rest.required(0, "o nome da bottle"))
        try await store.delete(bottle, runtime: try Runtime.locate())
        print("“\(bottle.name)” foi para o Lixo.")
        return 0

    case "rename":
        let bottle = try store.bottle(named: try rest.required(0, "o nome da bottle"))
        let renamed = try await store.rename(bottle, to: try rest.required(1, "o novo nome"), runtime: try Runtime.locate())
        print("Renomeada para “\(renamed.name)”.")
        return 0

    case "graphics":
        var bottle = try store.bottle(named: try rest.required(0, "o nome da bottle"))
        let runtime = try Runtime.locate()
        guard rest.positional.count > 1 else {
            let ok = bottle.config.graphics.isInstalled(in: bottle, runtime: runtime)
            print("\(bottle.config.graphics.rawValue): \(bottle.config.graphics.summary)\(ok ? "" : " (DLLs fora do lugar: rode de novo para reinstalar)")")
            return 0
        }
        guard let backend = GraphicsBackend(rawValue: rest.positional[1]) else {
            throw UsageError(message: "backend desconhecido: \(rest.positional[1]) (dxmt, dxvk ou wined3d)")
        }
        try bottle.setGraphics(backend, runtime: runtime)
        print("Backend de “\(bottle.name)”: \(backend.displayName). Programas abertos precisam ser reabertos.")
        return 0

    case "windows":
        var bottle = try store.bottle(named: try rest.required(0, "o nome da bottle"))
        guard rest.positional.count > 1 else { print(bottle.config.windowsVersion.displayName); return 0 }
        guard let version = WindowsVersion(rawValue: rest.positional[1]) else {
            throw UsageError(message: "versão desconhecida: \(rest.positional[1])")
        }
        try await bottle.setWindowsVersion(version, runtime: try Runtime.locate())
        print("“\(bottle.name)” agora é \(version.displayName).")
        return 0

    case "programs":
        let bottle = try store.bottle(named: try rest.required(0, "o nome da bottle"))
        let programs = ProgramScanner.scan(bottle)
        if programs.isEmpty { print("Nenhum programa em “\(bottle.name)”.") }
        for p in programs {
            let target = p.target.map { bottle.windowsPath(forUnixPath: $0) } ?? "(atalho do Windows Installer)"
            let folder = p.folder.isEmpty ? "" : "\(p.folder.joined(separator: "/"))/"
            print("\(folder)\(p.name)  ->  \(target)\(p.arguments.map { " \($0)" } ?? "")")
        }
        return 0

    case "open":
        let bottle = try store.bottle(named: try rest.required(0, "o nome da bottle"))
        let p = try program(named: try rest.required(1, "o nome do programa"), in: bottle)
        let wine = Wine(runtime: try Runtime.locate(), bottle: bottle, verbose: verbose)
        let log = Logs.newLog(for: bottle, named: p.name)
        print("Abrindo \(p.name) (log: \(log.path))")
        let status = await (try wine.open(p, log: log)).waitUntilExit()
        print("\(p.name) fechou (código \(status)).")
        return status

    case "run":
        let bottle = try store.bottle(named: try rest.required(0, "o nome da bottle"))
        let path = try rest.required(1, "o arquivo")
        var file = URL(fileURLWithPath: path)
        if path.count >= 2, path.dropFirst().first == ":" {
            // Caminho do Windows (C:\...).
            guard let unix = bottle.existingUnixPath(forWindowsPath: path) else {
                throw UsageError(message: "\(path) não existe em \(bottle.name)")
            }
            file = unix
        }
        guard FileManager.default.fileExists(atPath: file.path) else { throw UsageError(message: "\(file.path) não existe") }
        let wine = Wine(runtime: try Runtime.locate(), bottle: bottle, verbose: verbose)
        let log = Logs.newLog(for: bottle, named: file.lastPathComponent)
        print("Rodando \(file.lastPathComponent) (log: \(log.path))")
        let status = await (try wine.open(file: file, arguments: Array(rest.positional.dropFirst(2)), log: log)).waitUntilExit()
        print("Terminou com código \(status).")
        return status

    case "icon":
        let bottle = try store.bottle(named: try rest.required(0, "o nome da bottle"))
        let p = try program(named: try rest.required(1, "o nome do programa"), in: bottle)
        let out = URL(fileURLWithPath: try rest.required(2, "o arquivo de saída"))
        guard let reference = p.icon, let png = IconCache.png(for: reference) else {
            throw UsageError(message: "\(p.name) não tem ícone")
        }
        try png.write(to: out)
        print("Ícone de \(p.name) salvo em \(out.path) (\(png.count) bytes).")
        return 0

    case "winetricks":
        let bottle = try store.bottle(named: try rest.required(0, "o nome da bottle"))
        let verbs = Array(rest.positional.dropFirst())
        guard !verbs.isEmpty else { throw UsageError(message: "falta pelo menos um verbo") }
        let runtime = try Runtime.locate()
        let known = Set(try Winetricks.verbs(runtime: runtime).map(\.name))
        for v in verbs where !known.contains(v) && !v.contains("=") {
            throw UsageError(message: "verbo desconhecido: \(v) (veja crossthrough verbs)")
        }
        let log = Logs.newLog(for: bottle, named: "winetricks")
        print("winetricks \(verbs.joined(separator: " ")) (log: \(log.path))")
        try await Winetricks(wine: Wine(runtime: runtime, bottle: bottle, verbose: verbose)).run(verbs, log: log)
        print("Instalado.")
        return 0

    case "verbs":
        let verbs = try Winetricks.verbs(runtime: try Runtime.locate())
        let category = rest.positional.first.flatMap(WinetricksVerb.Category.init(rawValue:))
        if let filter = rest.positional.first, category == nil { throw UsageError(message: "categoria desconhecida: \(filter)") }
        for v in verbs where category == nil || v.category == category {
            let detail = [v.publisher, v.year].compactMap { $0 }.joined(separator: ", ")
            print("\(v.name.padding(toLength: 22, withPad: " ", startingAt: 0)) \(v.title)\(detail.isEmpty ? "" : " (\(detail))")")
        }
        return 0

    case "catalog":
        let catalog = try Catalog.load(from: try Catalog.locate())
        for r in catalog.recipes {
            print("\(r.id.padding(toLength: 18, withPad: " ", startingAt: 0)) \(r.name) — \(r.summary)")
        }
        return 0

    case "install":
        let catalog = try Catalog.load(from: try Catalog.locate())
        let id = try rest.required(0, "a receita")
        guard let recipe = catalog.recipe(id: id) else { throw CatalogError.unknownRecipe(id) }
        let runtime = try Runtime.locate()
        let target: InstallTarget
        if let name = args.options["bottle"] {
            target = .existing(try store.bottle(named: name))
        } else {
            target = .newBottle(name: store.availableName(base: recipe.name))
        }
        print("Instalando \(recipe.name)...")
        let lastLine = LastLine()
        let bottle = try await Installer(runtime: runtime, store: store).install(recipe, into: target) { phase in
            // O download manda progresso muitas vezes por segundo; imprime a cada 10%.
            if case .downloading = phase, let f = phase.fraction {
                if lastLine.shouldPrintDownload(f) { printProgress(phase.description) }
            } else if case .downloading = phase {
                return
            } else {
                printProgress(phase.description)
            }
        }
        print("\(recipe.name) instalado em “\(bottle.name)”.")
        for p in ProgramScanner.scan(bottle) { print("  programa: \(p.name)") }
        if let notes = recipe.notes { print("Observação: \(notes)") }
        return 0

    case "stop":
        let bottle = try store.bottle(named: try rest.required(0, "o nome da bottle"))
        try await Wine(runtime: try Runtime.locate(), bottle: bottle).stopAll()
        print("Tudo em “\(bottle.name)” foi encerrado.")
        return 0

    default:
        throw UsageError(message: "comando desconhecido: \(command)")
    }
}

/// Estado do progresso do download entre chamadas do callback.
final class LastLine: @unchecked Sendable {
    private let lock = NSLock()
    private var lastStep = -1

    func shouldPrintDownload(_ fraction: Double) -> Bool {
        lock.lock(); defer { lock.unlock() }
        let step = Int(fraction * 10)
        guard step != lastStep else { return false }
        lastStep = step
        return true
    }
}

let status: Int32
do {
    status = try await run(try Arguments(Array(CommandLine.arguments.dropFirst())))
} catch let error as UsageError {
    printError(error.message)
    printError("veja crossthrough help")
    status = 2
} catch {
    printError(error.localizedDescription)
    status = 1
}
exit(status)
