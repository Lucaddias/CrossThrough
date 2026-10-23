import Foundation
@testable import CrossThroughKit

/// Diretório temporário apagado no fim do teste.
final class TempDirectory {
    let url: URL

    init() throws {
        url = FileManager.default.temporaryDirectory.appending(path: "crossthrough-tests-\(UUID().uuidString)")
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
    }

    deinit { try? FileManager.default.removeItem(at: url) }
}

/// Uma bottle de mentira: só a estrutura de diretórios que o Kit lê
/// (drive_c, dosdevices/c: e z:, users/crossover), sem Wine.
func makeFakeBottle(in dir: URL, name: String = "Fake") throws -> Bottle {
    let fm = FileManager.default
    let url = dir.appending(path: name)
    for sub in ["drive_c/windows/system32", "drive_c/windows/syswow64", "drive_c/users/crossover/Desktop",
                "drive_c/users/Public/Desktop", "drive_c/ProgramData/Microsoft/Windows/Start Menu/Programs",
                "drive_c/users/crossover/AppData/Roaming/Microsoft/Windows/Start Menu/Programs", "dosdevices"] {
        try fm.createDirectory(at: url.appending(path: sub), withIntermediateDirectories: true)
    }
    try fm.createSymbolicLink(atPath: url.appending(path: "dosdevices/c:").path, withDestinationPath: "../drive_c")
    try fm.createSymbolicLink(atPath: url.appending(path: "dosdevices/z:").path, withDestinationPath: "/")
    let bottle = Bottle(url: url, config: BottleConfig())
    try bottle.save()
    return bottle
}

/// Cria um arquivo (e os diretórios até ele) com algum conteúdo.
@discardableResult
func touch(_ url: URL, _ contents: String = "x") throws -> URL {
    try FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
    try Data(contents.utf8).write(to: url)
    return url
}

func fixture(_ name: String) throws -> URL {
    let base = (name as NSString).deletingPathExtension, ext = (name as NSString).pathExtension
    guard let url = Bundle.module.url(forResource: base, withExtension: ext, subdirectory: "Fixtures") else {
        throw CocoaError(.fileNoSuchFile)
    }
    return url
}

/// O runtime do repositório, se já tiver sido compilado (testes que precisam do Wine).
let builtRuntime: Runtime? = {
    var dir = URL(fileURLWithPath: #filePath)
    for _ in 0..<6 {
        dir.deleteLastPathComponent()
        let candidate = dir.appending(path: "runtime/out/CrossThroughRuntime")
        if let runtime = try? Runtime(root: candidate) { return runtime }
    }
    return nil
}()

/// Um runtime de mentira: o manifesto, o ctlaunch.exe vazio e um `bin/wine`
/// que é o script dado (o wineserver não faz nada).
func makeFakeRuntime(in dir: URL, wine script: String) throws -> Runtime {
    let root = dir.appending(path: "runtime")
    let fm = FileManager.default
    try touch(root.appending(path: "bin/wine"), script)
    try touch(root.appending(path: "bin/wineserver"), "#!/bin/sh\nexit 0\n")
    for tool in ["bin/wine", "bin/wineserver"] {
        try fm.setAttributes([.posixPermissions: 0o755], ofItemAtPath: root.appending(path: tool).path)
    }
    try touch(root.appending(path: "lib/crossthrough/ctlaunch.exe"))
    try touch(root.appending(path: "runtime.json"), """
        {"name": "CrossThroughRuntime", "built": "2026-01-01T00:00:00Z", "arch": "x86_64",
         "minimumMacOS": "12.0", "maxInstallPathLength": 1024, "wine": "wine-11.0", "components": []}
        """)
    return try Runtime(root: root)
}
