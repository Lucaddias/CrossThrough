// make-icon.swift — desenha o ícone do CrossThrough.
//
// Uso: swift scripts/make-icon.swift <imagem do controle> <saída 1024px .png>
//
// O controle é recortado do fundo pelo Vision e centralizado, com um brilho
// azul fraco, num corpo preto com a forma de ícone do macOS 26: o retângulo de
// 824 pt na grade de 1024 pt, com cantos contínuos de 214 pt (a curva do
// RoundedRectangle(style: .continuous) do SwiftUI; com esse raio a borda bate
// com a do sistema dentro do antialiasing). Nada é desenhado fora da forma,
// nem sombra: o macOS 26 emoldura numa placa cinza os ícones cujo alfa foge
// dela, e ele mesmo põe a sombra.
import AppKit
import CoreImage
import SwiftUI
import Vision

let args = CommandLine.arguments
guard args.count == 3 else {
    FileHandle.standardError.write(Data("uso: make-icon <imagem do controle> <saída.png>\n".utf8))
    exit(2)
}

func loadImage(_ path: String) -> CGImage {
    guard let source = CGImageSourceCreateWithURL(URL(fileURLWithPath: path) as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        fatalError("não deu para ler \(path)")
    }
    return image
}

func liftSubject(_ image: CGImage) -> CGImage {
    let request = VNGenerateForegroundInstanceMaskRequest()
    let handler = VNImageRequestHandler(cgImage: image)
    try! handler.perform([request])
    guard let observation = request.results?.first else { fatalError("o Vision não achou o controle na imagem") }
    let buffer = try! observation.generateMaskedImage(ofInstances: observation.allInstances, from: handler,
                                                      croppedToInstancesExtent: true)
    let ciImage = CIImage(cvPixelBuffer: buffer)
    return CIContext().createCGImage(ciImage, from: ciImage.extent)!
}

let canvas = 1024
let body = CGRect(x: 100, y: 100, width: 824, height: 824)
let shape = RoundedRectangle(cornerRadius: 214, style: .continuous).path(in: body).cgPath
let controller = liftSubject(loadImage(args[1]))
let context = CGContext(data: nil, width: canvas, height: canvas, bitsPerComponent: 8, bytesPerRow: 0,
                        space: CGColorSpace(name: CGColorSpace.sRGB)!,
                        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!

context.addPath(shape)
context.clip()
context.setFillColor(CGColor(gray: 0, alpha: 1))
context.fill(body)

let artWidth = body.width * 0.80
let artHeight = artWidth * CGFloat(controller.height) / CGFloat(controller.width)
let art = CGRect(x: body.midX - artWidth / 2, y: body.midY - artHeight / 2, width: artWidth, height: artHeight)
context.setShadow(offset: .zero, blur: 60, color: CGColor(srgbRed: 0.25, green: 0.4, blue: 1.0, alpha: 0.55))
context.draw(controller, in: art)

let output = context.makeImage()!
let destination = CGImageDestinationCreateWithURL(URL(fileURLWithPath: args[2]) as CFURL, "public.png" as CFString, 1, nil)!
CGImageDestinationAddImage(destination, output, nil)
guard CGImageDestinationFinalize(destination) else { fatalError("não deu para gravar \(args[2])") }
print("gravado \(args[2]) (controle \(controller.width)x\(controller.height))")
