import Foundation

// swiftlint:disable all



public enum EndeavourPamphlet {
    public static func get(string member: String) -> String? {
        switch member {
        case "/public/close.svg": return EndeavourPamphlet.Public.CloseSvg()
        case "/public/endeavour/editor.bundle.js": return EndeavourPamphlet.Public.Endeavour.EditorBundleJs()
        case "/private/endeavour/editor.fonts.html": return EndeavourPamphlet.Private.Endeavour.EditorFontsHtml()
        case "/private/endeavour/endeavour.html": return EndeavourPamphlet.Private.Endeavour.EndeavourHtml()
        case "/private/endeavour/endeavour.js": return EndeavourPamphlet.Private.Endeavour.EndeavourJs()
        case "/public/manifest.json": return EndeavourPamphlet.Public.ManifestJson()
        case "/private/script.combined.js": return EndeavourPamphlet.Private.ScriptCombinedJs()
        case "/private/shell.fonts.html": return EndeavourPamphlet.Private.ShellFontsHtml()
        case "/private/shell.html": return EndeavourPamphlet.Private.ShellHtml()
        default: break
        }
        return nil
    }
    public static func get(gzip member: String) -> Data? {
        #if DEBUG
            return nil
        #else
            switch member {
        case "/public/close.svg": return EndeavourPamphlet.Public.CloseSvgGzip()
        case "/public/endeavour/editor.bundle.js": return EndeavourPamphlet.Public.Endeavour.EditorBundleJsGzip()
        case "/private/endeavour/editor.fonts.html": return EndeavourPamphlet.Private.Endeavour.EditorFontsHtmlGzip()
        case "/private/endeavour/endeavour.html": return EndeavourPamphlet.Private.Endeavour.EndeavourHtmlGzip()
        case "/private/endeavour/endeavour.js": return EndeavourPamphlet.Private.Endeavour.EndeavourJsGzip()
        case "/public/manifest.json": return EndeavourPamphlet.Public.ManifestJsonGzip()
        case "/private/script.combined.js": return EndeavourPamphlet.Private.ScriptCombinedJsGzip()
        case "/private/shell.fonts.html": return EndeavourPamphlet.Private.ShellFontsHtmlGzip()
        case "/private/shell.html": return EndeavourPamphlet.Private.ShellHtmlGzip()
            default: break
            }
            return nil
        #endif
    }
    public static func get(data member: String) -> Data? {
        switch member {
        case "/public/icon192.png": return EndeavourPamphlet.Public.Icon192Png()
        case "/public/icon512.png": return EndeavourPamphlet.Public.Icon512Png()
        case "/public/fonts/lato.woff2": return EndeavourPamphlet.Public.Fonts.LatoWoff2()
        case "/public/fonts/roboto.woff2": return EndeavourPamphlet.Public.Fonts.RobotoWoff2()
        case "/public/endeavour/robotomono_400.woff": return EndeavourPamphlet.Public.Endeavour.Robotomono400Woff()
        case "/public/endeavour/robotomono_500.woff": return EndeavourPamphlet.Public.Endeavour.Robotomono500Woff()
        default: break
        }
        return nil
    }
}
public extension EndeavourPamphlet { enum Public { } }
public extension EndeavourPamphlet.Public { enum Endeavour { } }
public extension EndeavourPamphlet.Private { enum Endeavour { } }
public extension EndeavourPamphlet { enum Private { } }
public extension EndeavourPamphlet.Public { enum Fonts { } }
