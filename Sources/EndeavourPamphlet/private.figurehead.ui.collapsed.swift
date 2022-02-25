import Foundation

// swiftlint:disable all

public extension EndeavourPamphlet.Private.Figurehead.Ui {
    static func UiAlertHtml() -> String {
    #if DEBUG
        let fileOnDiskPath = "/Volumes/Development/Development/chimerasw3/Endeavour/Resources/private/figurehead/ui/ui.alert.html"
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
        return uncompressedUiAlertHtml
    #endif
    }
    static func UiAlertHtmlGzip() -> Data {
        return compressedUiAlertHtml
    }
}

private let uncompressedUiAlertHtml = ###"""

"""###
private let compressedUiAlertHtml = Data(base64Encoded:"H4sIAAAAAAACAwMAAAAAAAAAAAA=")!

public extension EndeavourPamphlet.Private.Figurehead.Ui {
    static func UiAlertJs() -> String {
    #if DEBUG
        let fileOnDiskPath = "/Volumes/Development/Development/chimerasw3/Endeavour/Resources/private/figurehead/ui/ui.alert.js"
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
        return uncompressedUiAlertJs
    #endif
    }
    static func UiAlertJsGzip() -> Data {
        return compressedUiAlertJs
    }
}

private let uncompressedUiAlertJs = ###"""
var alertsQueue=[];function handleAlertsQueue(){var e=function(){1==alertsContainer.isOpen&&(alertsContainer.isOpen=!1,Laba.cancel(alertsContainer),Laba.animate(alertsContainer,"f0",void 0,(function(){alertsContainer.style.display="none"})))},t=function(t){var n=document.getElementById(t);null!=n&&(0==alertsQueue.length&&e(),Laba.animate(n,"!f0",(function(e,t){e.style.height=(1-t)*e.actualHeight+"px",e.style.minHeight=e.style.height}),(function(){removeFromParent(n),handleAlertsQueue()})))};0!=alertsQueue.length?(0==alertsContainer.isOpen&&(alertsContainer.isOpen=!0,alertsContainer.style.display="flex",Laba.cancel(alertsContainer),Laba.animate(alertsContainer,"f1",void 0,(function(){}))),0==alertsContainer.children.length&&function(e){for(var n=e.message,a=e.buttons,l=e.callbacks,i=UNIQUEID(),r="",s=!0,u=a.length-1;u>=0;u-=1){var o=a[u];s?(s=!1,r+=`ALERT_BUTTON_CONTROL_DEFAULT(${i}Btn${u},${o})`):r+=`ALERT_BUTTON_CONTROL(${i}Btn${u},${o})`}for(insertHtml(alertsContainer,`ALERT(${i},${n},${r})`),u=l.length-1;u>=0;u-=1){var c=document.getElementById(i+"Btn"+u);c.callback=l[u],c.addEventListener("mouseup",(function(e){null!=e.currentTarget.callback&&e.currentTarget.callback(),t(i)}))}requestAnimationFrame((function(){var e=document.getElementById(i);e.actualHeight=e.offsetHeight,Laba.animate(e,"!f1",(function(e,t){e.style.height=t*e.actualHeight+"px",e.style.minHeight=e.style.height}),(function(e){e.style.height=""}))}))}(alertsQueue.shift())):e()}function alert(e,t,n){null!=e&&0!=e.length&&(null==alertsContainer.isOpen&&(alertsContainer.isOpen=!1),null==t&&(t=["Ok"]),null==n&&(n=[void 0]),alertsQueue.push({message:e,buttons:t,callbacks:n}),handleAlertsQueue())}

"""###
private let compressedUiAlertJs = Data(base64Encoded:"H4sIAAAAAAACA6VUbU8iMRD+fr9CGkPao5LlK5ueQcVoQkQNfCJG6+4Ajd0u1xdyZrP//VqWV11i7kwI6U5nOvM8M88suT7hErQ1Dw4csMlTPHUqsSJXJ3OuUgm93S0mxdL7A9u4eEOHsSr+MleWCwW6LcxwAarZxPUXrNGhA/7K2wlXCciPXqS65Epk3MLHW4qmEaLLXKQnEcV7dXzMZey7hHYqzELyd4ZUrgCVhJCS2l35tgKkWJonLgNl2zOwfQnhePF+m3qHWDkpGyzAiTZQV2S0JaiZnTebnpbDkhVFjVDlrjygPhOsa5qDmM0tw50zS35CmyfWcXmzMrbQ4g+iG8dMqMrMDkNLcoBcQ5Yv4Vrn2T3XvnCsCK1p3Qp8HDVqMJzvoP1DFyP6BedTCR7Nd1rdqW11QEJrKk7mQqaegW1ndvyTYpprXPXaEwvG8BlQ7s+vztpcGSr9OeFSvvLkzVDBxne3D+P+7ZVvrmYIURMAO8bXj591YveLRbE7Y51qiHLGJ+4pNufYhAnXLfbSG/QfR88X49FoePd8ObwbPQ4Hz1f96954MMKnhSgvrDotXElPi7wkL6R7LKjGuQyAhDKeghubfaKWVu+sAn2ECn865PAY5FEMyVEhiBby+VHLkTjZ8sSkR0yTNk/T/tJ7DoSx4JNjlOXOgFscaIAUlZQ8z06HQR1x7bNsX/NKOnLje2CxCBNcavjtwNjeamT8s9eaZ4D3p6PaUEdxkPhQcr6cfDo1YKvPw4mEoOTOV0q231cxfHoUhW0Vfnhfr2Yuphb7+e8GRW839col1EbVluVmMwpcb7SAg/l/djWhVaT1TpZN0PANPW1sIVCxSaVRb90vdeHMHBdrqXWBroXWtXQrs64qa1cVKX/8BT7dLlWYBgAA")!

public extension EndeavourPamphlet.Private.Figurehead.Ui {
    static func UiAllHtml() -> String {
    #if DEBUG
        let fileOnDiskPath = "/Volumes/Development/Development/chimerasw3/Endeavour/Resources/private/figurehead/ui/ui.all.html"
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
        return uncompressedUiAllHtml
    #endif
    }
    static func UiAllHtmlGzip() -> Data {
        return compressedUiAllHtml
    }
}

private let uncompressedUiAllHtml = ###"""

