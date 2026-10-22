import CrossThroughKit
import SwiftUI

struct ContentView: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        @Bindable var model = model
        Group {
            if let problem = model.runtimeProblem {
                RuntimeProblemView(problem: problem)
            } else {
                NavigationSplitView {
                    SidebarView()
                        .navigationSplitViewColumnWidth(min: 210, ideal: 240, max: 340)
                } detail: {
                    detail
                }
            }
        }
        .alert(model.alert?.title ?? "", isPresented: Binding(get: { model.alert != nil },
                                                              set: { if !$0 { model.alert = nil } }),
               presenting: model.alert) { alert in
            if let log = alert.log {
                Button("Mostrar o log") { model.reveal(log) }
            }
            Button("OK", role: .cancel) {}
        } message: { alert in
            Text(alert.message)
        }
        .sheet(isPresented: $model.presentingNewBottle) { NewBottleView() }
    }

    @ViewBuilder private var detail: some View {
        switch model.selection {
        case .bottle(let id):
            if let bottle = model.bottle(id: id) {
                BottleView(bottle: bottle)
            } else {
                ContentUnavailableView("Bottle não encontrada", systemImage: "shippingbox")
            }
        case .foreign(let id):
            if let foreign = model.foreignBottle(id: id) {
                ForeignBottleView(foreign: foreign)
            } else {
                ContentUnavailableView("Bottle não encontrada", systemImage: "shippingbox")
            }
        case .catalog, nil:
            CatalogView()
        }
    }
}

struct SidebarView: View {
    @Environment(AppModel.self) private var model
    @State private var renaming: Bottle?
    @State private var newName = ""
    @State private var deleting: Bottle?

