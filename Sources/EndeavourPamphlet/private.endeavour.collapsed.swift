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
let endeavour={send:function(e,n){send(e,(function(e){let o=e.getResponseHeader("Service-Response");if(null!=o){let c=JSON.parse(o);n(e,c)}else n(e,void 0)}))},new:function(e){endeavour.send({service:"EndeavourService",command:"new"},e)},join:function(e,n){endeavour.send({service:"EndeavourService",command:"join",documentUUID:e},n)},close:function(e,n){endeavour.send({service:"EndeavourService",command:"close",documentUUID:e},n)}};

"""###
private let compressedEndeavourJs = Data(base64Encoded:"H4sIAAAAAAACA62PwWrDMBBE7/0KRycJVNOzjW8NpD000JAPMPIkqMi7wbKdQ9C/d+02TQg5hd6GWXbeTECfgRrUIw9ddYqii91ArvdMGpbMbInSF9ecgnxxhXyP/hPxwBSxQt2g02qDbvQOz2dfmdLvNA0hLCr++XTV+2b9kR/qLkKzKSeQMwkhIpv0yL7JXkwyJlnCsbgm/3XN517SbsYVank+/BZQ1nHb1jJHSYZKFpL2xZ5u5j0SOMUo27AbWlC/3b69FpCqAnCBI/6BMOfcRaTy6RudiOEDtAEAAA==")!

