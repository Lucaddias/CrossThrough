import CrossThroughKit
import SwiftUI

struct CatalogView: View {
    @Environment(AppModel.self) private var model
    @State private var search = ""
    @State private var category: Recipe.Category?

    private var recipes: [Recipe] {
        model.catalog.recipes
            .filter { category == nil || $0.category == category }
            .filter { recipe in
                search.isEmpty || [recipe.name, recipe.summary, recipe.id].contains {
                    $0.localizedCaseInsensitiveContains(search)
                }
            }
            .sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
    }

    var body: some View {
        @Bindable var model = model
        NavigationStack(path: $model.catalogPath) {
            Group {
                if let problem = model.catalogProblem {
                    ContentUnavailableView("O catálogo não pôde ser lido", systemImage: "exclamationmark.triangle",
                                           description: Text(problem))
                } else if recipes.isEmpty {
                    ContentUnavailableView.search(text: search)
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 260), spacing: 14)], spacing: 14) {
                            ForEach(recipes) { recipe in
                                NavigationLink(value: recipe.id) {
                                    RecipeCard(recipe: recipe, installed: !model.bottles(with: recipe).isEmpty)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(20)
                    }
                }
            }
            .navigationTitle("Catálogo")
            .searchable(text: $search, placement: .toolbar, prompt: "Buscar programas")
            .toolbar {
                ToolbarItem {
                    Picker("Categoria", selection: $category) {
                        Text("Todas as categorias").tag(Recipe.Category?.none)
                        Divider()
                        ForEach(categories, id: \.self) { category in
                            Text(category.displayName).tag(Recipe.Category?.some(category))
                        }
                    }
                    .pickerStyle(.menu)
                    .help("Mostrar só uma categoria")
                }
            }
            .navigationDestination(for: String.self) { id in
                if let recipe = model.catalog.recipe(id: id) {
                    // Uma identidade por receita: ao trocar uma pela outra no caminho,
                    // o formulário (nome, destino) não pode vir da anterior.
                    RecipeDetailView(recipe: recipe).id(id)
                }
            }
        }
    }

    /// Só as categorias que têm alguma receita.
    private var categories: [Recipe.Category] {
        let used = Set(model.catalog.recipes.map(\.category))
        return Recipe.Category.allCases.filter(used.contains)
    }
}

struct RecipeCard: View {
    let recipe: Recipe
    let installed: Bool
    @State private var hovering = false

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            CategoryBadge(category: recipe.category, size: 44)
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.summary)
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                if installed {
                    Label("Instalado", systemImage: "checkmark.circle.fill")
                        .font(.caption)
                        .foregroundStyle(.green)
                }
            }
            Spacer(minLength: 0)
        }
        .padding(14)
        .frame(maxWidth: .infinity, minHeight: 96, alignment: .topLeading)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(nsColor: .controlBackgroundColor)))
        .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(hovering ? Color.accentColor : Color(nsColor: .separatorColor)))
        .contentShape(RoundedRectangle(cornerRadius: 10))
        .onHover { hovering = $0 }
        .accessibilityElement(children: .combine)
        .accessibilityHint("Mostra os detalhes e a instalação")
    }
}

/// O símbolo da categoria num quadrado colorido (as receitas não trazem ícone).
struct CategoryBadge: View {
    let category: Recipe.Category
    let size: CGFloat

    var body: some View {
        RoundedRectangle(cornerRadius: size * 0.22, style: .continuous)
            .fill(color.gradient)
            .frame(width: size, height: size)
            .overlay {
                Image(systemName: symbol)
                    .font(.system(size: size * 0.46, weight: .medium))
                    .foregroundStyle(.white)
            }
            .accessibilityHidden(true)
    }

    private var symbol: String {
        switch category {
        case .games: return "gamecontroller.fill"
        case .launchers: return "bag.fill"
        case .productivity: return "doc.text.fill"
        case .utilities: return "wrench.and.screwdriver.fill"
        case .development: return "chevron.left.forwardslash.chevron.right"
        case .multimedia: return "play.rectangle.fill"
        case .internet: return "globe"
        }
    }

    private var color: Color {
        switch category {
        case .games: return .purple
        case .launchers: return .indigo
        case .productivity: return .blue
        case .utilities: return .teal
        case .development: return .orange
        case .multimedia: return .pink
        case .internet: return .green
        }
    }
}

struct RecipeDetailView: View {
    @Environment(AppModel.self) private var model
    let recipe: Recipe

    enum Destination: Hashable {
        case newBottle
        case existing(Bottle.ID)
    }

