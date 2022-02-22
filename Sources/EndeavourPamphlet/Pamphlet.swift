import Foundation

// swiftlint:disable all



public enum Pamphlet {
    public static func get(string member: String) -> String? {
        switch member {
        case "/public/close.svg": return Pamphlet.Public.CloseSvg()
        case "/public/codemirror/editor.bundle.js": return Pamphlet.Public.Codemirror.EditorBundleJs()
        case "/private/endeavour/endeavour.html": return Pamphlet.Private.Endeavour.EndeavourHtml()
        case "/private/endeavour/endeavour.js": return Pamphlet.Private.Endeavour.EndeavourJs()
        case "/public/manifest.json": return Pamphlet.Public.ManifestJson()
        case "/private/script.combined.js": return Pamphlet.Private.ScriptCombinedJs()
        case "/private/shell.fonts.html": return Pamphlet.Private.ShellFontsHtml()
        case "/private/shell.html": return Pamphlet.Private.ShellHtml()
        default: break
        }
        return nil
    }
    public static func get(gzip member: String) -> Data? {
        #if DEBUG
            return nil
        #else
            switch member {
        case "/public/close.svg": return Pamphlet.Public.CloseSvgGzip()
        case "/public/codemirror/editor.bundle.js": return Pamphlet.Public.Codemirror.EditorBundleJsGzip()
        case "/private/endeavour/endeavour.html": return Pamphlet.Private.Endeavour.EndeavourHtmlGzip()
        case "/private/endeavour/endeavour.js": return Pamphlet.Private.Endeavour.EndeavourJsGzip()
        case "/public/manifest.json": return Pamphlet.Public.ManifestJsonGzip()
        case "/private/script.combined.js": return Pamphlet.Private.ScriptCombinedJsGzip()
        case "/private/shell.fonts.html": return Pamphlet.Private.ShellFontsHtmlGzip()
        case "/private/shell.html": return Pamphlet.Private.ShellHtmlGzip()
            default: break
            }
            return nil
        #endif
    }
    public static func get(data member: String) -> Data? {
        switch member {
        case "/public/icon192.png": return Pamphlet.Public.Icon192Png()
        case "/public/icon512.png": return Pamphlet.Public.Icon512Png()
        case "/public/fonts/lato.woff2": return Pamphlet.Public.Fonts.LatoWoff2()
        case "/public/fonts/roboto.woff2": return Pamphlet.Public.Fonts.RobotoWoff2()
        case "/public/fonts/robotomono.woff": return Pamphlet.Public.Fonts.RobotomonoWoff()
        default: break
        }
        return nil
    }
}
public extension Pamphlet { enum Public { } }
public extension Pamphlet.Public { enum Codemirror { } }
public extension Pamphlet.Private { enum Endeavour { } }
public extension Pamphlet { enum Private { } }
public extension Pamphlet.Public { enum Fonts { } }
