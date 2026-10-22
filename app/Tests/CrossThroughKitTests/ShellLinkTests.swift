import Foundation
import Testing
@testable import CrossThroughKit

@Suite("Atalhos .lnk")
struct ShellLinkTests {
    @Test("lê um atalho gravado pelo shell32 do Wine (instalador do 7-Zip)")
    func wineShortcut() throws {
        let link = try ShellLink(contentsOf: fixture("wine-7zip-file-manager.lnk"))
        // LinkInfo (ANSI) e a lista de IDs (nomes longos em Unicode) dão o mesmo caminho.
        #expect(link.targetCandidates == [#"C:\Program Files\7-Zip\7zFM.exe"#])
        #expect(link.arguments == nil)
        #expect(!link.isAdvertised)
    }

    @Test("o alvo vem da lista de IDs quando não há LinkInfo")
    func idListOnly() throws {
        var data = try Data(contentsOf: fixture("wine-7zip-file-manager.lnk"))
        // ForceNoLinkInfo (0x100): o LinkInfo continua no arquivo, mas não vale. Sobra a lista de IDs.
        data[0x15] |= 0x01
        let link = try ShellLink.parse(data)
        #expect(link.targetCandidates == [#"C:\Program Files\7-Zip\7zFM.exe"#])
    }

    @Test("o atalho de ajuda aponta para o .chm")
    func helpShortcut() throws {
        let link = try ShellLink(contentsOf: fixture("wine-7zip-help.lnk"))
        #expect(link.targetCandidates.first?.hasSuffix(#"\7-zip.chm"#) == true)
    }

    @Test("make e parse vão e voltam, com Unicode no caminho")
    func roundTrip() throws {
        let target = #"C:\Program Files\Café Ñandú\jogo.exe"#
        let data = ShellLink.make(target: target, workingDirectory: #"C:\Program Files\Café Ñandú"#,
                                  arguments: "-windowed -lang pt", iconLocation: target, iconIndex: 2,
                                  name: "Um jogo")
        let link = try ShellLink.parse(data)
        // O caminho Unicode do LinkInfo vem antes do ANSI (que perde o que não cabe em 1252).
        #expect(link.targetCandidates.first == target)
        #expect(link.workingDirectory == #"C:\Program Files\Café Ñandú"#)
        #expect(link.arguments == "-windowed -lang pt")
        #expect(link.iconLocation == target)
        #expect(link.iconIndex == 2)
        #expect(link.name == "Um jogo")
    }

    @Test("lista de IDs do Windows: bloco BEEF0004 versão 9")
    func windowsIDList() throws {
        var list = Data()
        func item(_ body: Data) { list += le16(UInt16(body.count + 2)) + body }
        // Raiz: Meu Computador.
        item(Data([0x1F, 0x50]) + Data(count: 16))
        // Volume C:\.
        item(Data([0x2F]) + Data("C:\\".utf8) + Data(count: 20))
        // Pasta "PROGRA~1" com nome longo "Program Files" no bloco de extensão v9.
        func entry(_ type: UInt8, short: String, long: String) -> Data {
            var body = Data([type, 0]) + Data(count: 4 + 4 + 2)         // tamanho, data, atributos
            body += Data(short.utf8) + Data([0])
            if body.count % 2 == 1 { body += Data([0]) }
            let extOffset = body.count + 2                               // relativo ao início do item
            var ext = le16(0) + le16(9) + le32(0xBEEF_0004) + Data(count: 8) + le16(0x2E)
            ext += le16(0) + Data(count: 16) + le16(0) + Data(count: 8)  // até o deslocamento 46
            ext += Data(long.utf16.flatMap { [UInt8($0 & 0xFF), UInt8($0 >> 8)] }) + Data([0, 0])
            ext += le16(0)
            ext.replaceSubrange(0..<2, with: le16(UInt16(ext.count)))
            return body + ext + le16(UInt16(extOffset))
        }
        item(entry(0x31, short: "PROGRA~1", long: "Program Files"))
        item(entry(0x32, short: "APP.EXE", long: "Aplicação.exe"))
        list += le16(0)
        let path = try ShellLink.parseIDList(BinaryReader(list))
        #expect(path == #"C:\Program Files\Aplicação.exe"#)
    }

    @Test("recusa o que não é atalho")
    func notALink() {
        #expect(throws: BinaryFormatError.self) { try ShellLink.parse(Data("MZ não sou um atalho".utf8)) }
        #expect(throws: BinaryFormatError.self) { try ShellLink.parse(Data()) }
    }

    @Test("um atalho truncado vira erro, não leitura fora do buffer")
    func truncated() throws {
        let data = try Data(contentsOf: fixture("wine-7zip-file-manager.lnk"))
        for length in stride(from: 0x4C, to: data.count, by: 7) {
            // Pode dar erro ou um resultado parcial; o que não pode é travar.
            _ = try? ShellLink.parse(data.prefix(length))
        }
    }
}

func le16(_ v: UInt16) -> Data { Data([UInt8(v & 0xFF), UInt8(v >> 8)]) }
func le32(_ v: UInt32) -> Data { Data((0..<4).map { UInt8((v >> (8 * $0)) & 0xFF) }) }
