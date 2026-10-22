import CrossThroughKit
import SwiftUI

/// Um prefixo do Wine de outro programa: o que é, o que a adoção faz e o botão.
struct ForeignBottleView: View {
    @Environment(AppModel.self) private var model
    let foreign: ForeignBottle
    @State private var graphics = GraphicsBackend.dxmt
    @State private var windows: WindowsVersion?
    @State private var advice: GraphicsAdvice?

    var body: some View {
        // Numa ScrollView, como as outras telas: fora dela, os textos com
        // fixedSize medem a altura mínima com largura zero (uma letra por
        // linha), e a janela inteira cresce para milhares de pontos.
        GeometryReader { proxy in
            ScrollView {
                details
                    .padding(40)
                    .frame(maxWidth: .infinity, minHeight: proxy.size.height)
            }
            .scrollBounceBehavior(.basedOnSize)
        }
        .navigationTitle(foreign.name)
        .task(id: foreign.id) {
            let foreign = self.foreign
            let (version, found) = await Task.detached {
                (foreign.windowsVersion,
                 GraphicsBackend.advice(for: ProgramScanner.scan(Bottle(url: foreign.url, config: BottleConfig()))))
            }.value
            windows = version
            advice = found
            if let found { graphics = found.backend }
        }
    }

    private var details: some View {
        VStack(spacing: 16) {
            Image(systemName: "shippingbox.and.arrow.backward")
                .font(.system(size: 44))
                .foregroundStyle(.secondary)
                .accessibilityHidden(true)
            Text("“\(foreign.name)” veio de outro programa")
                .font(.title2.weight(.semibold))
                .multilineTextAlignment(.center)
            Text("Esta pasta é um Windows do Wine criado fora do CrossThrough. Para usá-la aqui, o CrossThrough atualiza o Windows dela para o \(wineName) e instala o backend gráfico escolhido. Os programas instalados, os dados e os arquivos do outro programa ficam como estão.")
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 540)
                .fixedSize(horizontal: false, vertical: true)
            if let job = model.job(forBottle: foreign.id) {
                VStack(alignment: .leading, spacing: 8) {
                    ProgressView().progressViewStyle(.linear)
                    Text(job.detail.isEmpty ? "Começando" : job.detail)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: 400)
                .padding(.top, 8)
            } else {
                Grid(alignment: .leadingFirstTextBaseline, horizontalSpacing: 10, verticalSpacing: 10) {
                    GridRow {
                        Text("Gráficos").gridColumnAlignment(.trailing)
                        Picker("Gráficos", selection: $graphics) {
                            ForEach(GraphicsBackend.allCases) { Text($0.displayName).tag($0) }
                        }
                        .labelsHidden()
                        .frame(maxWidth: 240)
                    }
                    if let advice {
                        GridRow {
                            Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                            Label(advice.backend == graphics ? advice.reason : "Recomendado: \(advice.backend.displayName). \(advice.reason)",
                                  systemImage: advice.backend == graphics ? "info.circle" : "exclamationmark.triangle")
                                .font(.caption)
                                .foregroundStyle(advice.backend == graphics ? Color.secondary : Color.orange)
                                .frame(maxWidth: 380, alignment: .leading)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    GridRow {
                        Text("Windows")
                        Text(windows?.displayName ?? "não identificado (fica \(WindowsVersion.wineDefault.displayName))")
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.top, 8)
                Text("Feche antes o que estiver aberto nela pelo outro programa.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                HStack(spacing: 12) {
                    Button("Mostrar no Finder") { model.reveal(foreign.url) }
                    Button("Usar no CrossThrough") { model.adopt(foreign, graphics: graphics) }
                        .buttonStyle(.borderedProminent)
                        .keyboardShortcut(.defaultAction)
                        .disabled(model.runtime == nil)
                }
            }
        }
    }

    private var wineName: String {
        model.runtime.map { wineVersionName($0.manifest.wine) } ?? "Wine deste app"
    }
}
