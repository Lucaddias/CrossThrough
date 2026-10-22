import CrossThroughKit
import SwiftUI

struct NewBottleView: View {
    @Environment(AppModel.self) private var model
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var windowsVersion = WindowsVersion.wineDefault
    @State private var graphics = GraphicsBackend.dxmt

    var body: some View {
        VStack(spacing: 0) {
            Form {
                TextField("Nome", text: $name)
                if let problem = nameProblem, !name.isEmpty {
                    Text(problem).font(.caption).foregroundStyle(.red)
                }
                Picker("Windows", selection: $windowsVersion) {
                    ForEach(WindowsVersion.allCases) { Text($0.displayName).tag($0) }
                }
                Picker("Gráficos", selection: $graphics) {
                    ForEach(GraphicsBackend.allCases) { Text($0.displayName).tag($0) }
                }
                Text(graphics.summary)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .formStyle(.grouped)
            SheetButtons(confirm: "Criar", disabled: nameProblem != nil) {
                model.createBottle(name: name, windowsVersion: windowsVersion, graphics: graphics)
                dismiss()
            }
        }
        .frame(width: 460)
        .onAppear { if name.isEmpty { name = model.store.availableName(base: "Nova bottle") } }
    }

    private var nameProblem: String? {
        do { try BottleStore.validateName(name) } catch { return error.localizedDescription }
        if FileManager.default.fileExists(atPath: model.store.url(for: name).path) {
            return BottleError.alreadyExists(name).localizedDescription
        }
        return nil
    }
}

struct BottleSettingsView: View {
    @Environment(AppModel.self) private var model
    @Environment(\.dismiss) private var dismiss
    let bottle: Bottle
    @State private var settings: AppModel.Settings
    @State private var environmentText: String
    @State private var overridesText: String

    init(bottle: Bottle) {
        self.bottle = bottle
        _settings = State(initialValue: AppModel.Settings(bottle))
        _environmentText = State(initialValue: ConfigText.format(bottle.config.environment))
        _overridesText = State(initialValue: ConfigText.format(bottle.config.dllOverrides))
    }