    @State private var destination = Destination.newBottle
    @State private var bottleName = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                header
                if let notes = recipe.notes {
                    Label(notes, systemImage: "exclamationmark.triangle")
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.orange.opacity(0.12), in: RoundedRectangle(cornerRadius: 8))
                }
                GroupBox {
                    installForm.padding(6)
                } label: {
                    Text("Instalar")
                }
                GroupBox {
                    details.padding(6)
                } label: {
                    Text("Detalhes")
                }
                let installedIn = model.bottles(with: recipe)
                if !installedIn.isEmpty {
                    GroupBox {
                        VStack(alignment: .leading, spacing: 6) {
                            ForEach(installedIn) { bottle in
                                Button {
                                    model.selection = .bottle(bottle.id)
                                } label: {
                                    Label(bottle.name, systemImage: "shippingbox")
                                }
                                .buttonStyle(.link)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(6)
                    } label: {
                        Text("Instalado em")
                    }
                }
            }
            .padding(24)
            .frame(maxWidth: 760, alignment: .leading)
            .frame(maxWidth: .infinity)
        }
        .navigationTitle(recipe.name)
        .onAppear {
            if bottleName.isEmpty { bottleName = model.store.availableName(base: recipe.name) }
            // Só dependências (Visual C++, fontes): o normal é pôr numa bottle que já tem o programa.
            if recipe.install == .none, let bottle = model.selectedBottle ?? model.bottles.first {
                destination = .existing(bottle.id)
            }
        }
    }

    private var header: some View {
        HStack(alignment: .center, spacing: 16) {
            CategoryBadge(category: recipe.category, size: 72)
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.largeTitle.weight(.semibold))
                Text(recipe.summary)
                    .foregroundStyle(.secondary)
                if let homepage = recipe.homepage {
                    Link(homepage.host() ?? homepage.absoluteString, destination: homepage)
                        .font(.callout)
                }
            }
        }
    }

    @ViewBuilder private var installForm: some View {
        if let job = model.job(forRecipe: recipe.id) {
            VStack(alignment: .leading, spacing: 8) {
                if let fraction = job.fraction {
                    ProgressView(value: fraction)
                } else {
                    ProgressView().progressViewStyle(.linear)
                }
                HStack {
                    Text(job.detail.isEmpty ? "Começando" : job.detail)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Button("Cancelar") { job.cancel() }
                }
            }
        } else {
            VStack(alignment: .leading, spacing: 12) {
                Grid(alignment: .leadingFirstTextBaseline, horizontalSpacing: 10, verticalSpacing: 10) {
                    GridRow {
                        Text("Onde").gridColumnAlignment(.trailing)
                        Picker("Onde", selection: $destination) {
                            Text("Numa bottle nova").tag(Destination.newBottle)
                            if !model.bottles.isEmpty {
                                Divider()
                                ForEach(model.bottles) { bottle in
                                    Text(bottle.name).tag(Destination.existing(bottle.id))
                                }
                            }
                        }
                        .labelsHidden()
                        .frame(maxWidth: 360)
                    }
                    if destination == .newBottle {
                        GridRow {
                            Text("Nome")
                            TextField("Nome da bottle", text: $bottleName)
                                .labelsHidden()
                                .frame(maxWidth: 360)
                        }
                        if let problem = nameProblem {
                            GridRow {
                                Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                                Text(problem).font(.caption).foregroundStyle(.red)
                            }
                        }
                    }
                }
                if destination != .newBottle && recipe.bottle != nil {
                    Text("Numa bottle que já existe, a versão do Windows e o backend gráfico dela não mudam.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                HStack {
                    Spacer()
                    Button("Instalar") { install() }
                        .buttonStyle(.borderedProminent)
                        .keyboardShortcut(.defaultAction)
                        .disabled(model.runtime == nil || (destination == .newBottle && nameProblem != nil))
                }
            }
        }
    }

    private var nameProblem: String? {
        let name = bottleName
        do { try BottleStore.validateName(name) } catch { return error.localizedDescription }
        if FileManager.default.fileExists(atPath: model.store.url(for: name).path) {
            return BottleError.alreadyExists(name).localizedDescription
        }
        return nil
    }

    private func install() {
        switch destination {
        case .newBottle:
            model.install(recipe, into: .newBottle(name: bottleName))
        case .existing(let id):
            if let bottle = model.bottle(id: id) { model.install(recipe, into: .existing(bottle)) }
        }
    }

    private var details: some View {
        Grid(alignment: .leadingFirstTextBaseline, horizontalSpacing: 16, verticalSpacing: 8) {
            row("Categoria", recipe.category.displayName)
            if let license = recipe.license { row("Licença", license) }
            if let download = recipe.download {
                row("Instalador", "\(download.resolvedFileName) (\(download.url.host() ?? download.url.absoluteString))")
                if let sha = download.sha256 { row("SHA-256", sha, monospaced: true) }
            }
            row("Instalação", installDescription)
            if !recipe.winetricks.isEmpty { row("Dependências", recipe.winetricks.joined(separator: ", ")) }
            if let version = recipe.bottle?.windowsVersion { row("Windows", version.displayName) }
            if let graphics = recipe.bottle?.graphics { row("Gráficos", graphics.displayName) }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var installDescription: String {
        switch recipe.install {
        case .run(let arguments): return arguments.isEmpty ? "roda o instalador" : "roda o instalador (\(arguments.joined(separator: " ")))"
        case .msi: return "Windows Installer (msiexec)"
        case .extract(let destination, _): return "extrai em \(destination)"
        case .none: return "só as dependências"
        }
    }

    private func row(_ label: String, _ value: String, monospaced: Bool = false) -> some View {
        GridRow {
            Text(label)
                .foregroundStyle(.secondary)
                .gridColumnAlignment(.trailing)
            Text(value)
                .font(monospaced ? .caption.monospaced() : .body)
                .textSelection(.enabled)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