    var body: some View {
        @Bindable var model = model
        List(selection: $model.selection) {
            Section {
                Label("Catálogo", systemImage: "square.grid.2x2")
                    .tag(SidebarItem.catalog)
            }
            Section("Bottles") {
                ForEach(model.bottles) { bottle in
                    BottleRow(bottle: bottle)
                        .tag(SidebarItem.bottle(bottle.id))
                        .contextMenu { menu(for: bottle) }
                }
                ForEach(model.foreignBottles) { foreign in
                    Label(foreign.name, systemImage: "shippingbox.and.arrow.backward")
                        .foregroundStyle(.secondary)
                        .tag(SidebarItem.foreign(foreign.id))
                        .help("Criada por outro programa. Selecione para usar no CrossThrough.")
                        .contextMenu {
                            Button("Mostrar no Finder") { model.reveal(foreign.url) }
                        }
                }
                ForEach(model.damagedBottles, id: \.self) { name in
                    Label(name, systemImage: "exclamationmark.triangle")
                        .foregroundStyle(.secondary)
                        .help("O crossthrough.json desta bottle está ilegível.")
                }
                if model.bottles.isEmpty && model.damagedBottles.isEmpty && model.foreignBottles.isEmpty {
                    Text("Nenhuma bottle ainda")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            VStack(spacing: 0) {
                JobsFooter()
                Divider()
                HStack {
                    Button {
                        model.presentingNewBottle = true
                    } label: {
                        Label("Nova bottle", systemImage: "plus")
                    }
                    .buttonStyle(.borderless)
                    .disabled(model.runtime == nil)
                    Spacer()
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
            }
            .background(.bar)
        }
        .alert("Renomear “\(renaming?.name ?? "")”", isPresented: Binding(get: { renaming != nil },
                                                                         set: { if !$0 { renaming = nil } })) {
            TextField("Nome", text: $newName)
            Button("Renomear") {
                if let bottle = renaming { model.rename(bottle, to: newName.trimmingCharacters(in: .whitespaces)) }
            }
            Button("Cancelar", role: .cancel) {}
        } message: {
            Text("Os programas abertos nesta bottle serão encerrados.")
        }
        .confirmationDialog("Apagar “\(deleting?.name ?? "")”?", isPresented: Binding(get: { deleting != nil },
                                                                                    set: { if !$0 { deleting = nil } }),
                            presenting: deleting) { bottle in
            Button("Mover para o Lixo", role: .destructive) { model.delete(bottle) }
        } message: { _ in
            Text("A bottle e tudo o que foi instalado nela vão para o Lixo. Os programas abertos nela serão encerrados.")
        }
    }

    @ViewBuilder private func menu(for bottle: Bottle) -> some View {
        Button("Abrir o disco C: no Finder") { model.openFolder(bottle.driveC) }
        Button("Mostrar os logs") { model.openFolder(Logs.directory(for: bottle)) }
        Divider()
        Button("Renomear…") {
            newName = bottle.name
            renaming = bottle
        }
        Button("Encerrar tudo o que roda nela") { model.stopAll(bottle) }
        Divider()
        Button("Apagar…", role: .destructive) { deleting = bottle }
    }
}

struct BottleRow: View {
    @Environment(AppModel.self) private var model
    let bottle: Bottle

    var body: some View {
        let open = model.runningCount(in: bottle)
        Label {
            Text(bottle.name)
        } icon: {
            Image(systemName: "shippingbox")
        }
        .badge(open)
        .help("\(bottle.config.windowsVersion.displayName) · \(bottle.config.graphics.displayName)"
              + (open > 0 ? " · \(open) aberto(s)" : ""))
    }
}

/// As tarefas em andamento (e as que falharam), no rodapé da barra lateral.
struct JobsFooter: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        if !model.jobs.isEmpty {
            VStack(spacing: 10) {
                ForEach(model.jobs) { job in
                    JobRow(job: job)
                }
            }
            .padding(12)
            Divider()
        }
    }
}

struct JobRow: View {
    @Environment(AppModel.self) private var model
    let job: Job

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline, spacing: 6) {
                icon
                Text(job.title)
                    .font(.callout.weight(.medium))
                    .lineLimit(2)
                Spacer(minLength: 4)
                if job.isRunning {
                    Button {
                        job.cancel()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                    .buttonStyle(.borderless)
                    .foregroundStyle(.secondary)
                    .help("Cancelar")
                } else {
                    Button {
                        model.dismiss(job)
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .buttonStyle(.borderless)
                    .foregroundStyle(.secondary)
                    .help("Fechar")
                }
            }
            switch job.state {
            case .running:
                if let fraction = job.fraction {
                    ProgressView(value: fraction)
                } else {
                    ProgressView()
                        .progressViewStyle(.linear)
                }
                Text(job.detail)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            case .succeeded:
                Text("Concluído").font(.caption).foregroundStyle(.secondary)
            case .cancelled:
                Text("Cancelado").font(.caption).foregroundStyle(.secondary)
            case .failed(let message):
                Text(message)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(4)
                    .textSelection(.enabled)
                if let log = job.log {
                    Button("Mostrar o log") { model.reveal(log) }
                        .buttonStyle(.link)
                        .font(.caption)
                }
            }
        }
        .accessibilityElement(children: .contain)
    }

    @ViewBuilder private var icon: some View {
        switch job.state {
        case .running: Image(systemName: "arrow.down.circle").foregroundStyle(.tint)
        case .succeeded: Image(systemName: "checkmark.circle.fill").foregroundStyle(.green)
        case .cancelled: Image(systemName: "minus.circle").foregroundStyle(.secondary)
        case .failed: Image(systemName: "exclamationmark.triangle.fill").foregroundStyle(.orange)
        }
    }
}

struct RuntimeProblemView: View {
    let problem: String

    var body: some View {
        ContentUnavailableView {
            Label("O runtime do Wine não está disponível", systemImage: "exclamationmark.triangle")
        } description: {
            VStack(spacing: 8) {
                Text(problem)
                    .textSelection(.enabled)
                Text("O app instalado traz o runtime em Contents/SharedSupport. Para desenvolver, compile com runtime/build.sh ou aponte CROSSTHROUGH_RUNTIME para ele.")
            }
        }
        .padding(40)
    }
}
