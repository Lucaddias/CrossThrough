import Foundation

/// De onde tirar o ícone: um .exe/.dll (com o índice do Windows) ou um .ico.
public struct IconReference: Sendable, Hashable {
    public var file: URL
    /// >= 0: posição entre os grupos de ícones; < 0: o recurso com ID -index.
    public var index: Int32

    public init(file: URL, index: Int32 = 0) {
        self.file = file
        self.index = index
    }
}

/// Um programa instalado na bottle, achado por um atalho do Menu Iniciar ou da Área de Trabalho.
public struct Program: Sendable, Hashable, Identifiable {
    public enum Source: String, Sendable { case startMenu, desktop }

    public var name: String
    public var shortcut: URL
    public var source: Source
    /// Subpastas do Menu Iniciar até o atalho (ex.: ["Notepad++"]).
    public var folder: [String]
    /// Caminho Unix do alvo, quando o atalho tem um que existe.
    public var target: URL?
    public var arguments: String?
    public var workingDirectory: URL?
    public var icon: IconReference?

    public var id: String { shortcut.path }
}

public enum ProgramScanner {
    /// Os programas da bottle, em ordem de nome, sem desinstaladores, sem
    /// atalhos para documentos e sem repetir o mesmo alvo.
    public static func scan(_ bottle: Bottle) -> [Program] {
        var programs: [Program] = []
        var seen = Set<String>()
        for (root, source, recursive) in roots(bottle) {
            for lnk in shortcuts(in: root, recursive: recursive) {
                guard let program = program(from: lnk, root: root, source: source, bottle: bottle),
                      shouldList(program) else { continue }
                // Mesmo alvo e argumentos = mesmo programa (Menu Iniciar ganha da Área de Trabalho).
                let key = program.target.map { "\($0.path.lowercased())|\(program.arguments ?? "")" }
                    ?? "name|\(program.name.lowercased())"
                if seen.insert(key).inserted { programs.append(program) }
            }
        }
        return programs.sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
    }

    /// Onde o Windows guarda atalhos: Menu Iniciar de todos e do usuário,
    /// depois as Áreas de Trabalho (sem subpastas).
    static func roots(_ bottle: Bottle) -> [(URL, Program.Source, Bool)] {
        let c = bottle.driveC
        let startMenu = "Microsoft/Windows/Start Menu/Programs"
        var list: [(URL, Program.Source, Bool)] = [
            (c.appending(path: "ProgramData/\(startMenu)"), .startMenu, true),
        ]
        let users = ((try? FileManager.default.contentsOfDirectory(atPath: c.appending(path: "users").path)) ?? [])
            .filter { !$0.hasPrefix(".") }.sorted()
        for user in users where user != "Public" {
            list.append((c.appending(path: "users/\(user)/AppData/Roaming/\(startMenu)"), .startMenu, true))
        }
        for user in users {
            list.append((c.appending(path: "users/\(user)/Desktop"), .desktop, false))
        }
        return list
    }

    /// Os .lnk de um diretório. Links simbólicos ficam de fora: a Área de
    /// Trabalho da bottle tem um ("My Mac Desktop") para a do Mac.
    static func shortcuts(in root: URL, recursive: Bool) -> [URL] {
        let fm = FileManager.default
        let keys: [URLResourceKey] = [.isSymbolicLinkKey, .isRegularFileKey]
        var found: [URL] = []
        func consider(_ url: URL) {
            guard url.pathExtension.lowercased() == "lnk",
                  let values = try? url.resourceValues(forKeys: Set(keys)),
                  values.isSymbolicLink != true, values.isRegularFile == true else { return }
            found.append(url)
        }
        if recursive {
            guard let e = fm.enumerator(at: root, includingPropertiesForKeys: keys,
                                        options: [.skipsHiddenFiles]) else { return [] }
            for case let url as URL in e {
                if (try? url.resourceValues(forKeys: [.isSymbolicLinkKey]).isSymbolicLink) == true {
                    e.skipDescendants()
                    continue
                }
                consider(url)
            }
        } else {
            for url in (try? fm.contentsOfDirectory(at: root, includingPropertiesForKeys: keys,
                                                    options: [.skipsHiddenFiles])) ?? [] {
                consider(url)
            }
        }
        return found.sorted { $0.path < $1.path }
    }

    static func program(from lnk: URL, root: URL, source: Program.Source, bottle: Bottle) -> Program? {
        guard let link = try? ShellLink(contentsOf: lnk) else { return nil }
        let name = lnk.deletingPathExtension().lastPathComponent
        let relative = lnk.deletingLastPathComponent().standardizedFileURL.path
            .dropFirst(root.standardizedFileURL.path.count)
        let folder = relative.split(separator: "/").map(String.init)

        var target = link.targetCandidates.lazy.compactMap { bottle.existingUnixPath(forWindowsPath: $0) }.first
        if target == nil, let rel = link.relativePath {
            // Caminho relativo ao próprio .lnk.
            let candidate = rel.replacingOccurrences(of: "\\", with: "/")
            let url = lnk.deletingLastPathComponent().appending(path: candidate).standardizedFileURL
            if FileManager.default.fileExists(atPath: url.path) { target = url }
        }
        // Um atalho sem alvo só vale se for do Windows Installer (o msi resolve ao abrir).
        if target == nil && !link.isAdvertised { return nil }

        let workingDirectory = link.workingDirectory.flatMap {
            $0.isEmpty ? nil : bottle.existingUnixPath(forWindowsPath: $0)
        }
        var icon: IconReference?
        if let location = link.iconLocation, !location.isEmpty,
           let file = bottle.existingUnixPath(forWindowsPath: location) {
            icon = IconReference(file: file, index: link.iconIndex)
        } else if let target {
            icon = IconReference(file: target, index: 0)
        }
        return Program(name: name, shortcut: lnk, source: source, folder: folder, target: target,
                       arguments: link.arguments.flatMap { $0.isEmpty ? nil : $0 },
                       workingDirectory: workingDirectory, icon: icon)
    }

    private static let documentExtensions: Set<String> = [
        "txt", "pdf", "chm", "hlp", "htm", "html", "url", "rtf", "doc", "docx", "ico",
        "log", "ini", "xml", "md", "nfo", "wri",
    ]
    private static let uninstallWords = ["uninstall", "desinstal", "deinstal", "uninst"]

    static func shouldList(_ program: Program) -> Bool {
        let name = program.name.lowercased()
        if uninstallWords.contains(where: name.contains) { return false }
        guard let target = program.target else { return true }
        let file = target.lastPathComponent.lowercased()
        if file.range(of: #"^(unins\d*|uninst.*|uninstall.*)\.exe$"#, options: .regularExpression) != nil {
            return false
        }
        var isDirectory: ObjCBool = false
        if FileManager.default.fileExists(atPath: target.path, isDirectory: &isDirectory), isDirectory.boolValue {
            return false // atalho para uma pasta
        }
        return !documentExtensions.contains(target.pathExtension.lowercased())
    }
}
