import Foundation

// swiftlint:disable all

public extension Pamphlet.Private.Endeavour {
    static func EndeavourHtml() -> String {
    #if DEBUG
        let fileOnDiskPath = "/Volumes/Development/Development/chimerasw3/Endeavour/Resources/private/endeavour/endeavour.html"
        if let contents = try? String(contentsOf:URL(fileURLWithPath: fileOnDiskPath)) {
            if contents.hasPrefix("#define PAMPHLET_PREPROCESSOR") {
                do {
                    let task = Process()
                    task.executableURL = URL(fileURLWithPath: "/usr/local/bin/pamphlet")
                    task.arguments = ["preprocess", fileOnDiskPath]
                    let outputPipe = Pipe()
                    task.standardOutput = outputPipe
                    try task.run()
                    let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
                    let output = String(decoding: outputData, as: UTF8.self)
                    return output
                } catch {
                    return "Failed to use /usr/local/bin/pamphlet to preprocess the requested file"
                }
            }
            return contents
        }
        return String()
    #else
        return uncompressedEndeavourHtml
    #endif
    }
    static func EndeavourHtmlGzip() -> Data {
        return compressedEndeavourHtml
    }
}

private let uncompressedEndeavourHtml = ###"""

"""###
private let compressedEndeavourHtml = Data(base64Encoded:"H4sIAAAAAAACAwMAAAAAAAAAAAA=")!

public extension Pamphlet.Private.Endeavour {
    static func EndeavourJs() -> String {
    #if DEBUG
        let fileOnDiskPath = "/Volumes/Development/Development/chimerasw3/Endeavour/Resources/private/endeavour/endeavour.js"
        if let contents = try? String(contentsOf:URL(fileURLWithPath: fileOnDiskPath)) {
            if contents.hasPrefix("#define PAMPHLET_PREPROCESSOR") {
                do {
                    let task = Process()
                    task.executableURL = URL(fileURLWithPath: "/usr/local/bin/pamphlet")
                    task.arguments = ["preprocess", fileOnDiskPath]
                    let outputPipe = Pipe()
                    task.standardOutput = outputPipe
                    try task.run()
                    let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
                    let output = String(decoding: outputData, as: UTF8.self)
                    return output
                } catch {
                    return "Failed to use /usr/local/bin/pamphlet to preprocess the requested file"
                }
            }
            return contents
        }
        return String()
    #else
        return uncompressedEndeavourJs
    #endif
    }
    static func EndeavourJsGzip() -> Data {
        return compressedEndeavourJs
    }
}

private let uncompressedEndeavourJs = ###"""
let endeavour={send:function(e,n){send(e,(function(e){let o=e.getResponseHeader("Service-Response");if(null!=o){let e=JSON.parse(o);n(e)}else n(void 0)}))},new:function(e){endeavour.send({service:"EndeavourService",command:"new"},e)},join:function(e,n){endeavour.send({service:"EndeavourService",command:"join",documentUUID:e},n)},close:function(e,n){endeavour.send({service:"EndeavourService",command:"close",documentUUID:e},n)}};

"""###
private let compressedEndeavourJs = Data(base64Encoded:"H4sIAAAAAAACA62PwWrCQBCG732KuKddWIPnhNwUtIcWFB8gbH7LymZGskl6kH13x1irlJ5Kb8M/zPf9E9BnoAb1yENXnaPMxWEg13smDUtmimTSj9Scg1xxhfwD/RbxxBSxRt2g02qHbvQO83uuTOkPmoYQZhXfLlG97t7f8lPdRWg25RWZECIy0iP7JluYZEyyhM/i2frdM586SbNJVajVffElV9Zx29byihKGSlb49siefrz2F+AVo2zDbmhB/X6/WRaQqiJwgSP+wTBxflWk8uUCRN3P/7ABAAA=")!

