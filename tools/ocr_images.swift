import Foundation
import Vision
import AppKit

let args = CommandLine.arguments
guard args.count >= 2 else {
    fputs("Usage: ocr_images <image> [image...]\n", stderr)
    exit(1)
}

for path in args.dropFirst() {
    let url = URL(fileURLWithPath: path)
    guard let image = NSImage(contentsOf: url),
          let tiff = image.tiffRepresentation,
          let bitmap = NSBitmapImageRep(data: tiff),
          let cgImage = bitmap.cgImage else {
        print("=== \(url.lastPathComponent) ===")
        print("Unable to read image")
        continue
    }

    let request = VNRecognizeTextRequest()
    request.recognitionLevel = .accurate
    request.usesLanguageCorrection = true
    request.recognitionLanguages = ["en-US"]

    let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
    try handler.perform([request])

    let observations = (request.results ?? []).sorted {
        let ay = $0.boundingBox.midY
        let by = $1.boundingBox.midY
        if abs(ay - by) > 0.01 {
            return ay > by
        }
        return $0.boundingBox.minX < $1.boundingBox.minX
    }

    print("=== \(url.lastPathComponent) ===")
    for observation in observations {
        if let text = observation.topCandidates(1).first?.string {
            print(text)
        }
    }
}
