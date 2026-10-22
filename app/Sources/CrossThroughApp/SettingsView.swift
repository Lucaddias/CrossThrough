import CrossThroughKit
import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            GeneralSettingsView()
                .tabItem { Label("Geral", systemImage: "gearshape") }
            RuntimeSettingsView()
                .tabItem { Label("Runtime", systemImage: "cpu") }
        }
        .frame(width: 600, height: 440)
    }
}

struct GeneralSettingsView: View {
    @Environment(AppModel.self) private var model
    @AppStorage("verboseLogs") private var verboseLogs = false
    @State private var downloadsSize: Int64?
    @State private var confirmingClear = false

    var body: some View {
        Form {
            Section {
                Toggle("Log detalhado do Wine, DXVK e MoltenVK", isOn: $verboseLogs)
                Text("Vale para os programas abertos daqui em diante. Os logs ficam em ~/Library/Logs/CrossThrough.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Section("Pastas") {
                folder("Bottles", model.store.root)
                folder("Logs", Logs.root)
                LabeledContent("Downloads") {
                    HStack {
                        Text(downloadsSize.map { ByteCountFormatter.string(fromByteCount: $0, countStyle: .file) } ?? "…")
                            .foregroundStyle(.secondary)
                        Button("Mostrar") { model.openFolder(Downloader.cacheDirectory) }
                        Button("Apagar…") { confirmingClear = true }
                            .disabled(downloadsSize == 0)
                    }
                }
            }
        }
        .formStyle(.grouped)
        .task { await measureDownloads() }
        .confirmationDialog("Apagar os instaladores baixados?", isPresented: $confirmingClear) {
            Button("Apagar", role: .destructive) {
                try? FileManager.default.removeItem(at: Downloader.cacheDirectory)
                Task { await measureDownloads() }
            }
        } message: {
            Text("Os programas instalados não são afetados; uma nova instalação baixa o instalador de novo.")
        }
    }

    private func folder(_ title: String, _ url: URL) -> some View {
        LabeledContent(title) {
            HStack {
                Text(abbreviatedPath(url))
                    .lineLimit(1)
                    .truncationMode(.middle)
                    .foregroundStyle(.secondary)
                Button("Mostrar") { model.openFolder(url) }
            }
        }
    }

    private func measureDownloads() async {
        let dir = Downloader.cacheDirectory
        downloadsSize = await Task.detached { Self.size(of: dir) }.value
    }

    nonisolated private static func size(of directory: URL) -> Int64 {
        guard let items = FileManager.default.enumerator(at: directory, includingPropertiesForKeys: [.fileSizeKey]) else {
            return 0
        }
        var total: Int64 = 0
        for case let url as URL in items {
            total += Int64((try? url.resourceValues(forKeys: [.fileSizeKey]).fileSize) ?? 0)
        }
        return total
    }
}

struct RuntimeSettingsView: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        if let runtime = model.runtime {
            VStack(alignment: .leading, spacing: 12) {
                Grid(alignment: .leadingFirstTextBaseline, horizontalSpacing: 12, verticalSpacing: 6) {
                    GridRow {
                        Text("Wine").foregroundStyle(.secondary)
                        Text(wineVersionName(runtime.manifest.wine))
                    }
                    GridRow {
                        Text("Compilado em").foregroundStyle(.secondary)
                        if let date = try? Date(runtime.manifest.built, strategy: .iso8601) {
                            Text(date, format: .dateTime.day().month(.wide).year().hour().minute())
                        } else {
                            Text(runtime.manifest.built)
                        }
                    }
                    GridRow {
                        Text("Local").foregroundStyle(.secondary)
                        HStack {
                            Text(abbreviatedPath(runtime.root))
                                .lineLimit(1)
                                .truncationMode(.middle)
                            Button("Mostrar") { model.reveal(runtime.root) }
                        }
                    }
                }
                Table(runtime.manifest.components) {
                    TableColumn("Componente", value: \.name)
                    TableColumn("Versão", value: \.version)
                    TableColumn("Licença", value: \.license)
                }
                HStack {
                    Text("Tudo compilado do código-fonte; as licenças de cada parte vêm com o runtime.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Button("Licenças") { model.openFolder(runtime.root.appending(path: "share/licenses")) }
                }
            }
            .padding(20)
        } else {
            ContentUnavailableView("Runtime não encontrado", systemImage: "exclamationmark.triangle",
                                   description: Text(model.runtimeProblem ?? ""))
        }
    }
}
