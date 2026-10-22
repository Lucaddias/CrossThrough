import CrossThroughKit
import SwiftUI
import UniformTypeIdentifiers

/// Os tipos que dá para rodar numa bottle.
let windowsFileTypes: [UTType] = ["exe", "msi", "bat", "lnk", "com"].compactMap { UTType(filenameExtension: $0) }

struct BottleView: View {
    @Environment(AppModel.self) private var model
    let bottle: Bottle
    @State private var dropTargeted = false

    var body: some View {
        @Bindable var model = model
        content
            .navigationTitle(bottle.name)
            .navigationSubtitle("\(bottle.config.windowsVersion.displayName) · \(bottle.config.graphics.displayName)")
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        model.presentingRunFile = true
                    } label: {
                        Label("Executar arquivo", systemImage: "play.square")
                    }
                    .help("Rodar um .exe ou .msi nesta bottle (ou arraste o arquivo para a janela)")
                    Button {
                        model.presentingWinetricks = true
                    } label: {
                        Label("Winetricks", systemImage: "puzzlepiece.extension")
                    }
                    .help("Instalar bibliotecas e fontes do Windows com o winetricks")
                    Button {
                        model.openFolder(bottle.driveC)
                    } label: {
                        Label("Disco C:", systemImage: "folder")
                    }
                    .help("Abrir o disco C: da bottle no Finder")
                    Button {
                        model.stopAll(bottle)
                    } label: {
                        Label("Encerrar tudo", systemImage: "stop.circle")
                    }
                    .help("Encerrar à força tudo o que roda nesta bottle")
                    Button {
                        model.presentingBottleSettings = true
                    } label: {
                        Label("Configurações", systemImage: "gearshape")
                    }
                    .help("Versão do Windows, gráficos e opções da bottle")
                }
            }
            .fileImporter(isPresented: $model.presentingRunFile, allowedContentTypes: windowsFileTypes) { result in
                if case .success(let url) = result { model.run(file: url, in: bottle) }
            }
            .dropDestination(for: URL.self) { urls, _ in
                let files = urls.filter { ["exe", "msi", "bat", "lnk", "com"].contains($0.pathExtension.lowercased()) }
                for file in files { model.run(file: file, in: bottle) }
                return !files.isEmpty
            } isTargeted: { dropTargeted = $0 }
            .overlay {
                if dropTargeted {
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(Color.accentColor, style: StrokeStyle(lineWidth: 3, dash: [8]))
                        .padding(8)
                        .allowsHitTesting(false)
                }
            }
            .sheet(isPresented: $model.presentingBottleSettings) { BottleSettingsView(bottle: bottle) }
            .sheet(isPresented: $model.presentingWinetricks) { WinetricksView(bottle: bottle) }
            .task(id: bottle.id) { await model.refreshPrograms(bottle) }
    }

    @ViewBuilder private var content: some View {
        if let programs = model.programs[bottle.id] {
            if programs.isEmpty {
                ContentUnavailableView {
                    Label("Nenhum programa", systemImage: "app.dashed")
                } description: {
                    Text("Instale um programa do catálogo, ou rode um instalador (.exe ou .msi) nesta bottle. Também dá para arrastar o instalador para cá.")
                } actions: {
                    Button("Executar instalador…") { model.presentingRunFile = true }
                    Button("Ver o catálogo") { model.selection = .catalog }
                }
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 128, maximum: 160), spacing: 8)], spacing: 12) {
                        ForEach(programs) { program in
                            ProgramTile(program: program, bottle: bottle)
                        }
                    }
                    .padding(20)
                }
            }
        } else {
            ProgressView()
        }
    }
}

struct ProgramTile: View {
    @Environment(AppModel.self) private var model
    let program: Program
    let bottle: Bottle
    @State private var icon: NSImage?
    @State private var hovering = false

    var body: some View {
        let isRunning = model.running[program.id] != nil
        VStack(spacing: 8) {
            ZStack(alignment: .bottomTrailing) {
                Group {
                    if let icon {
                        Image(nsImage: icon)
                            .resizable()
                            .interpolation(.high)
                            .aspectRatio(contentMode: .fit)
                    } else {
                        Image(systemName: "app.dashed")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.secondary)
                            .padding(6)
                    }
                }
                .frame(width: 64, height: 64)
                if isRunning {
                    Circle()
                        .fill(.green)
                        .frame(width: 14, height: 14)
                        .overlay(Circle().strokeBorder(Color(nsColor: .windowBackgroundColor), lineWidth: 2))
                        .offset(x: 4, y: 4)
                        .help("Aberto")
                }
            }
            Text(program.name)
                .font(.callout)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(maxWidth: .infinity)
        }
        .padding(10)
        .frame(width: 136, height: 128, alignment: .top)
        .background(RoundedRectangle(cornerRadius: 10).fill(hovering ? Color.primary.opacity(0.07) : .clear))
        .contentShape(RoundedRectangle(cornerRadius: 10))
        .onHover { hovering = $0 }
        .onTapGesture(count: 2) { model.open(program, in: bottle) }
        .contextMenu {
            Button("Abrir") { model.open(program, in: bottle) }
                .disabled(isRunning)
            if isRunning {
                Button("Encerrar") { model.terminate(program) }
            }
            Divider()
            if let target = program.target {
                Button("Mostrar o programa no Finder") { model.reveal(target) }
            }
            Button("Mostrar o atalho no Finder") { model.reveal(program.shortcut) }
            Button("Mostrar os logs") { model.openFolder(Logs.directory(for: bottle)) }
        }
        .help(helpText)
        .task(id: program.icon) { icon = await IconStore.shared.image(for: program.icon) }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(program.name + (isRunning ? ", aberto" : ""))
        .accessibilityAddTraits(.isButton)
        .accessibilityAction { model.open(program, in: bottle) }
    }

    private var helpText: String {
        var lines = [program.name]
        if let target = program.target { lines.append(bottle.windowsPath(forUnixPath: target)) }
        if let arguments = program.arguments, !arguments.isEmpty { lines.append(arguments) }
        lines.append("Clique duas vezes para abrir.")
        return lines.joined(separator: "\n")
    }
}
