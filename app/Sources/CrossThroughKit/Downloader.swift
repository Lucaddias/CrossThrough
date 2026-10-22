import CryptoKit
import Foundation

public enum DownloadError: LocalizedError, Equatable {
    case http(status: Int, url: String)
    case checksumMismatch(file: String, expected: String, actual: String)

    public var errorDescription: String? {
        switch self {
        case .http(let status, let url):
            return "O servidor respondeu \(status) para \(url)."
        case .checksumMismatch(let file, let expected, let actual):
            return "O arquivo \(file) não é o esperado (SHA-256 \(actual), esperado \(expected)). Ele foi apagado; tente de novo."
        }
    }
}

/// Downloads com progresso, cache e conferência de SHA-256.
///
/// O cache fica em ~/Library/Caches/CrossThrough/Downloads/<pasta>/<arquivo>:
/// um arquivo já baixado e com o SHA-256 certo não é baixado de novo.
public enum Downloader {
    public static var cacheDirectory: URL {
        FileManager.default.homeDirectoryForCurrentUser.appending(path: "Library/Caches/CrossThrough/Downloads")
    }

    /// Bytes recebidos e total (se o servidor informar).
    public typealias Progress = @Sendable (_ received: Int64, _ total: Int64?) -> Void

    /// Baixa `download` para o cache (ou reaproveita) e devolve o arquivo.
    public static func fetch(_ download: Recipe.Download, folder: String,
                             cacheDirectory: URL = Downloader.cacheDirectory,
                             progress: Progress? = nil) async throws -> URL {
        let fm = FileManager.default
        let dir = cacheDirectory.appending(path: folder)
        try fm.createDirectory(at: dir, withIntermediateDirectories: true)
        let file = dir.appending(path: download.resolvedFileName)
        if fm.fileExists(atPath: file.path) {
            if let expected = download.sha256 {
                if try sha256(of: file) == expected { return file }
                try fm.removeItem(at: file)
            } else {
                // Sem SHA-256 fixado, o arquivo pode ter mudado no servidor: baixa de novo.
                try fm.removeItem(at: file)
            }
        }
        let temp = try await transfer(download.url, into: dir, progress: progress)
        if let expected = download.sha256 {
            let actual = try sha256(of: temp)
            guard actual == expected else {
                try? fm.removeItem(at: temp)
                throw DownloadError.checksumMismatch(file: download.resolvedFileName, expected: expected, actual: actual)
            }
        }
        _ = try? fm.removeItem(at: file)
        try fm.moveItem(at: temp, to: file)
        return file
    }

    public static func sha256(of file: URL) throws -> String {
        let handle = try FileHandle(forReadingFrom: file)
        defer { try? handle.close() }
        var hasher = SHA256()
        while let chunk = try handle.read(upToCount: 1 << 20), !chunk.isEmpty {
            hasher.update(data: chunk)
        }
        return hasher.finalize().map { String(format: "%02x", $0) }.joined()
    }

    /// Um download para um temporário em `dir` (mesmo volume do destino, então
    /// o move final é atômico). Cancelar a Task cancela a transferência.
    static func transfer(_ url: URL, into dir: URL, progress: Progress?) async throws -> URL {
        let delegate = TransferDelegate(directory: dir, progress: progress)
        let session = URLSession(configuration: .ephemeral, delegate: delegate, delegateQueue: nil)
        defer { session.finishTasksAndInvalidate() }
        var request = URLRequest(url: url)
        request.setValue("CrossThrough", forHTTPHeaderField: "User-Agent")
        let task = session.downloadTask(with: request)
        return try await withTaskCancellationHandler {
            try await withCheckedThrowingContinuation { continuation in
                delegate.start(continuation)
                task.resume()
            }
        } onCancel: {
            task.cancel()
        }
    }
}

private final class TransferDelegate: NSObject, URLSessionDownloadDelegate, @unchecked Sendable {
    private let directory: URL
    private let progress: Downloader.Progress?
    private let lock = NSLock()
    private var continuation: CheckedContinuation<URL, Error>?
    private var result: Result<URL, Error>?

    init(directory: URL, progress: Downloader.Progress?) {
        self.directory = directory
        self.progress = progress
    }

    func start(_ continuation: CheckedContinuation<URL, Error>) {
        lock.lock(); defer { lock.unlock() }
        self.continuation = continuation
    }

    private func finish(_ result: Result<URL, Error>) {
        lock.lock()
        let continuation = self.continuation
        self.continuation = nil
        lock.unlock()
        continuation?.resume(with: result)
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        progress?(totalBytesWritten, totalBytesExpectedToWrite > 0 ? totalBytesExpectedToWrite : nil)
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        // O arquivo em `location` some quando este método retorna: move já.
        if let http = downloadTask.response as? HTTPURLResponse, !(200..<300).contains(http.statusCode) {
            lock.lock(); result = .failure(DownloadError.http(status: http.statusCode,
                                                               url: downloadTask.originalRequest?.url?.absoluteString ?? "?"))
            lock.unlock()
            return
        }
        let temp = directory.appending(path: ".download-\(UUID().uuidString)")
        do {
            try FileManager.default.moveItem(at: location, to: temp)
            lock.lock(); result = .success(temp); lock.unlock()
        } catch {
            lock.lock(); result = .failure(error); lock.unlock()
        }
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        lock.lock()
        let stored = result
        lock.unlock()
        if let error {
            if case .success(let url)? = stored { try? FileManager.default.removeItem(at: url) }
            finish(.failure(error))
        } else {
            finish(stored ?? .failure(URLError(.unknown)))
        }
    }
}
