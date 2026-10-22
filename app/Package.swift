// swift-tools-version: 6.0
//
// CrossThrough: app, CLI e a biblioteca que os dois usam. Sem dependências
// externas: só Foundation, AppKit e SwiftUI.
import PackageDescription

let package = Package(
    name: "CrossThrough",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "CrossThroughKit", targets: ["CrossThroughKit"]),
        .executable(name: "crossthrough", targets: ["crossthrough"]),
        .executable(name: "CrossThroughApp", targets: ["CrossThroughApp"]),
    ],
    targets: [
        // Bottles, runtime, programas, catálogo e instalação. Não conhece a UI.
        .target(name: "CrossThroughKit"),
        // Linha de comando sobre o mesmo Kit (uso direto e testes sem GUI).
        .executableTarget(name: "crossthrough", dependencies: ["CrossThroughKit"]),
        // O app SwiftUI. O bundle .app é montado por scripts/bundle.sh.
        .executableTarget(name: "CrossThroughApp", dependencies: ["CrossThroughKit"]),
        .testTarget(name: "CrossThroughKitTests", dependencies: ["CrossThroughKit"],
                    resources: [.copy("Fixtures")]),
    ]
)
