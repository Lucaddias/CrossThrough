import Foundation

/// Tradutor Direct3D de uma bottle.
///
/// wined3d é o do próprio Wine (DLLs builtin). DXVK e DXMT são DLLs nativas
/// copiadas para system32/syswow64 da bottle e escolhidas por WINEDLLOVERRIDES.
/// Trocar de backend sempre restaura antes as DLLs do Wine, então os estados
/// possíveis são só estes três (o mesmo contrato de runtime/scripts/smoke.sh).
public enum GraphicsBackend: String, Codable, CaseIterable, Sendable, Identifiable {
    case dxmt
    case dxvk
    case wined3d

    public var id: String { rawValue }

    public var displayName: String {
        switch self {
        case .dxmt: return "DXMT (Metal)"
        case .dxvk: return "DXVK (Vulkan)"
        case .wined3d: return "Wine (OpenGL)"
        }
    }

    public var summary: String {
        switch self {
        case .dxmt: return "Direct3D 10/11 direto no Metal. O mais rápido no Apple Silicon; Direct3D 9 continua no Wine."
        case .dxvk: return "Direct3D 9, 10 e 11 via Vulkan e MoltenVK."
        case .wined3d: return "O tradutor do próprio Wine, sobre OpenGL. O mais compatível, e o mais lento."
        }
    }

    /// Todas as DLLs que algum backend substitui; trocar de backend restaura estas.
    public static let managedDLLs = ["d3d9", "d3d10", "d3d10_1", "d3d10core", "d3d11", "dxgi"]

    /// DLLs nativas que este backend instala (vazio para o wined3d).
    public var nativeDLLs: [String] {
        switch self {
        case .dxmt: return ["d3d10core", "d3d11", "dxgi"]
        case .dxvk: return Self.managedDLLs
        case .wined3d: return []
        }
    }

    /// Entrada de WINEDLLOVERRIDES (sem o separador), ou nil para o wined3d.
    public var dllOverride: String? {
        nativeDLLs.isEmpty ? nil : nativeDLLs.joined(separator: ",") + "=n,b"
    }

    /// O arquivo que deve estar em system32/syswow64 para cada DLL gerenciada.
    func expectedFiles(runtime: Runtime, arch: WindowsArch) -> [(dll: String, source: URL)] {
        Self.managedDLLs.map { dll in
            let dir = nativeDLLs.contains(dll)
                ? runtime.backendDLLDirectory(rawValue, arch)
                : runtime.wineDLLDirectory(arch)
            return (dll, dir.appending(path: "\(dll).dll"))
        }
    }

    /// true se a bottle já tem exatamente as DLLs deste backend (deste runtime).
    public func isInstalled(in bottle: Bottle, runtime: Runtime) -> Bool {
        let fm = FileManager.default
        for arch in WindowsArch.allCases {
            let sys = bottle.windowsDirectory.appending(path: arch.systemDirectoryName)
            for (dll, source) in expectedFiles(runtime: runtime, arch: arch) {
                let target = sys.appending(path: "\(dll).dll")
                if !fm.contentsEqual(atPath: source.path, andPath: target.path) { return false }
            }
        }
        return true
    }

    /// Coloca na bottle as DLLs deste backend. Cada arquivo é trocado de forma
    /// atômica, então uma falha no meio não deixa uma DLL pela metade.
    public func install(in bottle: Bottle, runtime: Runtime) throws {
        let fm = FileManager.default
        for arch in WindowsArch.allCases {
            let sys = bottle.windowsDirectory.appending(path: arch.systemDirectoryName)
            guard fm.fileExists(atPath: sys.path) else {
                throw BottleError.incomplete(name: bottle.name, missing: arch.systemDirectoryName)
            }
            for (dll, source) in expectedFiles(runtime: runtime, arch: arch) {
                guard fm.fileExists(atPath: source.path) else {
                    throw RuntimeError.invalid(path: runtime.root.path, reason: "\(source.lastPathComponent) ausente em \(source.deletingLastPathComponent().path)")
                }
                let target = sys.appending(path: "\(dll).dll")
                if fm.contentsEqual(atPath: source.path, andPath: target.path) { continue }
                try replaceFile(at: target, with: source)
            }
        }
    }
}

/// Um backend que um programa da bottle pede, e por quê.
public struct GraphicsAdvice: Sendable, Equatable {
    public var backend: GraphicsBackend
    /// O nome do programa (o do atalho).
    public var program: String
    public var reason: String
}

extension GraphicsBackend {
    /// Programas que não abrem com os backends nativos, pelo executável. Só
    /// entra aqui o que foi testado neste runtime.
    static let requirements: [String: (backend: GraphicsBackend, reason: String)] = {
        let ea = (GraphicsBackend.wined3d,
                  "O EA app é feito com o Chromium, que não abre com o DXMT nem com o DXVK. Com o Wine (OpenGL) ele funciona.")
        return ["ealauncher.exe": ea, "eadesktop.exe": ea]
    }()

    /// O backend que algum destes programas pede, se algum pedir.
    public static func advice(for programs: [Program]) -> GraphicsAdvice? {
        for program in programs {
            guard let file = program.target?.lastPathComponent.lowercased(),
                  let requirement = requirements[file] else { continue }
            return GraphicsAdvice(backend: requirement.backend, program: program.name, reason: requirement.reason)
        }
        return nil
    }
}

/// Copia `source` sobre `target` passando por um arquivo temporário no mesmo diretório.
func replaceFile(at target: URL, with source: URL) throws {
    let fm = FileManager.default
    let temp = target.deletingLastPathComponent().appending(path: ".\(target.lastPathComponent).\(UUID().uuidString)")
    try fm.copyItem(at: source, to: temp)
    do {
        if fm.fileExists(atPath: target.path) {
            _ = try fm.replaceItemAt(target, withItemAt: temp)
        } else {
            try fm.moveItem(at: temp, to: target)
        }
    } catch {
        try? fm.removeItem(at: temp)
        throw error
    }
}
