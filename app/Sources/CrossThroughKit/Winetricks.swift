import Foundation

/// Um verbo do winetricks (vcrun2022, dotnet48, corefonts, win7...).
public struct WinetricksVerb: Sendable, Hashable, Identifiable {
    public enum Category: String, Sendable, CaseIterable {
        case apps, benchmarks, dlls, fonts, settings
    }

    public var name: String
    public var category: Category
    public var title: String
    public var publisher: String?
    public var year: String?
    /// "download" quando o verbo baixa algo; "manual_download" quando o usuário tem de baixar.
    public var media: String?

    public var id: String { name }
}

/// O winetricks do runtime rodando numa bottle, no ambiente descrito no
/// contrato de runtime/README.md (o mesmo do `winetricks_env` do smoke.sh).
public struct Winetricks: Sendable {
    public let wine: Wine

    public init(wine: Wine) { self.wine = wine }

    /// XDG_CACHE_HOME do winetricks: os downloads ficam em `<isto>/winetricks`.
    public static var cacheHome: URL {
        FileManager.default.homeDirectoryForCurrentUser.appending(path: "Library/Caches/CrossThrough")
    }

    static var configHome: URL {
        FileManager.default.homeDirectoryForCurrentUser
            .appending(path: "Library/Application Support/CrossThrough/winetricks")
    }

    public func environment() -> [String: String] {
        wine.environment(extra: [
            "WINE": wine.runtime.wine.path,
            "WINESERVER": wine.runtime.wineserver.path,
            "XDG_CACHE_HOME": Self.cacheHome.path,
            "XDG_CONFIG_HOME": Self.configHome.path,
            "WINETRICKS_LATEST_VERSION_CHECK": "disabled",
        ])
    }

    /// `winetricks -q <verbos>`: instala sem perguntar e espera a bottle esvaziar.
    @discardableResult
    public func run(_ verbs: [String], log: URL, timeout: Duration? = nil) async throws -> ProcessResult {
        guard !verbs.isEmpty else { return ProcessResult(status: 0, output: "", log: log) }
        for verb in verbs where verb.isEmpty || verb.hasPrefix("-") || verb.contains(where: \.isWhitespace) {
            throw WinetricksError.invalidVerb(verb)
        }
        let fm = FileManager.default
        try fm.createDirectory(at: Self.cacheHome, withIntermediateDirectories: true)
        try fm.createDirectory(at: Self.configHome, withIntermediateDirectories: true)
        let result = try await Wine.execute(wine.runtime.winetricks, ["-q"] + verbs, environment: environment(),
                                            workingDirectory: wine.bottle.url, log: log, timeout: timeout,
                                            onTimeout: { [wine] in try? await wine.stopAll() })
        try await wine.waitForAll(timeout: .seconds(300))
        guard result.succeeded else {
            throw WinetricksError.failed(verbs: verbs, status: result.status, log: log.path,
                                         reason: Self.failureReason(result.output))
        }
        return result
    }

    /// Os verbos já aplicados na bottle, na ordem (o winetricks.log da bottle).
    public static func installedVerbs(in bottle: Bottle) -> [String] {
        let log = bottle.url.appending(path: "winetricks.log")
        guard let text = try? String(contentsOf: log, encoding: .utf8) else { return [] }
        return text.split(whereSeparator: \.isNewline).map(String.init).filter { !$0.isEmpty }
    }

    /// A linha de erro do winetricks ("------\nwarning: ..." ou "Note: command ... returned status").
    static func failureReason(_ output: String) -> String? {
        let lines = output.split(whereSeparator: \.isNewline).map(String.init)
        return lines.last { $0.hasPrefix("warning:") || $0.contains("returned status") || $0.hasPrefix("Unknown arg") }
    }

    // MARK: - Lista de verbos

    /// Os verbos do script do runtime, lidos das declarações `w_metadata`
    /// (sem executar nada, e em milissegundos).
    public static func verbs(runtime: Runtime) throws -> [WinetricksVerb] {
        parse(script: try String(contentsOf: runtime.winetricks, encoding: .utf8))
    }

    static func parse(script: String) -> [WinetricksVerb] {
        var verbs: [WinetricksVerb] = []
        var current: WinetricksVerb?
        var continues = false
        for raw in script.split(separator: "\n", omittingEmptySubsequences: false) {
            let line = raw.trimmingCharacters(in: .whitespaces)
            if line.hasPrefix("w_metadata ") {
                if let current { verbs.append(current) }
                current = nil
                let parts = line.split(separator: " ")
                if parts.count >= 3, let category = WinetricksVerb.Category(rawValue: String(parts[2])) {
                    current = WinetricksVerb(name: String(parts[1]), category: category, title: "")
                }
                continues = line.hasSuffix("\\")
                continue
            }
            guard continues, current != nil else { continue }
            continues = line.hasSuffix("\\")
            let body = continues ? String(line.dropLast()).trimmingCharacters(in: .whitespaces) : line
            guard let eq = body.firstIndex(of: "=") else { continue }
            let key = String(body[..<eq])
            var value = String(body[body.index(after: eq)...])
            if value.hasPrefix("\""), value.hasSuffix("\""), value.count >= 2 { value = String(value.dropFirst().dropLast()) }
            switch key {
            case "title": current?.title = value
            case "publisher": current?.publisher = value
            case "year": current?.year = value
            case "media": current?.media = value
            default: break
            }
            if !continues, let done = current { verbs.append(done); current = nil }
        }
        if let current { verbs.append(current) }
        return verbs
    }
}

public enum WinetricksError: LocalizedError, Equatable {
    case invalidVerb(String)
    case failed(verbs: [String], status: Int32, log: String, reason: String?)

    public var errorDescription: String? {
        switch self {
        case .invalidVerb(let verb):
            return "“\(verb)” não é um verbo do winetricks."
        case .failed(let verbs, let status, let log, let reason):
            var text = "O winetricks não conseguiu instalar \(verbs.joined(separator: ", ")) (código \(status))."
            if let reason { text += " \(reason)" }
            return text + " Detalhes em \(log)."
        }
    }
}