"""###
private let compressedUiAllHtml = Data(base64Encoded:"H4sIAAAAAAACAwMAAAAAAAAAAAA=")!

public extension EndeavourPamphlet.Private.Figurehead.Ui {
    static func UiAllJs() -> String {
    #if DEBUG
        let fileOnDiskPath = "/Volumes/Development/Development/chimerasw3/Endeavour/Resources/private/figurehead/ui/ui.all.js"
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
        return uncompressedUiAllJs
    #endif
    }
    static func UiAllJsGzip() -> Data {
        return compressedUiAllJs
    }
}

private let uncompressedUiAllJs = ###"""
function initFieldWithCount(t,e,n){t.updateCounter=function(){var u=t.value.length;e.innerText=`${u} of ${n}`,e.style.color=u<=n?"white":"ERRORRED()"},t.oninput=t.updateCounter,t.onchange=t.updateCounter,t.onkeyup=t.updateCounter,t.updateCounter()}

"""###
private let compressedUiAllJs = Data(base64Encoded:"H4sIAAAAAAACA23NwQrCMBAE0LtfEUoPCZR8gBo8aL0KQfDa0m5NMGxK3K2W0n8Xihelx5nHMB1jQz6i8Ojp7CG0N0/uGBlJUgEFqok0921NsJSQTPedSDUNdRJsSA91YNAB8E5uB9ojQrrCm0yVTzyL2Il8wrkqQD9pDKCbGGIyvDd4yF7OE2TbrLT2Ym15kiqbC9IRPfZM5u99kcbVeIdVesDI/Yr8ZKnmzQdzMqBS+QAAAA==")!

public extension EndeavourPamphlet.Private.Figurehead.Ui {
    static func UiButtonHtml() -> String {
    #if DEBUG
        let fileOnDiskPath = "/Volumes/Development/Development/chimerasw3/Endeavour/Resources/private/figurehead/ui/ui.button.html"
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
        return uncompressedUiButtonHtml
    #endif
    }
    static func UiButtonHtmlGzip() -> Data {
        return compressedUiButtonHtml
    }
}

private let uncompressedUiButtonHtml = ###"""

"""###
private let compressedUiButtonHtml = Data(base64Encoded:"H4sIAAAAAAACAwMAAAAAAAAAAAA=")!

public extension EndeavourPamphlet.Private.Figurehead.Ui {
    static func UiButtonJs() -> String {
    #if DEBUG
        let fileOnDiskPath = "/Volumes/Development/Development/chimerasw3/Endeavour/Resources/private/figurehead/ui/ui.button.js"
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
        return uncompressedUiButtonJs
    #endif
    }
    static func UiButtonJsGzip() -> Data {
        return compressedUiButtonJs
    }
}

private let uncompressedUiButtonJs = ###"""
function initButton(n,t,e){if(null!=n.length)for(let t,l=null!=n?n:[],u=0;t=l[u],u<l.length;u++)t.addEventListener("mouseup",(function(n){null!=e&&e(this)}));else n.addEventListener("mouseup",(function(n){null!=e&&e(this)}))}

"""###
private let compressedUiButtonJs = Data(base64Encoded:"H4sIAAAAAAACA6WNQQrCQAxF956idlESOhTX1kEQ3HmD4kJsxg7EjHQSN6V3V3Bu4O7De7wfTO4ak1RRop5MNQmIU0e4xABizFsvHZM8dMKQZmDSSh37go6yH67O/K5Xz4N954GL3lvbona3cTy/SfQSs5LQDPUzWSZ71Q5CeQfB5RekpiHQKWZcEXviTJX8k1g3HzfEdyLiAAAA")!

public extension EndeavourPamphlet.Private.Figurehead.Ui {
    static func UiGridHtml() -> String {
    #if DEBUG
        let fileOnDiskPath = "/Volumes/Development/Development/chimerasw3/Endeavour/Resources/private/figurehead/ui/ui.grid.html"
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
        return uncompressedUiGridHtml
    #endif
    }
    static func UiGridHtmlGzip() -> Data {
        return compressedUiGridHtml
    }
}

private let uncompressedUiGridHtml = ###"""

"""###
private let compressedUiGridHtml = Data(base64Encoded:"H4sIAAAAAAACAwMAAAAAAAAAAAA=")!