    var body: some View {
        VStack(spacing: 0) {
            Form {
                Section("Geral") {
                    TextField("Nome", text: $settings.name)
                    if let problem = nameProblem {
                        Text(problem).font(.caption).foregroundStyle(.red)
                    }
                    LabeledContent("Local") {
                        HStack {
                            Text(abbreviatedPath(bottle.url))
                                .lineLimit(1)
                                .truncationMode(.middle)
                                .help(bottle.url.path(percentEncoded: false))
                            Button("Mostrar") { model.reveal(bottle.url) }
                        }
                    }
                    if let createdWith = bottle.config.createdWith {
                        LabeledContent("Criada com", value: wineVersionName(createdWith))
                    }
                    if let adopted = bottle.config.adopted {
                        LabeledContent("Adotada em", value: adopted.formatted(date: .long, time: .omitted))
                    }
                }
                Section("Windows") {
                    Picker("Versão do Windows", selection: $settings.windowsVersion) {
                        ForEach(WindowsVersion.allCases) { Text($0.displayName).tag($0) }
                    }
                }
                Section {
                    Picker("Direct3D", selection: $settings.graphics) {
                        ForEach(GraphicsBackend.allCases) { Text($0.displayName).tag($0) }
                    }
                    Text(settings.graphics.summary)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                    if let advice = GraphicsBackend.advice(for: model.programs[bottle.id] ?? []),
                       advice.backend != settings.graphics {
                        Label(advice.reason, systemImage: "exclamationmark.triangle")
                            .font(.caption)
                            .foregroundStyle(.orange)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Toggle("Sincronização rápida (msync)", isOn: $settings.msync)
                } header: {
                    Text("Gráficos e desempenho")
                } footer: {
                    Text("Programas abertos continuam com a configuração antiga até reabrir.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Section {
                    editor($environmentText)
                    if let error = environmentError {
                        Text(error).font(.caption).foregroundStyle(.red)
                    }
                } header: {
                    Text("Variáveis de ambiente")
                } footer: {
                    Text("Uma por linha: NOME=valor (ex.: DXVK_HUD=fps).").font(.caption).foregroundStyle(.secondary)
                }
                Section {
                    editor($overridesText)
                    if let error = overridesError {
                        Text(error).font(.caption).foregroundStyle(.red)
                    }
                } header: {
                    Text("Ordem de carga de DLLs")
                } footer: {
                    Text("Uma por linha: dll=n,b (nativa, depois a do Wine), dll=b, dll=n, ou dll= para desligar.")
                        .font(.caption).foregroundStyle(.secondary)
                }
            }
            .formStyle(.grouped)
            SheetButtons(confirm: "Salvar", disabled: !isValid) {
                guard let changed = changedSettings else { return }
                model.apply(changed, to: bottle)
                dismiss()
            }
        }
        .frame(width: 540, height: 640)
    }

    private func editor(_ text: Binding<String>) -> some View {
        TextEditor(text: text)
            .font(.body.monospaced())
            .frame(minHeight: 60, maxHeight: 110)
            .scrollContentBackground(.hidden)
            .autocorrectionDisabled()
    }

    private var nameProblem: String? {
        guard settings.name != bottle.name else { return nil }
        do { try BottleStore.validateName(settings.name) } catch { return error.localizedDescription }
        let sameDirectory = settings.name.lowercased() == bottle.name.lowercased()
        if !sameDirectory && FileManager.default.fileExists(atPath: model.store.url(for: settings.name).path) {
            return BottleError.alreadyExists(settings.name).localizedDescription
        }
        return nil
    }

    private var environmentError: String? {
        do { _ = try ConfigText.parseEnvironment(environmentText); return nil } catch { return error.localizedDescription }
    }

    private var overridesError: String? {
        do { _ = try ConfigText.parseDLLOverrides(overridesText); return nil } catch { return error.localizedDescription }
    }

    private var isValid: Bool { nameProblem == nil && environmentError == nil && overridesError == nil }

    private var changedSettings: AppModel.Settings? {
        guard let environment = try? ConfigText.parseEnvironment(environmentText),
              let overrides = try? ConfigText.parseDLLOverrides(overridesText) else { return nil }
        var result = settings
        result.environment = environment
        result.dllOverrides = overrides
        return result
    }
}

struct WinetricksView: View {
    @Environment(AppModel.self) private var model
    @Environment(\.dismiss) private var dismiss
    let bottle: Bottle
    @State private var verbs: [WinetricksVerb] = []
    @State private var loadError: String?
    @State private var category = WinetricksVerb.Category.dlls
    @State private var search = ""
    @State private var selected: [String] = []
    @State private var installed: Set<String> = []

    private var shown: [WinetricksVerb] {
        verbs.filter { verb in
            guard search.isEmpty else {
                return verb.name.localizedCaseInsensitiveContains(search) || verb.title.localizedCaseInsensitiveContains(search)
            }
            return verb.category == category
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Winetricks em “\(bottle.name)”")
                    .font(.headline)
                HStack {
                    Picker("Categoria", selection: $category) {
                        Text("Bibliotecas").tag(WinetricksVerb.Category.dlls)
                        Text("Fontes").tag(WinetricksVerb.Category.fonts)
                        Text("Ajustes").tag(WinetricksVerb.Category.settings)
                        Text("Programas").tag(WinetricksVerb.Category.apps)
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .disabled(!search.isEmpty)
                    TextField("Buscar", text: $search)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 180)
                }
            }
            .padding(16)
            Divider()
            Group {
                if let loadError {
                    ContentUnavailableView("O winetricks não pôde ser lido", systemImage: "exclamationmark.triangle",
                                           description: Text(loadError))
                } else if verbs.isEmpty {
                    ProgressView()
                } else {
                    List(shown) { verb in
                        Toggle(isOn: binding(for: verb)) {
                            HStack(alignment: .firstTextBaseline) {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(verb.title)
                                    Text(subtitle(verb))
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                if installed.contains(verb.name) {
                                    Text("instalado")
                                        .font(.caption)
                                        .foregroundStyle(.green)
                                }
                            }
                        }
                        .disabled(verb.media == "manual_download")
                        .help(verb.media == "manual_download" ? "Este exige baixar o arquivo à mão; use o winetricks no Terminal." : verb.name)
                    }
                }
            }
            .frame(maxHeight: .infinity)
            Divider()
            SheetButtons(confirm: selected.isEmpty ? "Instalar" : "Instalar \(selected.count)",
                         disabled: selected.isEmpty,
                         note: selected.isEmpty ? nil : selected.joined(separator: ", ")) {
                model.winetricks(selected, in: bottle)
                dismiss()
            }
        }
        .frame(width: 620, height: 560)
        .task {
            installed = Set(Winetricks.installedVerbs(in: bottle))
            do {
                verbs = try await model.winetricksVerbs().filter { $0.category != .benchmarks }
            } catch {
                loadError = error.localizedDescription
            }
        }
    }

    private func subtitle(_ verb: WinetricksVerb) -> String {
        [verb.name, verb.publisher, verb.year].compactMap { $0 }.joined(separator: " · ")
    }

    private func binding(for verb: WinetricksVerb) -> Binding<Bool> {
        Binding {
            selected.contains(verb.name)
        } set: { on in
            if on {
                if !selected.contains(verb.name) { selected.append(verb.name) }
            } else {
                selected.removeAll { $0 == verb.name }
            }
        }
    }
}

/// Cancelar e confirmar no rodapé de uma folha.
struct SheetButtons: View {
    @Environment(\.dismiss) private var dismiss
    let confirm: String
    var disabled = false
    var note: String?
    let action: () -> Void

    var body: some View {
        HStack {
            if let note {
                Text(note)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            Spacer()
            Button("Cancelar", role: .cancel) { dismiss() }
                .keyboardShortcut(.cancelAction)
            Button(confirm, action: action)
                .keyboardShortcut(.defaultAction)
                .disabled(disabled)
        }
        .padding(16)
    }
}

/// O caminho com ~ no lugar da pasta de início.
func abbreviatedPath(_ url: URL) -> String {
    var path = url.path(percentEncoded: false)
    if path.count > 1 && path.hasSuffix("/") { path.removeLast() }
    let home = NSHomeDirectory()
    return path.hasPrefix(home) ? "~" + path.dropFirst(home.count) : path
}

/// "wine-11.0" vira "Wine 11.0".
func wineVersionName(_ version: String) -> String {
    version.hasPrefix("wine-") ? "Wine " + version.dropFirst(5) : version
}
