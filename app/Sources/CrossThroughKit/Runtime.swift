import Foundation

/// O manifesto `runtime.json` que `runtime/scripts/assemble.sh` grava na raiz do runtime.
public struct RuntimeManifest: Codable, Sendable, Equatable {
    public struct Component: Codable, Sendable, Equatable, Identifiable {
        public var id: String { name }
        public var name: String
        public var version: String
        public var url: String
        public var sha256: String
        public var license: String
    }

    public var name: String
    public var built: String
    public var arch: String
    public var minimumMacOS: String
    /// Comprimento máximo do caminho da raiz do runtime (ver runtime/README.md, "Contrato com o app").
    public var maxInstallPathLength: Int
    public var wine: String
    public var components: [Component]
}

public enum RuntimeError: LocalizedError, Equatable {
    case notFound(searched: [String])
    case invalid(path: String, reason: String)
    case pathTooLong(path: String, length: Int, limit: Int)

    public var errorDescription: String? {
        switch self {
        case .notFound(let searched):
            return "O runtime do CrossThrough não foi encontrado. Procurado em: \(searched.joined(separator: ", "))."
        case .invalid(let path, let reason):
            return "O runtime em \(path) está incompleto: \(reason)."
        case .pathTooLong(let path, let length, let limit):
            return "O runtime está num caminho longo demais (\(length) caracteres; o limite é \(limit)): \(path). Mova o app para uma pasta mais curta, como /Applications."
        }
    }
}

/// Uma instalação do runtime (Wine, DXVK, DXMT, Gecko, Mono), montada por `runtime/build.sh`.
public struct Runtime: Sendable, Equatable {
    public let root: URL
    public let manifest: RuntimeManifest

    /// Valida a raiz: binários, manifesto e o limite de comprimento do caminho.
    public init(root: URL) throws {
        let root = root.standardizedFileURL.resolvingSymlinksInPath()
        let fm = FileManager.default
        for tool in ["bin/wine", "bin/wineserver"] where !fm.isExecutableFile(atPath: root.appending(path: tool).path) {
            throw RuntimeError.invalid(path: root.path, reason: "\(tool) ausente")
        }
        guard fm.fileExists(atPath: root.appending(path: Self.launcherPath).path) else {
            throw RuntimeError.invalid(path: root.path, reason: "\(Self.launcherPath) ausente")
        }
        let manifestURL = root.appending(path: "runtime.json")
        let manifest: RuntimeManifest
        do {
            manifest = try JSONDecoder().decode(RuntimeManifest.self, from: Data(contentsOf: manifestURL))
        } catch {
            throw RuntimeError.invalid(path: root.path, reason: "runtime.json ilegível (\(error.localizedDescription))")
        }
        // O limite vem de buffers WCHAR do Wine: conta em unidades UTF-16.
        let length = root.path.utf16.count
        guard length <= manifest.maxInstallPathLength else {
            throw RuntimeError.pathTooLong(path: root.path, length: length, limit: manifest.maxInstallPathLength)
        }
        self.root = root
        self.manifest = manifest
    }

    public var wine: URL { root.appending(path: "bin/wine") }
    public var wineserver: URL { root.appending(path: "bin/wineserver") }
    public var binDirectory: URL { root.appending(path: "bin") }
    public var winetricks: URL { root.appending(path: "share/winetricks/winetricks") }
    /// O programa do Windows que abre programas e acompanha a árvore de
    /// processos deles (runtime/helpers/ctlaunch.c). Roda com `wine <caminho>`.
    public var launcher: URL { root.appending(path: Self.launcherPath) }
    static let launcherPath = "lib/crossthrough/ctlaunch.exe"

    /// DLLs PE do próprio Wine para uma arquitetura.
    public func wineDLLDirectory(_ arch: WindowsArch) -> URL {
        root.appending(path: "lib/wine/\(arch.rawValue)-windows")
    }

    /// DLLs nativas de um backend gráfico (lib/dxvk, lib/dxmt) para uma arquitetura.
    public func backendDLLDirectory(_ name: String, _ arch: WindowsArch) -> URL {
        root.appending(path: "lib/\(name)/\(arch.rawValue)-windows")
    }

    /// Onde procurar o runtime, em ordem:
    /// 1. `CROSSTHROUGH_RUNTIME` no ambiente;
    /// 2. dentro do app: `Contents/SharedSupport/CrossThroughRuntime`;
    /// 3. relativo ao executável (o CLI que vai no app, em `Contents/Helpers`);
    /// 4. a saída do build no repositório (`runtime/out/CrossThroughRuntime`), para desenvolvimento.
    public static func candidates(environment: [String: String] = ProcessInfo.processInfo.environment,
                                  bundle: Bundle = .main,
                                  executable: URL? = Bundle.main.executableURL) -> [URL] {
        var list: [URL] = []
        if let path = environment["CROSSTHROUGH_RUNTIME"], !path.isEmpty {
            list.append(URL(fileURLWithPath: path))
        }
        if let shared = bundle.sharedSupportURL {
            list.append(shared.appending(path: "CrossThroughRuntime"))
        }
        if let exe = executable?.resolvingSymlinksInPath() {
            // .../CrossThrough.app/Contents/Helpers/crossthrough -> Contents/SharedSupport
            let contents = exe.deletingLastPathComponent().deletingLastPathComponent()
            list.append(contents.appending(path: "SharedSupport/CrossThroughRuntime"))
            // .../app/.build/<config>/crossthrough -> <repo>/runtime/out/CrossThroughRuntime
            var dir = exe.deletingLastPathComponent()
            for _ in 0..<6 {
                let candidate = dir.appending(path: "runtime/out/CrossThroughRuntime")
                if FileManager.default.fileExists(atPath: candidate.path) { list.append(candidate); break }
                dir = dir.deletingLastPathComponent()
            }
        }
        var seen = Set<String>()
        return list.filter { seen.insert($0.standardizedFileURL.path).inserted }
    }

    /// O primeiro candidato válido. Um candidato que existe mas é inválido é
    /// reportado (não é pulado em silêncio): esconder isso só confundiria.
    public static func locate(environment: [String: String] = ProcessInfo.processInfo.environment,
                              bundle: Bundle = .main,
                              executable: URL? = Bundle.main.executableURL) throws -> Runtime {
        let list = candidates(environment: environment, bundle: bundle, executable: executable)
        for url in list where FileManager.default.fileExists(atPath: url.path) {
            return try Runtime(root: url)
        }
        throw RuntimeError.notFound(searched: list.map(\.path))
    }
}

/// Arquiteturas de DLL que o Wine com WoW64 instala numa bottle.
public enum WindowsArch: String, CaseIterable, Sendable {
    case x86_64
    case i386

    /// Diretório da bottle que recebe as DLLs desta arquitetura.
    public var systemDirectoryName: String {
        switch self {
        case .x86_64: return "system32"
        case .i386: return "syswow64"
        }
    }
}
