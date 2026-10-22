import AppKit
import CrossThroughKit
import SwiftUI

/// Capturas das telas para conferir o layout sem gravação de tela:
/// `CROSSTHROUGH_SNAPSHOT=<pasta>` abre o app, passa pelas telas principais,
/// grava um PNG de cada janela visível e sai. A janela desenha a si mesma
/// (cacheDisplay), então o macOS não pede permissão nenhuma.
///
/// `CROSSTHROUGH_SNAPSHOT_ALL=1` fotografa todas as receitas e bottles.
/// Com `CROSSTHROUGH_SNAPSHOT_INSTALL=<receita>`, em vez disso instala a
/// receita numa bottle nova pelo app, abre o primeiro programa, fecha e
/// fotografa cada etapa: o fluxo inteiro do modelo, de verdade.
/// `CROSSTHROUGH_SNAPSHOT_ADOPT=1` faz o mesmo com a adoção do primeiro
/// prefixo de outro programa (use numa cópia: a adoção altera o prefixo).
@MainActor
enum Snapshot {
    static func runIfRequested(model: AppModel) {
        guard let path = ProcessInfo.processInfo.environment["CROSSTHROUGH_SNAPSHOT"], !path.isEmpty else { return }
        let dir = URL(fileURLWithPath: path)
        let recipe = ProcessInfo.processInfo.environment["CROSSTHROUGH_SNAPSHOT_INSTALL"]
        let adopt = ProcessInfo.processInfo.environment["CROSSTHROUGH_SNAPSHOT_ADOPT"] != nil
        Task {
            try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
            let camera = Camera(dir: dir)
            if let recipe, !recipe.isEmpty {
                await installFlow(recipe, model: model, camera: camera)
            } else if adopt {
                await adoptFlow(model: model, camera: camera)
            } else {
                await capture(model: model, camera: camera)
            }
            NSApp.terminate(nil)
        }
    }

    @MainActor
    final class Camera {
        let dir: URL
        var step = 0
        init(dir: URL) { self.dir = dir }

        func shot(_ name: String, wait: Double = 1.5) async {
            try? await Task.sleep(for: .seconds(wait))
            step += 1
            for (index, window) in NSApp.windows.filter(\.isVisible).enumerated() {
                let suffix = index == 0 ? "" : "-\(index)"
                save(window, to: dir.appending(path: String(format: "%02d-%@%@.png", step, name, suffix)))
            }
        }

        func note(_ text: String) {
            let url = dir.appending(path: "fluxo.txt")
            let line = "\(Date().formatted(date: .omitted, time: .standard)) \(text)\n"
            if let handle = try? FileHandle(forWritingTo: url) {
                handle.seekToEndOfFile()
                handle.write(Data(line.utf8))
                try? handle.close()
            } else {
                try? Data(line.utf8).write(to: url)
            }
        }
    }

    private static func installFlow(_ id: String, model: AppModel, camera: Camera) async {
        guard let recipe = model.catalog.recipe(id: id) else { camera.note("receita \(id) não existe"); return }
        let name = model.store.availableName(base: "Snapshot \(recipe.name)")
        model.selection = .catalog
        model.catalogPath = [recipe.id]
        model.install(recipe, into: .newBottle(name: name))
        camera.note("instalando \(recipe.id) em \(name)")
        var lastDetail = ""
        while let job = model.jobs.last, job.isRunning {
            if job.detail != lastDetail {
                lastDetail = job.detail
                camera.note("fase: \(job.detail)")
                if camera.step < 6 { await camera.shot("instalando", wait: 0.2) }
            }
            try? await Task.sleep(for: .milliseconds(200))
        }
        let job = model.jobs.last
        camera.note("tarefa: \(String(describing: job?.state))")
        if let alert = model.alert { camera.note("alerta: \(alert.title): \(alert.message)") }
        guard let bottle = model.selectedBottle else { camera.note("nenhuma bottle selecionada"); return }
        await camera.shot("instalado")
        let programs = model.programs[bottle.id] ?? []
        camera.note("programas: \(programs.map(\.name))")
        guard let program = programs.first else { return }
        model.open(program, in: bottle)
        try? await Task.sleep(for: .seconds(6))
        camera.note("aberto: \(model.running[program.id] != nil)")
        await camera.shot("aberto", wait: 0.5)
        model.terminate(program)
        for _ in 0..<50 where model.running[program.id] != nil { try? await Task.sleep(for: .milliseconds(200)) }
        camera.note("fechado: \(model.running[program.id] == nil)")
        if let alert = model.alert { camera.note("alerta: \(alert.title): \(alert.message)") }
        await camera.shot("fechado")
    }

