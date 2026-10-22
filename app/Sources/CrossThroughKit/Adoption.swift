import Foundation

/// Um prefixo do Wine no diretório das bottles sem o nosso `crossthrough.json`:
/// criado por outro programa ou por uma versão antiga do CrossThrough. Aparece
/// para poder ser adotado, em vez de sumir da lista.
public struct ForeignBottle: Sendable, Hashable, Identifiable {
    public let url: URL

    public init(url: URL) {
        self.url = url.standardizedFileURL
    }

    public var id: String { url.path }
    public var name: String { url.lastPathComponent }

    /// Tem o registro do sistema e o disco C:.
    static func isWinePrefix(_ url: URL) -> Bool {
        let fm = FileManager.default
        var isDirectory: ObjCBool = false
        return fm.fileExists(atPath: url.appending(path: "system.reg").path)
            && fm.fileExists(atPath: url.appending(path: "drive_c").path, isDirectory: &isDirectory)
            && isDirectory.boolValue
    }

    /// A versão do Windows que o prefixo informa aos programas: o `CurrentBuild`
    /// de HKLM\Software\Microsoft\Windows NT\CurrentVersion, no system.reg.
    public var windowsVersion: WindowsVersion? {
        guard let data = try? Data(contentsOf: url.appending(path: "system.reg"), options: .mappedIfSafe) else {
            return nil
        }
        return Self.windowsVersion(inSystemRegistry: String(decoding: data, as: UTF8.self))
    }

    /// No arquivo do Wine as barras das chaves vêm dobradas e a linha da chave
    /// termina com a data de gravação: `[Software\\...\\CurrentVersion] 1729...`.
    static func windowsVersion(inSystemRegistry text: String) -> WindowsVersion? {
        let key = #"[Software\\Microsoft\\Windows NT\\CurrentVersion]"#
        let value = #""CurrentBuild"=""#
        var inKey = false
        for line in text.split(separator: "\n") {
            if line.hasPrefix("[") {
                if inKey { return nil }
                inKey = line.hasPrefix(key)
            } else if inKey, line.hasPrefix(value) {
                return Int(line.dropFirst(value.count).prefix { $0.isNumber }).flatMap(WindowsVersion.init(build:))
            }
        }
        return nil
    }
}

extension WindowsVersion {
    /// A versão de um número de build do Windows.
    public init?(build: Int) {
        switch build {
        case 22000...: self = .win11
        case 10240..<22000: self = .win10
        case 9600..<10240: self = .win81
        case 9200..<9600: self = .win8
        case 7600..<9200: self = .win7
        case 6000..<7600: self = .vista
        case 2600..<6000: self = .winxp
        default: return nil
        }
    }
}

extension BottleStore {
    /// Passa a usar como bottle um prefixo do Wine de outro programa. O Windows
    /// dele é atualizado para este Wine (`wineboot --update`, o que o Wine faria
    /// sozinho ao abrir o primeiro programa), o backend gráfico é instalado e o
    /// `crossthrough.json` é gravado por último: se algo falhar, o prefixo
    /// continua de fora, e dá para tentar de novo. Programas instalados, dados
    /// e os arquivos do outro programa ficam onde estão.
    public func adopt(_ foreign: ForeignBottle,
                      graphics: GraphicsBackend = .dxmt,
                      runtime: Runtime,
                      progress: (@Sendable (BottleCreationStep) -> Void)? = nil) async throws -> Bottle {
        let fm = FileManager.default
        if let bottle = try Bottle.load(from: foreign.url) { return bottle }
        guard ForeignBottle.isWinePrefix(foreign.url) else {
            throw BottleError.incomplete(name: foreign.name, missing: "system.reg ou drive_c")
        }
        let created = (try? foreign.url.resourceValues(forKeys: [.creationDateKey]))?.creationDate ?? Date()
        let config = BottleConfig(windowsVersion: foreign.windowsVersion ?? .wineDefault, graphics: graphics,
                                  created: created, adopted: Date())
        let bottle = Bottle(url: foreign.url, config: config)
        let wine = Wine(runtime: runtime, bottle: bottle)
        let log = Logs.newLog(for: bottle, named: "adoção")

        progress?(.updating)
        let update = try await wine.run(["wineboot", "--update"], workingDirectory: foreign.url, log: log,
                                        timeout: .seconds(900))
        // O wineboot sobe os serviços da bottle (o de um launcher, por exemplo),
        // que ficariam rodando. O wineserver grava o registro ao encerrar.
        try? await wine.stopAll()
        guard update.succeeded else {
            throw BottleError.commandFailed(command: "wineboot --update", status: update.status, log: log.path)
        }
        for sys in ["system32/kernel32.dll", "syswow64/kernel32.dll"]
        where !fm.fileExists(atPath: bottle.windowsDirectory.appending(path: sys).path) {
            throw BottleError.incomplete(name: foreign.name, missing: "windows/\(sys)")
        }

        progress?(.installingGraphics(graphics))
        try graphics.install(in: bottle, runtime: runtime)

        progress?(.finishing)
        try bottle.save()
        return bottle
    }
}
