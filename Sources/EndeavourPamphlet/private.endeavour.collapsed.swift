import Foundation

// swiftlint:disable all

public extension EndeavourPamphlet.Private.Endeavour {
    static func EditorFontsHtml() -> String {
    #if DEBUG
        let fileOnDiskPath = "/Volumes/Development/Development/chimerasw3/Endeavour/Resources/private/endeavour/editor.fonts.html"
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
        return uncompressedEditorFontsHtml
    #endif
    }
    static func EditorFontsHtmlGzip() -> Data {
        return compressedEditorFontsHtml
    }
}

private let uncompressedEditorFontsHtml = ###"""
<link rel="preload" href="public/fonts/robotomono.woff" as="font" type="font/woff2" crossorigin> <style>
    @font-face {
      font-family: 'Roboto Mono';
      font-style: normal;
      font-weight: 400;
      font-display: swap;
      src: url(public/endeavour/robotomono_400.woff) format('woff');
      unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
    },
    @font-face {
      font-family: 'Roboto Mono';
      font-style: bold;
      font-weight: 500;
      font-display: swap;
      src: url(public/endeavour/robotomono_500.woff) format('woff');
      unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
    }
</style>
"""###
private let compressedEditorFontsHtml = Data(base64Encoded:"H4sIAAAAAAACA91Sy27CMBC88xWrXAIqaRJDqJoCKo/61kulnisnccCqsSM7KUJV/71+BAmkHjnVhx3PjjX7kOeciU9QlC+CxkRJqgD2itaGdgVnZVxL0epYyUK28iCFvD/Kug6A6EVgpQDaU0P9PbYSCqBUUmup2I6JJcx1e+J0OQBznu2rqCYlhW+XAOgzB8ZPOYRvrgy8mjrh0+ULZ5KDkOpA+JVypGy3b3OYJslVvmK64cSY6iNpzopWZQ6d4sN+OCoqSr5kpy4G/DBObsiRMTLl2mFoWTg6m3SClbKikSJiZ3p6v0vMiZIE47El6ST1mKHIhIkjaL2OTNh4spl53K56dHlkbVAyw548TD2uvJgi5PEx7dE5IyP0mFnEL74NjPHWN/wzvs3uC8mrPzef3Wzz2T/b/GAe+9//C25eOHpmAwAA")!

public extension EndeavourPamphlet.Private.Endeavour {
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

public extension EndeavourPamphlet.Private.Endeavour {
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

