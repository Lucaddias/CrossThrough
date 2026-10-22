// make_logo.swift — renders the CrossThrough sidebar logo.
//
// Usage: swift tools/make_logo.swift <controller image> <output dir>
// Writes CrossThroughLogo.png, CrossThroughLogo@2x.png and the -dark variants
// (418x96 points), in the style of CrossOver's welcomeCrossOverIcon: the mark
// on the left of a tilted scanline banner, "CROSS" in thin type and the second
// word in heavy expanded type, with red/blue offset fringes. The light variant
// has a black banner with yellow and white text, the dark variant a white
// banner with black text.
import AppKit
import CoreText
import Vision

let args = CommandLine.arguments
guard args.count == 3 else {
    FileHandle.standardError.write("usage: make_logo <controller image> <output dir>\n".data(using: .utf8)!)
    exit(2)
}

let pointSize = CGSize(width: 418, height: 96)
let tilt = 3.6 * Double.pi / 180

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

func bitmap(_ width: Int, _ height: Int) -> CGContext {
    CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0,
              space: CGColorSpace(name: CGColorSpace.sRGB)!,
              bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
}

// Two-tone glyph of the controller: light body white, buttons black.
func glyph(_ image: CGImage) -> CGImage {
    let context = bitmap(image.width, image.height)
    context.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
    let pixels = context.data!.bindMemory(to: UInt8.self, capacity: context.bytesPerRow * image.height)
    for y in 0..<image.height {
        for x in 0..<image.width {
            let p = pixels + y * context.bytesPerRow + x * 4
            let a = Double(p[3])
            guard a > 0 else { continue }
            let luminance = (0.299 * Double(p[0]) + 0.587 * Double(p[1]) + 0.114 * Double(p[2])) / a
            let value = UInt8(luminance > 0.45 ? a : 0)
            p[0] = value; p[1] = value; p[2] = value
        }
    }
    return context.makeImage()!
}

// The image's silhouette filled with one colour.
func tinted(_ image: CGImage, _ color: CGColor) -> CGImage {
    let context = bitmap(image.width, image.height)
    let rect = CGRect(x: 0, y: 0, width: image.width, height: image.height)
    context.setFillColor(color)
    context.fill(rect)
    context.setBlendMode(.destinationIn)
    context.draw(image, in: rect)
    return context.makeImage()!
}

func font(_ size: CGFloat, _ weight: NSFont.Weight, _ width: NSFont.Width = .standard) -> NSFont {
    NSFont.systemFont(ofSize: size, weight: weight, width: width)
}

func line(_ text: String, _ font: NSFont, _ color: CGColor, tracking: CGFloat = 0) -> CTLine {
    let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color, .kern: tracking]
    return CTLineCreateWithAttributedString(NSAttributedString(string: text, attributes: attributes))
}

struct Palette {
    let banner: CGColor
    let scanline: CGColor
    let thinWord: CGColor
    let heavyWord: CGColor
    let fringes: [(CGColor, CGPoint)]
}

let red = CGColor(srgbRed: 1, green: 0.1, blue: 0.15, alpha: 1)
let blue = CGColor(srgbRed: 0.1, green: 0.2, blue: 1, alpha: 1)
let yellow = CGColor(srgbRed: 0.98, green: 0.94, blue: 0, alpha: 1)

let light = Palette(banner: CGColor(gray: 0.03, alpha: 1), scanline: CGColor(gray: 0.17, alpha: 1),
                    thinWord: yellow, heavyWord: CGColor(gray: 1, alpha: 1),
                    fringes: [(red, CGPoint(x: -4, y: 1)), (blue, CGPoint(x: 4, y: -1))])
let dark = Palette(banner: CGColor(gray: 0.96, alpha: 1), scanline: CGColor(gray: 0.82, alpha: 1),
                   thinWord: CGColor(gray: 0, alpha: 1), heavyWord: CGColor(gray: 0, alpha: 1),
                   fringes: [(red, CGPoint(x: -4, y: 1)), (yellow, CGPoint(x: 2, y: -2)), (blue, CGPoint(x: 5, y: -1))])

let controller = liftSubject(loadImage(args[1]))
let controllerGlyph = glyph(controller)
let silhouette = tinted(controller, CGColor(gray: 0, alpha: 1))

