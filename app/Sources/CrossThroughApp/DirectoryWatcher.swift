import AppKit
import CoreServices
import CrossThroughKit

/// Observa diretórios (com subpastas) pelo FSEvents e entrega, na fila
/// principal, os diretórios que mudaram. Os eventos de um segundo chegam juntos.
final class DirectoryWatcher: @unchecked Sendable {
    private var stream: FSEventStreamRef?
    private let handler: @Sendable ([String]) -> Void

    init?(paths: [URL], latency: TimeInterval = 1, handler: @escaping @Sendable ([String]) -> Void) {
        self.handler = handler
        var context = FSEventStreamContext(version: 0, info: Unmanaged.passUnretained(self).toOpaque(),
                                           retain: nil, release: nil, copyDescription: nil)
        let callback: FSEventStreamCallback = { _, info, _, paths, _, _ in
            guard let info else { return }
            let watcher = Unmanaged<DirectoryWatcher>.fromOpaque(info).takeUnretainedValue()
            // Com kFSEventStreamCreateFlagUseCFTypes, `paths` é um CFArray de CFString.
            let list = Unmanaged<CFArray>.fromOpaque(paths).takeUnretainedValue() as? [String] ?? []
            watcher.handler(list)
        }
        let flags = FSEventStreamCreateFlags(kFSEventStreamCreateFlagUseCFTypes | kFSEventStreamCreateFlagNoDefer)
        guard let stream = FSEventStreamCreate(nil, callback, &context, paths.map(\.path) as CFArray,
                                               FSEventStreamEventId(kFSEventStreamEventIdSinceNow), latency, flags)
        else { return nil }
        self.stream = stream
        FSEventStreamSetDispatchQueue(stream, .main)
        FSEventStreamStart(stream)
    }

    deinit {
        guard let stream else { return }
        FSEventStreamStop(stream)
        FSEventStreamInvalidate(stream)
        FSEventStreamRelease(stream)
    }
}

/// Ícones dos programas em memória (o PNG fica no cache em disco do Kit).
@MainActor
final class IconStore {
    static let shared = IconStore()
    private var images: [IconReference: NSImage] = [:]
    private var missing: Set<IconReference> = []

    func image(for reference: IconReference?) async -> NSImage? {
        guard let reference else { return nil }
        if let image = images[reference] { return image }
        if missing.contains(reference) { return nil }
        let data = await Task.detached(priority: .utility) { IconCache.png(for: reference, maxPixelSize: 256) }.value
        guard let data, let image = NSImage(data: data) else {
            missing.insert(reference)
            return nil
        }
        images[reference] = image
        return image
    }
}