    private static func adoptFlow(model: AppModel, camera: Camera) async {
        guard let foreign = model.foreignBottles.first else { camera.note("nenhum prefixo de outro programa"); return }
        model.selection = .foreign(foreign.id)
        await camera.shot("de-fora")
        let advice = await Task.detached {
            GraphicsBackend.advice(for: ProgramScanner.scan(Bottle(url: foreign.url, config: BottleConfig())))
        }.value
        let graphics = advice?.backend ?? .dxmt
        model.adopt(foreign, graphics: graphics)
        camera.note("adotando \(foreign.name) com \(graphics.rawValue)")
        var lastDetail = ""
        while let job = model.job(forBottle: foreign.id) {
            if job.detail != lastDetail {
                lastDetail = job.detail
                camera.note("fase: \(job.detail)")
                await camera.shot("adotando", wait: 0.2)
            }
            try? await Task.sleep(for: .milliseconds(200))
        }
        camera.note("tarefa: \(String(describing: model.jobs.last?.state))")
        if let alert = model.alert { camera.note("alerta: \(alert.title): \(alert.message)") }
        guard let bottle = model.selectedBottle else { camera.note("nenhuma bottle selecionada"); return }
        camera.note("bottle: \(bottle.name), gráficos \(bottle.config.graphics.rawValue), Windows \(bottle.config.windowsVersion.rawValue)")
        camera.note("programas: \((model.programs[bottle.id] ?? []).map(\.name))")
        await camera.shot("adotada", wait: 2.5)
    }

    private static func capture(model: AppModel, camera: Camera) async {
        func shot(_ name: String) async { await camera.shot(name) }

        model.selection = .catalog
        await shot("catalogo")
        for recipe in model.catalog.recipes.prefix(ProcessInfo.processInfo.environment["CROSSTHROUGH_SNAPSHOT_ALL"] == nil ? 1 : 99) {
            model.catalogPath = [recipe.id]
            await shot("receita-\(recipe.id)")
            model.catalogPath = []
        }
        if ProcessInfo.processInfo.environment["CROSSTHROUGH_SNAPSHOT_ALL"] != nil {
            for bottle in model.bottles {
                model.selection = .bottle(bottle.id)
                await shot("bottle-\(bottle.name)")
            }
        }
        if let foreign = model.foreignBottles.first {
            model.selection = .foreign(foreign.id)
            await shot("bottle-de-fora")
        }
        if let bottle = model.bottles.first(where: { !$0.config.recipes.isEmpty }) ?? model.bottles.first {
            model.selection = .bottle(bottle.id)
            // Uma tarefa de mentira, para ver o rodapé com progresso.
            let demo = model.start("Instalando Exemplo") { job in
                job.report("Baixando: 3,1 MB de 10 MB", fraction: 0.31)
                try await Task.sleep(for: .seconds(60))
            }
            await shot("bottle")
            demo.cancel()
            model.presentingBottleSettings = true
            await shot("configuracoes")
            model.presentingBottleSettings = false
            try? await Task.sleep(for: .seconds(0.8))
            model.presentingWinetricks = true
            await shot("winetricks")
            model.presentingWinetricks = false
            try? await Task.sleep(for: .seconds(0.8))
        }
        model.presentingNewBottle = true
        await shot("nova-bottle")
        model.presentingNewBottle = false
        try? await Task.sleep(for: .seconds(0.8))
        // A janela de Ajustes do SwiftUI só abre por ação do usuário, e as abas
        // dela não aparecem no cacheDisplay: cada aba vai numa janela própria.
        for (title, view) in [("ajustes-geral", AnyView(GeneralSettingsView())),
                              ("ajustes-runtime", AnyView(RuntimeSettingsView()))] {
            let window = NSWindow(contentViewController: NSHostingController(
                rootView: view.environment(model).frame(width: 600, height: 440)))
            window.title = "Ajustes"
            window.orderFront(nil)
            await shot(title)
            window.close()
        }
    }

    fileprivate static func save(_ window: NSWindow, to url: URL) {
        // A moldura (contentView.superview) inclui a barra de título e a de ferramentas.
        guard let view = window.contentView?.superview ?? window.contentView,
              let rep = view.bitmapImageRepForCachingDisplay(in: view.bounds) else { return }
        view.cacheDisplay(in: view.bounds, to: rep)
        try? rep.representation(using: .png, properties: [:])?.write(to: url)
    }
}
