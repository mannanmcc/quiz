import AppKit
import CoreGraphics
import Foundation

let args = CommandLine.arguments
guard args.count == 3 else {
    fputs("Usage: render_pdf_pages <input.pdf> <output-dir>\n", stderr)
    exit(1)
}

let inputURL = URL(fileURLWithPath: args[1])
let outputURL = URL(fileURLWithPath: args[2], isDirectory: true)

try FileManager.default.createDirectory(at: outputURL, withIntermediateDirectories: true)

guard let pdf = CGPDFDocument(inputURL as CFURL) else {
    fputs("Unable to open PDF\n", stderr)
    exit(1)
}

for pageNumber in 1...pdf.numberOfPages {
    guard let page = pdf.page(at: pageNumber) else {
        continue
    }

    let box = page.getBoxRect(.cropBox)
    let scale: CGFloat = 3.0
    let width = Int(box.width * scale)
    let height = Int(box.height * scale)

    let image = NSImage(size: NSSize(width: width, height: height))
    image.lockFocus()
    NSColor.white.setFill()
    NSRect(x: 0, y: 0, width: width, height: height).fill()

    guard let context = NSGraphicsContext.current?.cgContext else {
        image.unlockFocus()
        continue
    }

    context.saveGState()
    context.scaleBy(x: scale, y: scale)
    context.translateBy(x: -box.origin.x, y: box.height + box.origin.y)
    context.scaleBy(x: 1, y: -1)
    context.drawPDFPage(page)
    context.restoreGState()
    image.unlockFocus()

    guard
        let tiff = image.tiffRepresentation,
        let bitmap = NSBitmapImageRep(data: tiff),
        let png = bitmap.representation(using: .png, properties: [:])
    else {
        continue
    }

    let outputPath = outputURL.appendingPathComponent(String(format: "page-%02d.png", pageNumber))
    try png.write(to: outputPath)
}

print("Rendered \(pdf.numberOfPages) pages")
