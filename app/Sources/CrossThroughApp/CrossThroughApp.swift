import CrossThroughKit
import SwiftUI

@main
struct CrossThroughApp: App {
    @State private var model = AppModel()

    var body: some Scene {
        Window("CrossThrough", id: "main") {
            ContentView()
                .environment(model)
                .frame(minWidth: 860, minHeight: 540)
                .task {
                    await model.reload()
                    Snapshot.runIfRequested(model: model)
                }
        }
        .defaultSize(width: 1100, height: 720)
        .commands {
            CommandGroup(replacing: .newItem) {
                Button("Nova bottle…") { model.presentingNewBottle = true }
                    .keyboardShortcut("n")
                    .disabled(model.runtime == nil)
                Button("Executar arquivo na bottle…") { model.presentingRunFile = true }
                    .keyboardShortcut("o")
                    .disabled(model.selectedBottle == nil)
            }
            CommandGroup(after: .sidebar) {
                Button("Atualizar") { Task { await model.reload() } }
                    .keyboardShortcut("r")
            }
            CommandGroup(replacing: .help) {
                Button("Mostrar os logs") { model.openFolder(Logs.root) }
                Link("Código-fonte do CrossThrough", destination: URL(string: "https://github.com/Lucaddias/CrossThrough")!)
            }
        }

        Settings {
            SettingsView()
                .environment(model)
        }
    }
}
