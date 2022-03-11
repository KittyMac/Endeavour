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
<link rel="preload" href="public/endeavour/robotomono_400.woff" as="font" type="font/woff2" crossorigin> <style>
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
private let compressedEditorFontsHtml = Data(base64Encoded:"H4sIAAAAAAACA91SPU/DMBDd+ytOWdKKhiRuU0RoK/qBNxYkZuQkTmvh+iI7oaoQ/x0nTiUqMTB0wsM9v3und+eT51Kod9BcLrzKRmSFB3vNS0ubTIo85Krg7AMbHWrMsMYDKnybRtHtEcvSA2YWXomq9qA+Vdzdw1YiHuQajUEtdkItYW7qk+TLAdjz2FYFJcs5fHYJgD5zEPKUgv/StYJn28t/+FnRmaSgUB+YvFCOXOz2dQp2tIt8IUwlmTU1R1adFaPzFBoth3955Mga2Xb10G+ZPzqbNErkWPBAM7WzM73eRPYEUUTpuCXxJHaYkMCGSUfIeh3YsHFkM3O4XfXY5UlrQ6IZdeRu6nDlxJgQh/dxj50zsUKPSYv0yY1BKd26gb/G19l9hrL4dfPJ1Taf/LPND+ah+/3fBcaYqm4DAAA=")!

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
let endeavour={send:function(e,n){send(e,(function(e){let o=e.getResponseHeader("Service-Response");if(null!=o){let d=JSON.parse(o);n(e,d)}else n(e,void 0)}))},new:function(e){endeavour.send({service:"EndeavourService",command:"new"},e)},join:function(e,n){endeavour.send({service:"EndeavourService",command:"join",documentUUID:e},n)},leave:function(e,n){endeavour.send({service:"EndeavourService",command:"leave",documentUUID:e},n)},save:function(e,n){endeavour.send({service:"EndeavourService",command:"save",documentUUID:e},n)},revert:function(e,n){endeavour.send({service:"EndeavourService",command:"revert",documentUUID:e},n)}};

"""###
private let compressedEndeavourJs = Data(base64Encoded:"H4sIAAAAAAACA62PwWrDMBBE7/0KVycJVJOzjW8tpD20kJAPMNakqMjaIMnuIejfs3aStpT0UnwbZpl5sw6pgDdoRxpCc4ysq/3gu2TJS2ivZouV/HbV0XGKGpTvSBvEA/mINVqDIMUWYbQdHq6+ULXdSz84d9/QOWmal+3ba3loQ4QkVU8gozJcRDHpkawpViorlbXHZ/WT/LW1nHfxuhlXiafr4TJA6I76vuV3BHeIrMFtH2T9r/f+UzjVCG2oG3r4tNs9P1bgqQxwHMEChLnnNiIuQ4h/AgJGhLQA4lx0E5LruxOoINPMegIAAA==")!

public extension EndeavourPamphlet.Private.Endeavour {
    static func EndeavourStyle() -> String {
    #if DEBUG
        let fileOnDiskPath = "/Volumes/Development/Development/chimerasw3/Endeavour/Resources/private/endeavour/endeavour.style"
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
        return uncompressedEndeavourStyle
    #endif
    }
    static func EndeavourStyleGzip() -> Data {
        return compressedEndeavourStyle
    }
}

private let uncompressedEndeavourStyle = ###"""

<style>
    :root {
        --end-peer0-dark: #145066;
        --end-peer1-dark: #306638;
        --end-peer2-dark: #664b1a;
        --end-peer3-dark: #665c1e;
        --end-peer4-dark: #662a22;
        --end-peer5-dark: #4e6266;
        --end-peer6-dark: #476644;
        --end-peer7-dark: #0c5c66;
        
        --end-peer0-light: #d5e7ed;
        --end-peer1-light: #d3ebd7;
        --end-peer2-light: #fff6e5;
        --end-peer3-light: #edead5;
        --end-peer4-light: #edd8d5;
        --end-peer5-light: #dce8ea;
        --end-peer6-light: #dbefda;
        --end-peer7-light: #e5fcff;
    }
    
    @media (prefers-color-scheme: dark) {
        :root {
            --end-peer0-light: #0f3c4d;
            --end-peer1-light: #244d2a;
            --end-peer2-light: #4d3813;
            --end-peer3-light: #4d4516;
            --end-peer4-light: #4d1f19;
            --end-peer5-light: #3a494d;
            --end-peer6-light: #354d33;
            --end-peer7-light: #09454d;
        
            --end-peer0-dark: #8ed5ed;
            --end-peer1-dark: #8deb9c;
            --end-peer2-dark: #ffdb99;
            --end-peer3-dark: #ede18e;
            --end-peer4-dark: #ed998e;
            --end-peer5-dark: #8dddeb;
            --end-peer6-dark: #95f090;
            --end-peer7-dark: #99f3ff;
        }
    }
</style>

"""###
private let compressedEndeavourStyle = Data(base64Encoded:"H4sIAAAAAAACA33US26DMBCA4T2nQOqmXaDa+AFOo6pXMZ5xEyUpEcmmqnL3Oi3GqJopKxafYPg9otperp9HfK3qdG2mcbzWXz/396tp8AOaM+IkGvDTYVM/SG2EtS8EkZmoBFRPkTYTa/UgPUVUISZIpIgupPVtSxGTiUbb0uPahXRpGk2RLhMRTFg/hQx03L/vrgmDwQ6BLrQYhQN0dKJsYowWDd0oGwT0YOhIxUBPG1PmCdijpzMtZsAInu60vMvEEOOvuVVLqrcTwt7Xj+cJI06XJozHcWouYYcn3NT3yE+rrfu7hVxoEVXQq9Bc7FZraD3nSnANqpeKc2rltJGWc3rlZJSOcyW+8trx31EOQJk0ITtfOQThtFk/jw05b3ePaWX/6ZgZ4OACn3FmMcLgHF9xZmlzZY98xIU5xzNTZoM0HZ9wZs5E4QRfMDMXVd7issm3avs8/yu/AWRatkg1BQAA")!