// Lays the logo out flat at 2x on a generous canvas; the caller tilts it.
func renderFlat(_ palette: Palette, into context: CGContext) {
    let bannerHeight: CGFloat = 100
    let thin = line("CROSS", font(62, .ultraLight), palette.thinWord, tracking: 6)
    let heavyFont = font(62, .black, .expanded)
    let heavy = line("THROUGH", heavyFont, palette.heavyWord)
    let thinWidth = CTLineGetTypographicBounds(thin, nil, nil, nil)
    let heavyWidth = CTLineGetTypographicBounds(heavy, nil, nil, nil)

    let textX: CGFloat = 240
    let bannerEnd = textX + thinWidth + 4 + heavyWidth + 26
    let banner = CGMutablePath()
    // The banner starts behind the right grip so it never shows between the grips.
    banner.move(to: CGPoint(x: 205, y: bannerHeight))
    banner.addLine(to: CGPoint(x: bannerEnd, y: bannerHeight))
    banner.addLine(to: CGPoint(x: bannerEnd, y: 0))
    banner.addLine(to: CGPoint(x: 175, y: 0))
    banner.closeSubpath()

    context.saveGState()
    context.addPath(banner)
    context.clip()
    context.setFillColor(palette.banner)
    context.fill(banner.boundingBox)
    context.setFillColor(palette.scanline)
    for y in stride(from: 2.0, to: bannerHeight, by: 5) {
        context.fill(CGRect(x: 0, y: y, width: bannerEnd, height: 1.5))
    }
    context.restoreGState()

    // Mark: the controller, outlined in black, with offset colour fringes.
    let markHeight: CGFloat = 150
    let markWidth = markHeight * CGFloat(controller.width) / CGFloat(controller.height)
    let mark = CGRect(x: 0, y: bannerHeight / 2 - markHeight / 2, width: markWidth, height: markHeight)
    for (color, offset) in palette.fringes {
        context.draw(tinted(controller, color), in: mark.offsetBy(dx: offset.x * 1.5, dy: offset.y * 1.5))
    }
    for step in 0..<16 {
        let angle = Double(step) / 16 * 2 * .pi
        context.draw(silhouette, in: mark.offsetBy(dx: 5 * cos(angle), dy: 5 * sin(angle)))
    }
    context.draw(controllerGlyph, in: mark)

    let capHeight = heavyFont.capHeight
    let baseline = bannerHeight / 2 - capHeight / 2
    context.textPosition = CGPoint(x: textX, y: baseline)
    CTLineDraw(thin, context)
    let heavyX = textX + thinWidth + 4
    for (color, offset) in palette.fringes {
        context.textPosition = CGPoint(x: heavyX + offset.x, y: baseline + offset.y)
        CTLineDraw(line("THROUGH", heavyFont, color), context)
    }
    context.textPosition = CGPoint(x: heavyX, y: baseline)
    CTLineDraw(heavy, context)
}

func render(_ palette: Palette, scale: CGFloat) -> CGImage {
    // Flat layout, then tilt it on a canvas large enough for any angle.
    let flat = bitmap(1200, 300)
    flat.translateBy(x: 40, y: 100)
    renderFlat(palette, into: flat)
    let flatImage = flat.makeImage()!

    let tiltedContext = bitmap(1400, 600)
    tiltedContext.translateBy(x: 700, y: 300)
    tiltedContext.rotate(by: tilt)
    tiltedContext.draw(flatImage, in: CGRect(x: -600, y: -150, width: 1200, height: 300))
    let tilted = tiltedContext.makeImage()!

    // Crop to the drawn pixels and fit them into the logo's frame.
    let probe = bitmap(tilted.width, tilted.height)
    probe.draw(tilted, in: CGRect(x: 0, y: 0, width: tilted.width, height: tilted.height))
    let pixels = probe.data!.bindMemory(to: UInt8.self, capacity: probe.bytesPerRow * tilted.height)
    var minX = tilted.width, minY = tilted.height, maxX = 0, maxY = 0
    for y in 0..<tilted.height {
        for x in 0..<tilted.width where pixels[y * probe.bytesPerRow + x * 4 + 3] > 0 {
            minX = min(minX, x); maxX = max(maxX, x); minY = min(minY, y); maxY = max(maxY, y)
        }
    }
    let drawn = tilted.cropping(to: CGRect(x: minX, y: minY, width: maxX - minX + 1, height: maxY - minY + 1))!

    let width = Int(pointSize.width * scale), height = Int(pointSize.height * scale)
    let output = bitmap(width, height)
    output.interpolationQuality = .high
    let fit = min(CGFloat(width) / CGFloat(drawn.width), CGFloat(height) / CGFloat(drawn.height))
    let size = CGSize(width: CGFloat(drawn.width) * fit, height: CGFloat(drawn.height) * fit)
    output.draw(drawn, in: CGRect(x: (CGFloat(width) - size.width) / 2, y: (CGFloat(height) - size.height) / 2,
                                  width: size.width, height: size.height))
    return output.makeImage()!
}

func write(_ image: CGImage, _ name: String) {
    let path = (args[2] as NSString).appendingPathComponent(name)
    let destination = CGImageDestinationCreateWithURL(URL(fileURLWithPath: path) as CFURL, "public.png" as CFString, 1, nil)!
    let properties = [kCGImagePropertyDPIWidth: 72 * image.width / Int(pointSize.width),
                      kCGImagePropertyDPIHeight: 72 * image.height / Int(pointSize.height)] as CFDictionary
    CGImageDestinationAddImage(destination, image, properties)
    guard CGImageDestinationFinalize(destination) else {
        fatalError("cannot write \(path)")
    }
    print("wrote \(path)")
}

for (palette, suffix) in [(light, ""), (dark, "-dark")] {
    write(render(palette, scale: 1), "CrossThroughLogo\(suffix).png")
    write(render(palette, scale: 2), "CrossThroughLogo\(suffix)@2x.png")
}
