// make_icon.swift — renders the CrossThrough app icon.
//
// Usage: swift tools/make_icon.swift <controller image> <icon mask> <output 1024px png>
// Lifts the controller off its background with Vision and centres it, with a
// faint blue glow, on a black body cut out by the icon mask (Apple's 824pt
// rounded rect on the 1024pt grid; CrossOver ships it as
// app-icon-roundrect-mask.png). macOS 26 and later frame legacy icons whose
// alpha strays from that shape in a gray plate, so nothing is drawn outside
// it: no baked drop shadow, the system adds its own.
import AppKit
import CoreImage
import Vision

let args = CommandLine.arguments
guard args.count == 4 else {
    FileHandle.standardError.write("usage: make_icon <controller image> <icon mask> <output png>\n".data(using: .utf8)!)
    exit(2)
}

func loadImage(_ path: String) -> CGImage {
    guard let source = CGImageSourceCreateWithURL(URL(fileURLWithPath: path) as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        fatalError("cannot read \(path)")
    }
    return image
}

func liftSubject(_ image: CGImage) -> CGImage {
    let request = VNGenerateForegroundInstanceMaskRequest()
    let handler = VNImageRequestHandler(cgImage: image)
    try! handler.perform([request])
    guard let observation = request.results?.first else {
        fatalError("Vision found no foreground subject")
    }
    let buffer = try! observation.generateMaskedImage(ofInstances: observation.allInstances,
                                                      from: handler,
                                                      croppedToInstancesExtent: true)
    let ciImage = CIImage(cvPixelBuffer: buffer)
    return CIContext().createCGImage(ciImage, from: ciImage.extent)!
}

let canvas = 1024
let controller = liftSubject(loadImage(args[1]))
let mask = loadImage(args[2])
let context = CGContext(data: nil, width: canvas, height: canvas, bitsPerComponent: 8, bytesPerRow: 0,
                        space: CGColorSpace(name: CGColorSpace.sRGB)!,
                        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
let full = CGRect(x: 0, y: 0, width: canvas, height: canvas)
let body = CGRect(x: 100, y: 100, width: 824, height: 824)

context.setFillColor(CGColor(gray: 0, alpha: 1))
context.fill(body)

let artWidth = body.width * 0.80
let artHeight = artWidth * CGFloat(controller.height) / CGFloat(controller.width)
let art = CGRect(x: body.midX - artWidth / 2, y: body.midY - artHeight / 2, width: artWidth, height: artHeight)
context.saveGState()
context.setShadow(offset: .zero, blur: 60, color: CGColor(srgbRed: 0.25, green: 0.4, blue: 1.0, alpha: 0.55))
context.draw(controller, in: art)
context.restoreGState()

// Keep only what lies inside the mask.
context.setBlendMode(.destinationIn)
context.draw(mask, in: full)

let output = context.makeImage()!
let destination = CGImageDestinationCreateWithURL(URL(fileURLWithPath: args[3]) as CFURL, "public.png" as CFString, 1, nil)!
CGImageDestinationAddImage(destination, output, nil)
guard CGImageDestinationFinalize(destination) else {
    fatalError("cannot write \(args[3])")
}
print("wrote \(args[3]) (controller \(controller.width)x\(controller.height))")
