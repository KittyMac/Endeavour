import Foundation

// swiftlint:disable all



public enum EndeavourPamphlet {
    public static let version = "v0.0.0"
    
    #if DEBUG
    public static func get(string member: String) -> String? {
        switch member {
        case "/public/close.svg": return EndeavourPamphlet.Public.CloseSvg()
        case "/private/figurehead/utility/defines.js": return EndeavourPamphlet.Private.Figurehead.Utility.DefinesJs()
        case "/public/endeavour/editor.bundle.js": return EndeavourPamphlet.Public.Endeavour.EditorBundleJs()
        case "/private/endeavour/editor.fonts.html": return EndeavourPamphlet.Private.Endeavour.EditorFontsHtml()
        case "/private/endeavour/endeavour.html": return EndeavourPamphlet.Private.Endeavour.EndeavourHtml()
        case "/private/endeavour/endeavour.js": return EndeavourPamphlet.Private.Endeavour.EndeavourJs()
        case "/private/endeavour/endeavour.style": return EndeavourPamphlet.Private.Endeavour.EndeavourStyle()
        case "/private/figurehead/figurehead.html": return EndeavourPamphlet.Private.Figurehead.FigureheadHtml()
        case "/private/figurehead/figurehead.js": return EndeavourPamphlet.Private.Figurehead.FigureheadJs()
        case "/private/figurehead/figurehead.style": return EndeavourPamphlet.Private.Figurehead.FigureheadStyle()
        case "/private/figurehead/utility/laba.js": return EndeavourPamphlet.Private.Figurehead.Utility.LabaJs()
        case "/public/manifest.json": return EndeavourPamphlet.Public.ManifestJson()
        case "/private/figurehead/utility/navigation.js": return EndeavourPamphlet.Private.Figurehead.Utility.NavigationJs()
        case "/private/script.combined.js": return EndeavourPamphlet.Private.ScriptCombinedJs()
        case "/private/shell.fonts.html": return EndeavourPamphlet.Private.ShellFontsHtml()
        case "/private/shell.html": return EndeavourPamphlet.Private.ShellHtml()
        case "/private/figurehead/utility/timer.js": return EndeavourPamphlet.Private.Figurehead.Utility.TimerJs()
        case "/private/figurehead/ui/ui.alert.html": return EndeavourPamphlet.Private.Figurehead.Ui.UiAlertHtml()
        case "/private/figurehead/ui/ui.alert.js": return EndeavourPamphlet.Private.Figurehead.Ui.UiAlertJs()
        case "/private/figurehead/ui/ui.all.html": return EndeavourPamphlet.Private.Figurehead.Ui.UiAllHtml()
        case "/private/figurehead/ui/ui.all.js": return EndeavourPamphlet.Private.Figurehead.Ui.UiAllJs()
        case "/private/figurehead/ui/ui.button.html": return EndeavourPamphlet.Private.Figurehead.Ui.UiButtonHtml()
        case "/private/figurehead/ui/ui.button.js": return EndeavourPamphlet.Private.Figurehead.Ui.UiButtonJs()
        case "/private/figurehead/ui/ui.grid.html": return EndeavourPamphlet.Private.Figurehead.Ui.UiGridHtml()
        case "/private/figurehead/utility/utility.js": return EndeavourPamphlet.Private.Figurehead.Utility.UtilityJs()
        default: break
        }
        return nil
    }
    #else
    public static func get(string member: String) -> StaticString? {
        switch member {
        case "/public/close.svg": return EndeavourPamphlet.Public.CloseSvg()
        case "/private/figurehead/utility/defines.js": return EndeavourPamphlet.Private.Figurehead.Utility.DefinesJs()
        case "/public/endeavour/editor.bundle.js": return EndeavourPamphlet.Public.Endeavour.EditorBundleJs()
        case "/private/endeavour/editor.fonts.html": return EndeavourPamphlet.Private.Endeavour.EditorFontsHtml()
        case "/private/endeavour/endeavour.html": return EndeavourPamphlet.Private.Endeavour.EndeavourHtml()
        case "/private/endeavour/endeavour.js": return EndeavourPamphlet.Private.Endeavour.EndeavourJs()
        case "/private/endeavour/endeavour.style": return EndeavourPamphlet.Private.Endeavour.EndeavourStyle()
        case "/private/figurehead/figurehead.html": return EndeavourPamphlet.Private.Figurehead.FigureheadHtml()
        case "/private/figurehead/figurehead.js": return EndeavourPamphlet.Private.Figurehead.FigureheadJs()
        case "/private/figurehead/figurehead.style": return EndeavourPamphlet.Private.Figurehead.FigureheadStyle()
        case "/private/figurehead/utility/laba.js": return EndeavourPamphlet.Private.Figurehead.Utility.LabaJs()
        case "/public/manifest.json": return EndeavourPamphlet.Public.ManifestJson()
        case "/private/figurehead/utility/navigation.js": return EndeavourPamphlet.Private.Figurehead.Utility.NavigationJs()
        case "/private/script.combined.js": return EndeavourPamphlet.Private.ScriptCombinedJs()
        case "/private/shell.fonts.html": return EndeavourPamphlet.Private.ShellFontsHtml()
        case "/private/shell.html": return EndeavourPamphlet.Private.ShellHtml()
        case "/private/figurehead/utility/timer.js": return EndeavourPamphlet.Private.Figurehead.Utility.TimerJs()
        case "/private/figurehead/ui/ui.alert.html": return EndeavourPamphlet.Private.Figurehead.Ui.UiAlertHtml()
        case "/private/figurehead/ui/ui.alert.js": return EndeavourPamphlet.Private.Figurehead.Ui.UiAlertJs()
        case "/private/figurehead/ui/ui.all.html": return EndeavourPamphlet.Private.Figurehead.Ui.UiAllHtml()
        case "/private/figurehead/ui/ui.all.js": return EndeavourPamphlet.Private.Figurehead.Ui.UiAllJs()
        case "/private/figurehead/ui/ui.button.html": return EndeavourPamphlet.Private.Figurehead.Ui.UiButtonHtml()
        case "/private/figurehead/ui/ui.button.js": return EndeavourPamphlet.Private.Figurehead.Ui.UiButtonJs()
        case "/private/figurehead/ui/ui.grid.html": return EndeavourPamphlet.Private.Figurehead.Ui.UiGridHtml()
        case "/private/figurehead/utility/utility.js": return EndeavourPamphlet.Private.Figurehead.Utility.UtilityJs()
        default: break
        }
        return nil
    }
    #endif
    public static func get(gzip member: String) -> Data? {
        #if DEBUG
            return nil
        #else
            switch member {
        case "/public/close.svg": return EndeavourPamphlet.Public.CloseSvgGzip()
        case "/private/figurehead/utility/defines.js": return EndeavourPamphlet.Private.Figurehead.Utility.DefinesJsGzip()
        case "/public/endeavour/editor.bundle.js": return EndeavourPamphlet.Public.Endeavour.EditorBundleJsGzip()
        case "/private/endeavour/editor.fonts.html": return EndeavourPamphlet.Private.Endeavour.EditorFontsHtmlGzip()
        case "/private/endeavour/endeavour.html": return EndeavourPamphlet.Private.Endeavour.EndeavourHtmlGzip()
        case "/private/endeavour/endeavour.js": return EndeavourPamphlet.Private.Endeavour.EndeavourJsGzip()
        case "/private/endeavour/endeavour.style": return EndeavourPamphlet.Private.Endeavour.EndeavourStyleGzip()
        case "/private/figurehead/figurehead.html": return EndeavourPamphlet.Private.Figurehead.FigureheadHtmlGzip()
        case "/private/figurehead/figurehead.js": return EndeavourPamphlet.Private.Figurehead.FigureheadJsGzip()
        case "/private/figurehead/figurehead.style": return EndeavourPamphlet.Private.Figurehead.FigureheadStyleGzip()
        case "/private/figurehead/utility/laba.js": return EndeavourPamphlet.Private.Figurehead.Utility.LabaJsGzip()
        case "/public/manifest.json": return EndeavourPamphlet.Public.ManifestJsonGzip()
        case "/private/figurehead/utility/navigation.js": return EndeavourPamphlet.Private.Figurehead.Utility.NavigationJsGzip()
        case "/private/script.combined.js": return EndeavourPamphlet.Private.ScriptCombinedJsGzip()
        case "/private/shell.fonts.html": return EndeavourPamphlet.Private.ShellFontsHtmlGzip()
        case "/private/shell.html": return EndeavourPamphlet.Private.ShellHtmlGzip()
        case "/private/figurehead/utility/timer.js": return EndeavourPamphlet.Private.Figurehead.Utility.TimerJsGzip()
        case "/private/figurehead/ui/ui.alert.html": return EndeavourPamphlet.Private.Figurehead.Ui.UiAlertHtmlGzip()
        case "/private/figurehead/ui/ui.alert.js": return EndeavourPamphlet.Private.Figurehead.Ui.UiAlertJsGzip()
        case "/private/figurehead/ui/ui.all.html": return EndeavourPamphlet.Private.Figurehead.Ui.UiAllHtmlGzip()
        case "/private/figurehead/ui/ui.all.js": return EndeavourPamphlet.Private.Figurehead.Ui.UiAllJsGzip()
        case "/private/figurehead/ui/ui.button.html": return EndeavourPamphlet.Private.Figurehead.Ui.UiButtonHtmlGzip()
        case "/private/figurehead/ui/ui.button.js": return EndeavourPamphlet.Private.Figurehead.Ui.UiButtonJsGzip()
        case "/private/figurehead/ui/ui.grid.html": return EndeavourPamphlet.Private.Figurehead.Ui.UiGridHtmlGzip()
        case "/private/figurehead/utility/utility.js": return EndeavourPamphlet.Private.Figurehead.Utility.UtilityJsGzip()
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
public extension EndeavourPamphlet.Private.Figurehead { enum Utility { } }
public extension EndeavourPamphlet.Public { enum Endeavour { } }
public extension EndeavourPamphlet.Private { enum Endeavour { } }
public extension EndeavourPamphlet.Private { enum Figurehead { } }
public extension EndeavourPamphlet { enum Private { } }
public extension EndeavourPamphlet.Private.Figurehead { enum Ui { } }
public extension EndeavourPamphlet.Public { enum Fonts { } }
