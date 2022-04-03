import Foundation

// swiftlint:disable all

public extension EndeavourPamphlet.Private {
    #if DEBUG
    static func ShellHtml() -> String {
        let fileOnDiskPath = "/Users/rjbowli/Development/chimerasw/Endeavour/Resources/private/shell.html"
        if let contents = try? String(contentsOf:URL(fileURLWithPath: fileOnDiskPath)) {
            if contents.hasPrefix("#define PAMPHLET_PREPROCESSOR") {
                do {
                    let task = Process()
                    task.executableURL = URL(fileURLWithPath: "/opt/homebrew/bin/pamphlet")
                    task.arguments = ["preprocess", fileOnDiskPath]
                    let outputPipe = Pipe()
                    task.standardOutput = outputPipe
                    try task.run()
                    let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
                    let output = String(decoding: outputData, as: UTF8.self)
                    return output
                } catch {
                    return "Failed to use /opt/homebrew/bin/pamphlet to preprocess the requested file"
                }
            }
            return contents
        }
        return String()
    }
    #else
    static func ShellHtml() -> StaticString {
        return uncompressedShellHtml
    }
    #endif
    static func ShellHtmlGzip() -> Data {
        return compressedShellHtml
    }
}

private let uncompressedShellHtml: StaticString = ###"""
<!doctype html> <html> <head> <meta charset="utf-8"> <meta name="apple-mobile-web-app-capable" content="yes"> <meta name="viewport" content="user-scalable=no,width=device-width,initial-scale=1.0,viewport-fit=cover"> <meta name="color-scheme" content="dark light"> <title>PicaroonTemplate</title> <link rel="manifest" href="/public/manifest.json"> <link rel="apple-touch-icon" sizes="192x192" href="/public/icon192.png"> <link rel="apple-touch-icon" sizes="512x512" href="/public/icon512.png"> <link rel="preload" href="public/fonts/lato.woff2" as="font" type="font/woff2" crossorigin> <link rel="preload" href="public/fonts/roboto.woff2" as="font" type="font/woff2" crossorigin> <style>
    @font-face {
        font-family: 'Lato';
        font-style: normal;
        font-weight: 400;
        font-display: swap;
        src: url(public/fonts/lato.woff2) format('woff2');
        unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
    }
    @font-face {
        font-family: 'Roboto';
        font-style: normal;
        font-weight: 500;
        font-display: swap;
        src: url(public/fonts/roboto.woff2) format('woff2');
        unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
    }
</style> <link rel="preload" href="public/endeavour/robotomono_400.woff" as="font" type="font/woff2" crossorigin> <style>
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
</style> <style>
    :root {
        --fh-link: rgba(55, 64, 255);
                
        --fh-fclear: rgba(255,255,255,0);
        --fh-fwhite: rgba(255,255,255,1);
        --fh-fdarkgrey: rgba(100,100,100,1);
        --fh-fgrey: rgba(200,200,200,1);
        --fh-flightgrey: rgba(242,242,242,1);
        --fh-fdarkblack: rgba(0,0,0,1);
        --fh-fblack: rgba(83,84,87,1);
        --fh-fred: rgba(255, 0, 0, 1);
        --fh-fgreen: rgba(0, 255, 0, 1);
        --fh-fblue: rgba(0, 0, 255, 1);
        --fh-fcyan: rgba(0, 255, 255, 1);
        --fh-fyellow: rgba(255, 255, 0, 1);
        
        --fh-clear: rgba(255,255,255,0);
        --fh-white: rgba(255,255,255,1);
        --fh-darkgrey: rgba(100,100,100,1);
        --fh-grey: rgba(200,200,200,1);
        --fh-lightgrey: rgba(242,242,242,1);
        --fh-darkblack: rgba(0,0,0,1);
        --fh-black: rgba(83,84,87,1);
        --fh-red: rgba(255, 0, 0, 1);
        --fh-green: rgba(0, 255, 0, 1);
        --fh-blue: rgba(0, 0, 255, 1);
        --fh-cyan: rgba(0, 255, 255, 1);
        --fh-yellow: rgba(255, 255, 0, 1);
        
        --fh-dclear: rgba(255,255,255,0.4);
        --fh-dwhite: rgba(255,255,255,0.4);
        --fh-ddarkgrey: rgba(100,100,100,0.4);
        --fh-dgrey: rgba(200,200,200,0.4);
        --fh-dlightgrey: rgba(242,242,242,0.4);
        --fh-dblack: rgba(83,84,87,0.4);
        --fh-dred: rgba(255, 0, 0, 0.4);
        --fh-dgreen: rgba(0, 255, 0, 0.4);
        --fh-dblue: rgba(0, 0, 255, 0.4);
        --fh-dcyan: rgba(0, 255, 255, 0.4);
        --fh-dyellow: rgba(255, 255, 0, 0.4);
        
        --fh-error-red: rgba(208,116,112,1);
        
        --fh-main-background: rgba(251,253,254,1);
        
        --fh-std-shadow: rgba(0,0,0,0.1);
        
        --fh-btn-background: rgba(66,147,247,1);
        --fh-btn-highlight: rgba(48,107,179,1);
        
        --fh-item-outline: rgba(200,200,200,1);
    }
    
    @media (prefers-color-scheme: dark) {
        :root {
            --fh-link: rgba(157, 162, 255);
            
            --fh-fclear: rgba(0,0,0,0);
            --fh-fwhite: rgba(65,65,65,1);
            --fh-fdarkgrey: rgba(155,155,155,1);
            --fh-fgrey: rgba(55,55,55,1);
            --fh-flightgrey: rgba(32,32,32,1);
            --fh-fdarkblack: rgba(255,255,255,1);
            --fh-fblack: rgba(172,171,168,1);
            --fh-fred: rgba(255, 0, 0, 1);
            --fh-fgreen: rgba(0, 255, 0, 1);
            --fh-fblue: rgba(0, 0, 255, 1);
            --fh-fcyan: rgba(0, 255, 255, 1);
            --fh-fyellow: rgba(255, 255, 0, 1);
        
            --fh-clear: rgba(0,0,0,0);
            --fh-white: rgba(55,55,55,1);
            --fh-darkgrey: rgba(155,155,155,1);
            --fh-grey: rgba(55,55,55,1);
            --fh-lightgrey: rgba(32,32,32,1);
            --fh-darkblack: rgba(255,255,255,1);
            --fh-black: rgba(172,171,168,1);
            --fh-red: rgba(255, 0, 0, 1);
            --fh-green: rgba(0, 255, 0, 1);
            --fh-blue: rgba(0, 0, 255, 1);
            --fh-cyan: rgba(0, 255, 255, 1);
            --fh-yellow: rgba(255, 255, 0, 1);
        
            --fh-dclear: rgba(0,0,0,0);
            --fh-dwhite: rgba(0,0,0,1);
            --fh-ddarkgrey: rgba(155,155,155,1);
            --fh-dgrey: rgba(55,55,55,1);
            --fh-dlightgrey: rgba(32,32,32,1);
            --fh-dblack: rgba(172,171,168,1);
            --fh-dred: rgba(255, 0, 0, 0.4);
            --fh-dgreen: rgba(0, 255, 0, 0.4);
            --fh-dblue: rgba(0, 0, 255, 0.4);
            --fh-dcyan: rgba(0, 255, 255, 0.4);
            --fh-dyellow: rgba(255, 255, 0, 0.4);
        
            --fh-error-red: rgba(208,116,112,1);
            
            --fh-main-background: rgba(4,2,1,1);
            
            --fh-std-shadow: rgba(70,98,136,0.3);
            
            --fh-btn-background: rgba(66,147,247,1);
            --fh-btn-highlight: rgba(48,107,179,1);
            
            --fh-item-outline: rgba(85,85,85,1);
        }
    }

    @media (prefers-color-scheme: light) { }
    
</style> <style>
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
</style> <script>
        // Required by Picaroon to hook up server-side actor with user to maintain state across connections
        if (sessionStorage.getItem("Session-Id") == undefined) {
            let sessionUUID = document.cookie.match(/SESSION_UUID=([A-Z0-9\-]*);?/);
            if (sessionUUID != undefined && sessionUUID.length > 1) {
                sessionStorage.setItem("Session-Id", sessionUUID[1]);
            }
        }
    </script> <script src="script.combined.js"></script> <style>
        h1 {
            font-size:2rem;font-family:'Roboto';
        }
        h2 {
            font-size:1.5rem;font-family:'Roboto';
        }
        h3 {
            font-size:1rem;font-family:'Roboto';
        }
        body {
            background:var(--fh-main-background);;
            overflow-y:auto;overflow-x:hidden;;
            -webkit-text-size-adjust: none;
        }
        *:focus {
            outline: none;
        }
    </style> </head> <body> <noscript> <div style="position:fixed;display:flex;justify-content:center;align-items:center;width:100%;height:100%;padding:0px;margin:0px;overflow:hidden;"> <h1>This app requires Javascript to be enabled.</h1> </div> </noscript> <div style="display:flex;flex-direction:column;min-height:100%;flex: 1 1 auto;align-items:stretch;"><a href="https://github.com/KittyMac/Endeavour" class="github-corner" aria-label="View source on GitHub"><svg width="80" height="80" viewBox="0 0 250 250" style="fill:#535457; color:white; position: absolute; top: 0; border: 0; right: 0;" aria-hidden="true"><path d="M0,0 L115,115 L130,115 L142,142 L250,250 L250,0 Z"></path><path d="M128.3,109.0 C113.8,99.7 119.0,89.6 119.0,89.6 C122.0,82.7 120.5,78.6 120.5,78.6 C119.2,72.0 123.4,76.3 123.4,76.3 C127.3,80.9 125.5,87.3 125.5,87.3 C122.9,97.6 130.6,101.9 134.4,103.2" fill="currentColor" style="transform-origin: 130px 106px;" class="octo-arm"></path><path d="M115.0,115.0 C114.9,115.1 118.7,116.5 119.8,115.4 L133.7,101.6 C136.9,99.2 139.9,98.4 142.2,98.6 C133.8,88.0 127.5,74.4 143.8,58.0 C148.5,53.4 154.0,51.2 159.7,51.0 C160.3,49.4 163.2,43.6 171.4,40.1 C171.4,40.1 176.1,42.5 178.8,56.2 C183.1,58.6 187.2,61.8 190.9,65.4 C194.5,69.0 197.7,73.2 200.1,77.6 C213.8,80.2 216.3,84.9 216.3,84.9 C212.7,93.1 206.9,96.0 205.4,96.6 C205.1,102.4 203.0,107.8 198.3,112.5 C181.9,128.9 168.3,122.5 157.7,114.1 C157.9,116.9 156.7,120.9 152.7,124.9 L141.0,136.5 C139.8,137.7 141.6,141.9 141.8,141.8 Z" fill="currentColor" class="octo-body"></path></svg></a><style>.github-corner:hover .octo-arm{animation:octocat-wave 560ms ease-in-out}@keyframes octocat-wave{0%,100%{transform:rotate(0)}20%,60%{transform:rotate(-25deg)}40%,80%{transform:rotate(10deg)}}@media (max-width:500px){.github-corner:hover .octo-arm{animation:none}.github-corner .octo-arm{animation:octocat-wave 560ms ease-in-out}}</style> <div style="display:flex;flex-direction:row;min-height:5rem;width:100%;margin-top:1rem;margin-left:1rem;margin-bottom:0rem;margin-right:1rem;"><div style="display:flex;flex-direction:column;flex: 1 1 auto;min-height:5rem;"><div style="display:flex;font-size:2.2rem;font-family:'Roboto';color:var(--fh-fblack);">Endeavour</div> <div style="display:flex;font-size:1.0rem;font-family:'Lato';color:var(--fh-fblack);">Collaborative Swift editor using CodeMirror6</div></div></div> <div style="display:flex;flex-direction:row;justify-content:flex-end;margin-top:0rem;margin-left:0.5rem;margin-bottom:0rem;margin-right:0.5rem;flex: 1 1 auto;align-self:stretch;"><div id="newDocumentButton" style="display:flex;flex-direction:row;justify-content:center;align-items:center;border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;background:var(--fh-btn-background);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;cursor:pointer;color:var(--fh-fwhite);font-size:1rem;font-family:'Roboto';-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;" onclick="sharedDocument()" onmousedown="this.style.background='var(--fh-btn-highlight)'" onmouseout="this.style.background='var(--fh-btn-background)'" onmouseup="this.style.background='var(--fh-btn-background)'"><div id="newDocumentButtonValue" style="display:flex;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">Shared Document</div></div> <div style="display:flex;flex: 1 1 auto;align-self:stretch;"></div> <div id="newDocumentButton" style="display:flex;flex-direction:row;justify-content:center;align-items:center;border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;background:var(--fh-btn-background);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;cursor:pointer;color:var(--fh-fwhite);font-size:1rem;font-family:'Roboto';-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;" onclick="newDocument()" onmousedown="this.style.background='var(--fh-btn-highlight)'" onmouseout="this.style.background='var(--fh-btn-background)'" onmouseup="this.style.background='var(--fh-btn-background)'"><div id="newDocumentButtonValue" style="display:flex;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">New Document</div></div> <div id="joinDocumentButton" style="display:flex;flex-direction:row;justify-content:center;align-items:center;border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;background:var(--fh-btn-background);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;cursor:pointer;color:var(--fh-fwhite);font-size:1rem;font-family:'Roboto';-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;" onclick="askJoinDocument()" onmousedown="this.style.background='var(--fh-btn-highlight)'" onmouseout="this.style.background='var(--fh-btn-background)'" onmouseup="this.style.background='var(--fh-btn-background)'"><div id="joinDocumentButtonValue" style="display:flex;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">Join Document</div></div></div> <div id="documents" style="display:flex;flex-direction:column;width:100%;"></div></div> <div id="alertsContainer" style="display:flex;left:0px;top:0px;margin:0px;padding:0px;width:100%;height:100%;position:fixed;position:fixed;background:rgba(0,0,0,0.5);justify-content:center;align-items:center;overflow:hidden;display:none;"></div> <script src="public/endeavour/editor.bundle.js"></script> <script>
        InitFigurehead();
        
        function handleCreateDocument(xhttp, serviceJson) {
            if (xhttp.readyState == 4 && xhttp.status != 200) {
                let error = xhttp.responseText || "An unknown error occured";
                alert(error);
                return;
            }
            
            let documentUUID = serviceJson.documentUUID;
            let documentID = `document${documentUUID}`
            let editorID = `editor${documentUUID}`
            let headerID = `header${documentUUID}`
            let peersID = `peers${documentUUID}`
            let saveID = `save${documentUUID}`
            let revertID = `revert${documentUUID}`
                            
            let html = `<div id="document${documentUUID}" style="display:flex;flex-direction:column;max-height:50rem;box-shadow: 0rem 0.5rem 2.0rem 0.1rem var(--fh-std-shadow);margin-top:1rem;margin-left:1rem;margin-bottom:0rem;margin-right:1rem;border:0.15rem solid var(--fh-item-outline);overflow:hidden;border-radius:0.75rem;background:var(--fh-white);"><div style="display:flex;flex-direction:row;align-items:center;padding-top:0.5rem;padding-left:1rem;padding-bottom:0.5rem;padding-right:1rem;margin-top:0rem;margin-left:0rem;margin-bottom:0rem;margin-right:-0.125rem;"><div style="display:flex;flex-direction:column;justify-content:space-evenly;flex: 1 1 auto;align-self:stretch;"><div id="header${documentUUID}" style="display:flex;font-size:1rem;font-family:'Lato';color:var(--fh-fblack);">Creating new document...</div> <div id="peers${documentUUID}" style="display:flex;flex-direction:row;"></div></div> <div style="display:flex;flex: 1 1 auto;align-self:stretch;"></div> <div id="revert${documentUUID}" style="display:flex;flex-direction:row;justify-content:center;align-items:center;border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;background:var(--fh-btn-background);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;cursor:pointer;color:var(--fh-fwhite);font-size:1rem;font-family:'Roboto';-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;min-width:4rem;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;" onclick="revertDocument('${documentUUID}')" onmousedown="this.style.background='var(--fh-btn-highlight)'" onmouseout="this.style.background='var(--fh-btn-background)'" onmouseup="this.style.background='var(--fh-btn-background)'"><div id="revert${documentUUID}Value" style="display:flex;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">Revert</div></div> <div id="save${documentUUID}" style="display:flex;flex-direction:row;justify-content:center;align-items:center;border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;background:var(--fh-btn-background);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;cursor:pointer;color:var(--fh-fwhite);font-size:1rem;font-family:'Roboto';-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;min-width:4rem;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;" onclick="saveDocument('${documentUUID}')" onmousedown="this.style.background='var(--fh-btn-highlight)'" onmouseout="this.style.background='var(--fh-btn-background)'" onmouseup="this.style.background='var(--fh-btn-background)'"><div id="save${documentUUID}Value" style="display:flex;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">Save</div></div> <div id="leave${documentUUID}" style="display:flex;flex-direction:row;justify-content:center;align-items:center;border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;background:var(--fh-btn-background);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;cursor:pointer;color:var(--fh-fwhite);font-size:1rem;font-family:'Roboto';-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;min-width:4rem;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;" onclick="leaveDocument('${documentUUID}')" onmousedown="this.style.background='var(--fh-btn-highlight)'" onmouseout="this.style.background='var(--fh-btn-background)'" onmouseup="this.style.background='var(--fh-btn-background)'"><div id="leave${documentUUID}Value" style="display:flex;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">Leave</div></div></div> <div style="display:flex;flex-direction:column;flex: 1 1 auto;align-items:stretch;min-height:10rem;background:rgba(255,255,255,1);"><div id="editor${documentUUID}" style="display:flex;border-top:0.1rem solid var(--fh-item-outline);flex: 1 1 auto;width:100%;overflow:hidden;"></div></div></div>`
            insertHtml(documents, html);
            
            let documentHeader = document.getElementById(headerID);
            documentHeader.innerText = `Document ${documentUUID}`;
            
            let documentSave = document.getElementById(saveID);
            let documentRevert = document.getElementById(revertID);
            if (serviceJson.canSave == 1) {
                disableDiv(documentRevert);
                disableDiv(documentSave);
            } else {
                removeFromParent(documentRevert);
                removeFromParent(documentSave);
            }
            
            
            let documentStatusUpdate = function(documentInfo, documentStatus) {
                let ignoreErrors = [
                    "Version mismatch"
                ];
                                                
                let displayText = `Document ${documentStatus.documentUUID}`;
                let isError = false;
                                
                let errorText = documentStatus.error;
                if (errorText != undefined) {
                    for (let _arr = (ignoreErrors != undefined ? ignoreErrors : []), _idx = 0, ignoreError = undefined; ignoreError = _arr[_idx], _idx < _arr.length; _idx++) {
                        if (errorText.includes(ignoreError)) {
                            errorText = undefined;
                            break;
                        }
                    }
                }
                
                if (errorText != undefined) {
                    displayText = errorText;
                    isError = true;
                }
                
                if (displayText != undefined && documentHeader.innerText != displayText) {
                    documentHeader.innerText = displayText;
                    
                    if (isError) {
                        documentHeader.style.color = `rgba(214,62,87,1)`;
                    } else {
                        documentHeader.style.color = `rgba(83,84,87,1)`;
                    }
                }
                
                let peersHeader = document.getElementById(peersID);
                if (peersHeader != undefined) {
                    let peerHtml = ``;
                    if (documentStatus.peers != undefined) {
                        for (let _arr = (documentStatus.peers != undefined ? documentStatus.peers : []), _idx = 0, peer = undefined; peer = _arr[_idx], _idx < _arr.length; _idx++) {
                            if (peer.clientID != undefined) {
                                peerHtml += `<div style="display:flex;font-size:0.75rem;font-family:'Lato';border-radius:0.5rem;padding-top:0.1rem;padding-left:0.5rem;padding-bottom:0.1rem;padding-right:0.5rem;margin-top:0rem;margin-left:0rem;margin-bottom:0rem;margin-right:0.5rem;color:${peer.colors.color};background:${peer.colors.light};justify-content:center;align-items:center;">${peer.name}</div>`;
                            }
                        }
                    }
                    
                    replaceHtml(peersHeader, peerHtml);
                }
                
                // If the version of the document is 0 then there have been
                // no changes and the save button should be disabled
                if (documentSave != undefined && documentRevert != undefined) {
                    if (documentStatus.version == 0) {
                        disableDiv(documentSave);
                        disableDiv(documentRevert);
                    } else {
                        enableDiv(documentSave);
                        enableDiv(documentRevert);
                    }
                }
            }

            let editor = cm.CreateEditor(editorID, [
                cm.swiftSetup,
                cm.endeavourExtension(serviceJson, documentStatusUpdate)
            ], xhttp.responseText, serviceJson.canWrite == 1);
            
            let myDocument = document.getElementById(documentID);
            Laba.animate(myDocument, "!<200!f")
        }
        
        function askJoinDocument() {
            ask("Enter the document UUID to join",
                "",
                ["Cancel", "Join"],
                [undefined, joinDocument]);
        }
        
        function leaveDocument(documentUUID) {
            endeavour.leave(documentUUID, function(xhttp, serviceJson) {
                let documentID = `document${documentUUID}`
                let myDocument = document.getElementById(documentID);
                let fromHeight = myDocument.clientHeight;
                Laba.animate(myDocument, "^50f0", function(item,t) {
                    item.style.height = lerp(fromHeight,0,t) + "px";
                }, function() {
                    removeFromParent(myDocument);
                });
            });
        }
        
        function saveDocument(documentUUID) {
            endeavour.save(documentUUID, function(xhttp, serviceJson) {
                if (xhttp.readyState == 4) {
                    if (xhttp.status != 200) {
                        let error = xhttp.responseText || "An unknown error occured";
                        alert(error);
                        return;
                    } else {
                        alert("Save completed")
                    }
                }
            });
        }
        
        function revertDocument(documentUUID) {
            endeavour.revert(documentUUID, function(xhttp, serviceJson) {
                if (xhttp.readyState == 4 && xhttp.status != 200) {
                    let error = xhttp.responseText || "An unknown error occured";
                    alert(error);
                    return;
                }
            });
        }
        
        function sharedDocument() {
            endeavour.join("SwiftSample", handleCreateDocument);
        }
        
        function newDocument() {
            endeavour.new(handleCreateDocument);
        }
        
        function joinDocument(documentUUID) {
            endeavour.join(documentUUID, handleCreateDocument);
        }

    </script> </body> </html>
"""###
private let compressedShellHtml = Data(base64Encoded:"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")!

public extension EndeavourPamphlet.Private {
    #if DEBUG
    static func ScriptCombinedJs() -> String {
        let fileOnDiskPath = "/Users/rjbowli/Development/chimerasw/Endeavour/Resources/private/script.combined.js"
        if let contents = try? String(contentsOf:URL(fileURLWithPath: fileOnDiskPath)) {
            if contents.hasPrefix("#define PAMPHLET_PREPROCESSOR") {
                do {
                    let task = Process()
                    task.executableURL = URL(fileURLWithPath: "/opt/homebrew/bin/pamphlet")
                    task.arguments = ["preprocess", fileOnDiskPath]
                    let outputPipe = Pipe()
                    task.standardOutput = outputPipe
                    try task.run()
                    let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
                    let output = String(decoding: outputData, as: UTF8.self)
                    return output
                } catch {
                    return "Failed to use /opt/homebrew/bin/pamphlet to preprocess the requested file"
                }
            }
            return contents
        }
        return String()
    }
    #else
    static func ScriptCombinedJs() -> StaticString {
        return uncompressedScriptCombinedJs
    }
    #endif
    static func ScriptCombinedJsGzip() -> Data {
        return compressedScriptCombinedJs
    }
}

private let uncompressedScriptCombinedJs: StaticString = ###"""
function initFieldWithCount(e,t,n){e.updateCounter=function(){var a=e.value.length;t.innerText=`${a} of ${n}`,t.style.color=a<=n?"white":"var(--fh-error-red)"},e.oninput=e.updateCounter,e.onchange=e.updateCounter,e.onkeyup=e.updateCounter,e.updateCounter()}function initFieldWithCount(e,t,n){e.updateCounter=function(){var a=e.value.length;t.innerText=`${a} of ${n}`,t.style.color=a<=n?"white":"var(--fh-error-red)"},e.oninput=e.updateCounter,e.onchange=e.updateCounter,e.onkeyup=e.updateCounter,e.updateCounter()}var alertsQueue=[];function handleAlertsQueue(){let e=function(e,t){e.style.height=t*e.actualHeight+"px",e.style.minHeight=e.style.height};var t=function(){1==alertsContainer.isOpen&&(alertsContainer.isOpen=!1,Laba.cancel(alertsContainer),Laba.animate(alertsContainer,"f0",void 0,(function(){alertsContainer.style.display="none"})))},n=function(n){var a=document.getElementById(n);null!=a&&""!==a&&"undefined"!==a&&(0==alertsQueue.length&&t(),Laba.animate(a,"!f0",(function(t,n){e(t,1-n)}),(function(){removeFromParent(a),handleAlertsQueue()})))};0!=alertsQueue.length?(0==alertsContainer.isOpen&&(alertsContainer.isOpen=!0,alertsContainer.style.display="flex",Laba.cancel(alertsContainer),Laba.animate(alertsContainer,"f1",void 0,(function(){}))),0==alertsContainer.children.length&&function(t){for(var a=t.value,r=t.ask,i=t.message,o=t.buttons,l=t.callbacks,s=UNIQUEID(),u="",m=!0,c=o.length-1;c>=0;c-=1){var f=o[c];m?(m=!1,u+=`<div id="${s}Btn${c}" style="display:flex;z-index:2;flex-direction:row;justify-content:center;align-items:center;font-size:1rem;font-family:'Roboto';border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;cursor:pointer;color:var(--fh-fwhite);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;align-self:stretch;flex: 1 1 auto;background:var(--fh-btn-background);" onmousedown="this.style.background='var(--fh-btn-highlight)'" onmouseout="this.style.background='var(--fh-btn-background)'" onmouseup="this.style.background='var(--fh-btn-background)'"><div id="${s}Btn${c}Value" style="display:flex;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">${f}</div></div>`):u+=`<div id="${s}Btn${c}" style="display:flex;z-index:2;flex-direction:row;justify-content:center;align-items:center;font-size:1rem;font-family:'Roboto';border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;cursor:pointer;color:var(--fh-fwhite);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;align-self:stretch;flex: 1 1 auto;color:var(--fh-btn-background);" onmousedown="this.style.color='var(--fh-btn-highlight)'" onmouseout="this.style.color='var(--fh-btn-background)'" onmouseup="this.style.color='var(--fh-btn-background)'"><div id="${s}Btn${c}Value" style="display:flex;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">${f}</div></div>`}insertHtml(alertsContainer,r?`<div id="${s}" class="Alert" style="display:flex;border-radius:1rem;background:var(--fh-white);box-shadow: 0rem 0.5rem 2.0rem 0.1rem var(--fh-std-shadow);flex-direction:column;padding-top:0.5rem;padding-left:2rem;padding-bottom:0rem;padding-right:2rem;max-width:90%;min-width:14rem;min-height:5rem;opacity:0;justify-content:center;align-items:center;overflow:hidden;"><div style="display:flex;flex-direction:column;text-align:center;flex: 1 1 auto;align-self:stretch;justify-content:center;align-items:center;color:var(--fh-fblack);font-size:1rem;font-family:'Lato';margin-top:2rem;margin-left:0.5rem;margin-bottom:0rem;margin-right:0.5rem;">${i}</div> <input id="${s}Value" style="display:flex;flex: 1 1 auto;align-self:stretch;min-width:0rem;height:2rem;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;border:0.1rem solid var(--fh-fgrey);border-radius:1rem;font-size:1rem;font-family:'Lato';margin-top:1rem;margin-left:0.5rem;margin-bottom:2rem;margin-right:0.5rem;" type="text" placeholder="..." /> <div style="display:flex;flex: 1 1 auto;width:100%;flex-direction:column;margin-top:0rem;margin-left:1rem;margin-bottom:0.5rem;margin-right:1rem;max-width:20rem;align-self:center;">${u}</div></div>`:`<div id="${s}" style="display:flex;border-radius:1rem;background:var(--fh-white);box-shadow: 0rem 0.5rem 2.0rem 0.1rem var(--fh-std-shadow);flex-direction:column;padding-top:0.5rem;padding-left:2rem;padding-bottom:0rem;padding-right:2rem;max-width:90%;min-width:14rem;min-height:5rem;opacity:0;justify-content:center;align-items:center;overflow:hidden;"><div style="display:flex;flex: 1 1 auto;align-self:stretch;justify-content:center;align-items:center;margin-top:0rem;margin-left:0rem;margin-bottom:0.5rem;margin-right:0rem;"><div style="display:flex;flex-direction:column;text-align:center;flex: 1 1 auto;align-self:stretch;justify-content:center;align-items:center;font-size:1rem;font-family:'Lato';margin-top:1rem;margin-left:1rem;margin-bottom:1rem;margin-right:1rem;color:var(--fh-fblack);">${i}</div></div> <div style="display:flex;flex: 1 1 auto;width:100%;flex-direction:column;margin-top:0rem;margin-left:1rem;margin-bottom:0.5rem;margin-right:1rem;max-width:20rem;align-self:center;">${u}</div></div>`);var h=document.getElementById(s+"Value");for(null!=h&&""!==h&&"undefined"!==h&&(h.callback=l[l.length-1],textFieldOnEnter(h,(function(){let e;null!=h&&""!==h&&"undefined"!==h&&(e=h.value),null!=h.callback&&""!==h.callback&&"undefined"!==h.callback&&h.callback(e),n(s)})),h.value=a,h.focus()),c=l.length-1;c>=0;c-=1){var d=document.getElementById(s+"Btn"+c);d.callback=l[c],d.addEventListener("mouseup",(function(e){let t;null!=h&&""!==h&&"undefined"!==h&&(t=h.value),null!=e.currentTarget.callback&&""!==e.currentTarget.callback&&"undefined"!==e.currentTarget.callback&&e.currentTarget.callback(t),n(s)}))}requestAnimationFrame((function(){var t=document.getElementById(s);t.actualHeight=t.offsetHeight,Laba.animate(t,"!f1",(function(t,n){e(t,n)}),(function(e){e.style.height=""}))}))}(alertsQueue.shift())):t()}function alert(e,t,n){null!=e&&""!==e&&(null!=alertsContainer.isOpen&&""!==alertsContainer.isOpen||(alertsContainer.isOpen=!1),null!=t&&""!==t||(t=["Ok"]),null!=n&&""!==n||(n=[void 0]),e=e.replaceAll("\n","<br>"),alertsQueue.push({message:e,buttons:t,callbacks:n}),handleAlertsQueue())}function ask(e,t,n,a){null!=e&&""!==e&&(null!=alertsContainer.isOpen&&""!==alertsContainer.isOpen||(alertsContainer.isOpen=!1),null!=n&&""!==n||(n=["Ok"]),null!=a&&""!==a||(a=[void 0]),e=e.replaceAll("\n","<br>"),alertsQueue.push({value:t,ask:!0,message:e,buttons:n,callbacks:a}),handleAlertsQueue())}function initButton(e,t,n){if(null!=e.length)for(let t,a=null!=e?e:[],r=0;t=a[r],r<a.length;r++)t.addEventListener("mouseup",(function(e){null!=n&&n(this)}));else e.addEventListener("mouseup",(function(e){null!=n&&n(this)}))}function StringBuilder(){var e=[];this.length=function(){for(var t=0,n=0;n<e.length;n++)t+=e[n].length;return t},this.setLength=function(t){let n=e.join("").substring(0,t);(e=[])[0]=n},this.insert=function(t,n){let a=e.join("");(e=[])[0]=a.substring(0,t),e[1]=n,e[2]=a.substring(t)},this.delete=function(t,n){let a=e.join("");(e=[])[0]=a.substring(0,t),e[1]=a.substring(n+1)},this.append=function(n){(n=t(n)).length>0&&(e[e.length]=n)},this.appendLine=function(n){if(n=t(n),this.isEmpty()){if(!(n.length>0))return;e[e.length]=n}else e[e.length]=n.length>0?"\r\n"+n:"\r\n"},this.clear=function(){e=[]},this.isEmpty=function(){return 0==e.length},this.toString=function(){return e.join("")};var t=function(e){return n(e)?a(e)!=a(new String)?String(e):e:""},n=function(e){return null!=e&&void 0!==e},a=function(e){if(!n(e.constructor))throw Error("Unexpected object type");var t=String(e.constructor).match(/function\s+(\w+)/);return n(t)?t[1]:"undefined"}}function easeLinear(e){return 0+1*e}function easeInQuad(e){return 0,1*e*e+0}function easeOutQuad(e){return 0,-1*e*(e-2)+0}function easeInOutQuad(e){return 0,(e/=.5)<1?.5*e*e+0:-.5*(--e*(e-2)-1)+0}function easeInCubic(e){return 0,1*e*e*e+0}function easeOutCubic(e){return 0,1*(--e*e*e+1)+0}function easeInOutCubic(e){return 0,(e/=.5)<1?.5*e*e*e+0:.5*((e-=2)*e*e+2)+0}function easeInQuart(e){return 0,1*e*e*e*e+0}function easeOutQuart(e){return 0,-1*(--e*e*e*e-1)+0}function easeInOutQuart(e){return 0,(e/=.5)<1?.5*e*e*e*e+0:-.5*((e-=2)*e*e*e-2)+0}function easeInQuint(e){return 0,1*e*e*e*e*e+0}function easeOutQuint(e){return 0,1*(--e*e*e*e*e+1)+0}function easeInOutQuint(e){return 0,(e/=.5)<1?.5*e*e*e*e*e+0:.5*((e-=2)*e*e*e*e+2)+0}function easeInSine(e){return 0,-1*Math.cos(e/1*(Math.PI/2))+1+0}function easeOutSine(e){return 0,1*Math.sin(e/1*(Math.PI/2))+0}function easeInOutSine(e){return 0,-.5*(Math.cos(Math.PI*e/1)-1)+0}function easeInExpo(e){return 0,1*Math.pow(2,10*(e/1-1))+0}function easeOutExpo(e){return 0,1*(1-Math.pow(2,-10*e/1))+0}function easeInOutExpo(e){return 0,(e/=.5)<1?.5*Math.pow(2,10*(e-1))+0:(e--,.5*(2-Math.pow(2,-10*e))+0)}function easeInCirc(e){return 0,-1*(Math.sqrt(1-e*e)-1)+0}function easeOutCirc(e){return e--,0,1*Math.sqrt(1-e*e)+0}function easeInOutCirc(e){return 0,(e/=.5)<1?-.5*(Math.sqrt(1-e*e)-1)+0:(e-=2,.5*(Math.sqrt(1-e*e)+1)+0)}function easeOutBounce(e){return e<4/11?121*e*e/16:e<8/11?9.075*e*e-9.9*e+3.4:e<.9?4356/361*e*e-35442/1805*e+16061/1805:10.8*e*e-20.52*e+10.72}function easeInBounce(e){return 1-easeOutBounce(1-e)}function easeInOutBounce(e){return e<.5?.5*easeInBounce(2*e):.5*easeOutBounce(2*e-1)+.5}function easeShake(e){return(Math.sin(3.14*e*6+.785)-.5)*(1-e)}String.prototype.format=function(){for(k in a=this,arguments)a=a.replace("{"+k+"}",arguments[k]);return a},Math.radians=function(e){return e*Math.PI/180},Math.degrees=function(e){return 180*e/Math.PI};var _allLabalTimers=[];class _LabaTimer{update(){var e=(performance.now()-this.startTime)/(this.endTime-this.startTime);if(this.endTime==this.startTime&&(e=1),e>=1&&(e=1),null!=this.onUpdate){var t=this.action.easing;null==t&&(t=easeInOutQuad),this.onUpdate(this.view,t(e))}if(e>=1)return this.action(e,!1),-1==this.loopCount?(this.action(0,!0),this.startTime=performance.now(),this.endTime=this.startTime+1e3*this.duration,void this.view.labaCommitElemVars()):this.loopCount>1?(this.loopCount--,this.action(0,!0),this.startTime=performance.now(),this.endTime=this.startTime+1e3*this.duration,void this.view.labaCommitElemVars()):(removeOne(_allLabalTimers,this),null!=this.onComplete&&this.onComplete(this.view),void this.view.labaCommitElemVars());this.action(e,!1),this.view.labaCommitElemVars()}constructor(e,t,n,a,r,i,o,l){this.view=e,this.loopCount=l,this.action=t,this.duration=r,this.onComplete=o,this.onUpdate=i,this.startTime=performance.now(),this.endTime=this.startTime+1e3*this.duration,this.action(0,!0),_allLabalTimers.push(this),this.update(0)}}class _LabaAction{constructor(e,t,n,a,r,i,o){this.operatorChar=t,this.elem=n,this.inverse=a,this.rawValue=r,this.easing=i,this.easingName=o,this.action=e.PerformActions[t],this._describe=e.DescribeActions[t],this._init=e.InitActions[t],0==this.inverse?(this.fromValue=0,this.toValue=1):(this.fromValue=1,this.toValue=0),null!=this._init&&this._init(this)}reset(e){if(null!=this._init){var t=new _LabaAction(e,this.operatorChar,this.elem,this.inverse,this.rawValue,this.easing,this.easingName);return this.fromValue=t.fromValue,this.toValue=t.toValue,!0}return!1}perform(e){return null!=this.action&&(this.action(this.elem,this.fromValue+(this.toValue-this.fromValue)*this.easing(e),this),!0)}describe(e){return null!=this._describe&&(this._describe(e,this),!0)}}class _Laba{isOperator(e){return","==e||"|"==e||"!"==e||"e"==e||e in this.InitActions}isNumber(e){return"+"==e||"-"==e||"0"==e||"1"==e||"2"==e||"3"==e||"4"==e||"5"==e||"6"==e||"7"==e||"8"==e||"9"==e||"."==e}update(){for(var e in _allLabalTimers)_allLabalTimers[e].update()}parseAnimationString(e,t){for(var n=0,a=0,r=0,i=this.allEasings[3],o=this.allEasingsByName[3],l=[],s=0;s<this.kMaxPipes;s++){l[s]=[];for(var u=0;u<this.kMaxActions;u++)l[s][u]=void 0}for(;n<t.length;){for(var m=!1,c=" ";n<t.length;){var f=t[n];if(this.isOperator(f))if("!"==f)m=!0;else if("|"==f)a++,r=0;else{if(","!=f){c=f,n++;break}0!=r&&(a++,r=0),l[a][r]=new _LabaAction(this,"d",e,!1,.26*this.kDefaultDuration,i,o),a++,r=0}n++}for(;n<t.length&&!this.isNumber(t[n])&&!this.isOperator(t[n]);)n++;var h=this.LabaDefaultValue;if(n<t.length&&this.isNumber(t[n])){var d=!1;"+"==t[n]?n++:"-"==t[n]&&(d=!0,n++),h=0;for(var p=!1,g=10;n<t.length;){f=t[n];if(this.isNumber(f)&&(f>="0"&&f<="9"&&(p?(h+=(f-"0")/g,g*=10):h=10*h+(f-"0")),"."==f&&(p=!0)),this.isOperator(f))break;n++}d&&(h*=-1)}if(" "!=c)if(c in this.InitActions)l[a][r]=new _LabaAction(this,c,e,m,h,i,o),r++;else if("e"==c){var b=h;b>=0&&n<this.allEasings.length&&(i=this.allEasings[b],o=this.allEasingsByName[b])}}return l}animateOne(e,t,n,a){for(var r=this,i=this.parseAnimationString(e,t),o=this.PerformActions.d,l=this.PerformActions.D,s=this.PerformActions.L,u=this.PerformActions.l,m=0,c=0,f=1,h=!1,d=0;d<this.kMaxPipes;d++)if(null!=i[d][0]){m++;for(var p=this.kDefaultDuration,g=0;g<this.kMaxActions;g++)null!=i[d][g]&&(i[d][g].action!=o&&i[d][g].action!=l||(p=i[d][g].fromValue),i[d][g].action==s&&(f=i[d][g].fromValue),i[d][g].action==u&&(h=!0,f=i[d][g].fromValue));c+=p}if(1==m)if(h)new _LabaTimer(e,(function(e,t){if(1==t)for(var n=0;n<r.kMaxActions&&(null==i[0][n]||i[0][n].reset(r));n++);for(var a=0;a<r.kMaxActions&&(null==i[0][a]||i[0][a].perform(e));a++);}),0,1,c,n,a,f);else{for(g=0;g<r.kMaxActions&&(null==i[0][g]||i[0][g].reset(r));g++);new _LabaTimer(e,(function(e,t){for(var n=0;n<r.kMaxActions&&(null==i[0][n]||i[0][n].perform(e));n++);}),0,1,c*r.kTimeScale,n,a,f)}else{for(var b=void 0,v=m-1;v>=0;v--){p=this.kDefaultDuration;var w=1,x=!1;for(g=0;g<this.kMaxActions;g++)null!=i[v][g]&&(i[v][g].action!=o&&i[v][g].action!=l||(p=i[v][g].fromValue),i[v][g].action==s&&(w=i[v][g].fromValue),i[v][g].action==u&&(x=!0,w=i[v][g].fromValue));let t=v;var V=b;null==V&&(V=a),null==V&&(V=function(){});let m=x,c=p,f=w,h=V;b=function(){if(m)new _LabaTimer(e,(function(e,n){if(1==n)for(var a=0;a<r.kMaxActions&&(null==i[t][a]||i[t][a].reset(r));a++);for(a=0;a<r.kMaxActions&&(null==i[t][a]||i[t][a].perform(e));a++);}),0,1,c,n,h,f);else{for(var a=0;a<r.kMaxActions&&(null==i[t][a]||i[t][a].reset(r));a++);new _LabaTimer(e,(function(e,n){for(var a=0;a<r.kMaxActions&&(null==i[t][a]||i[t][a].perform(e));a++);}),0,1,c*r.kTimeScale,n,h,f)}}}null!=b?b():null!=a&&a(this.view)}}reset(e){if(null==e.labaTransformX){var t=e;t.labaResetElemVars=function(){t.labaTransformX=0,t.labaTransformY=0,t.labaTransformZ=0,t.labaRotationX=0,t.labaRotationY=0,t.labaRotationZ=0,t.labaScale=1,null!=t.style&&(t.labaAlpha=parseFloat(t.style.opacity)),isNaN(t.labaAlpha)&&(t.labaAlpha=1)},t.labaCommitElemVars=function(){if(null!=t.position&&(t.position.set(t.labaTransformX,t.labaTransformY),t.scale.set(t.labaScale,t.labaScale),t.rotation=t.labaRotationZ,t.alpha=t.labaAlpha),null!=t.style){var e=Matrix.identity();e=Matrix.multiply(e,Matrix.translate(t.labaTransformX,t.labaTransformY,t.labaTransformZ)),e=Matrix.multiply(e,Matrix.rotateX(Math.radians(t.labaRotationX))),e=Matrix.multiply(e,Matrix.rotateY(Math.radians(t.labaRotationY))),e=Matrix.multiply(e,Matrix.rotateZ(Math.radians(t.labaRotationZ))),e=Matrix.multiply(e,Matrix.scale(t.labaScale,t.labaScale,t.labaScale));let n="perspective(500px) matrix3d({0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13},{14},{15})".format(e.m00,e.m10,e.m20,e.m30,e.m01,e.m11,e.m21,e.m31,e.m02,e.m12,e.m22,e.m32,e.m03,e.m13,e.m23,e.m33);t.style.webkitTransform=n,t.style.MozTransform=n,t.style.msTransform=n,t.style.OTransform=n,t.style.transform=n,t.style.opacity=t.labaAlpha}}}e.labaResetElemVars(),null==e.style&&null!=e.position&&(e.labaTransformX=e.position.x,e.labaTransformY=e.position.y,e.labaRotationZ=e.rotation,e.labaScale=e.scale.x,e.labaAlpha=e.alpha)}set(e,t,n,a,r,i,o,l,s){this.reset(e),e.labaTransformX=t,e.labaTransformY=n,e.labaTransformZ=a,e.labaRotationX=r,e.labaRotationY=i,e.labaRotationZ=o,e.labaScale=l,e.labaAlpha=s,e.labaCommitElemVars()}animate(e,t,n,a){if(null==e.labaTransformX&&this.reset(e),t.includes("["))for(var r=t.replace("["," ").split("]"),i=0;i<r.length;i++){var o=r[i];o.length>0&&(this.animateOne(e,o,n,a),a=void 0)}else this.animateOne(e,t,n,a),a=void 0}cancel(e){for(var t in _allLabalTimers)_allLabalTimers[t].view==e&&removeOne(_allLabalTimers,_allLabalTimers[t])}describeOne(e,t,n){for(var a=this.parseAnimationString(e,t),r=this.PerformActions.d,i=this.PerformActions.D,o=this.PerformActions.L,l=this.PerformActions.l,s=0,u=0,m=1,c="absolute",f=0;f<this.kMaxPipes;f++)if(null!=a[f][0]){s++;for(var h=this.kDefaultDuration,d=0;d<this.kMaxActions;d++)null!=a[f][d]&&(a[f][d].action!=r&&a[f][d].action!=i||(h=a[f][d].fromValue),a[f][d].action==o&&(m=a[f][d].fromValue),a[f][d].action==l&&(m=a[f][d].fromValue,c="relative"));u+=h}if(1==s){var p=n.length();for(f=0;f<this.kMaxActions&&(null==a[0][f]||a[0][f].describe(n));f++);m>1?n.append(" {0} repeating {1} times, ".format(c,m)):-1==m&&n.append(" {0} repeating forever, ".format(c)),p!=n.length()?(n.append(" {0}  ".format(a[0][0].easingName)),n.setLength(n.length()-2),0==u?n.append(" instantly."):n.append(" over {0} seconds.".format(u*this.kTimeScale))):(n.length()>2&&n.setLength(n.length()-2),n.append(" wait for {0} seconds.".format(u*this.kTimeScale)))}else for(var g=0;g<s;g++){p=n.length(),h=this.kDefaultDuration;var b=1,v="absolute";for(d=0;d<this.kMaxActions;d++)null!=a[g][d]&&(a[g][d].action!=r&&a[g][d].action!=i||(h=a[g][d].fromValue),a[g][d].action==o&&(b=a[g][d].fromValue),a[g][d].action==l&&(b=a[g][d].fromValue,v="relative"));var w=g;for(d=0;d<this.kMaxActions&&(null==a[w][d]||a[w][d].reset(this));d++);for(d=0;d<this.kMaxActions&&(null==a[w][d]||a[w][d].describe(n));d++);b>1?n.append(" {0} repeating {1} times, ".format(v,b)):-1==b&&n.append(" {0} repeating forever, ".format(v)),p!=n.length()?(n.append(" {0}  ".format(a[w][0].easingName)),n.setLength(n.length()-2),0==h?n.append(" instantly."):n.append(" over {0} seconds.".format(h*this.kTimeScale))):n.append(" wait for {0} seconds.".format(h*this.kTimeScale)),g+1<s&&n.append(" Once complete then  ")}}describe(e,t){if(null==t||0==t.length)return"do nothing";var n=new StringBuilder;if(t.includes("[")){var a=t.replace("["," ").split("]"),r=0;n.append("Perform a series of animations at the same time.\n");for(var i=0;i<a.length;i++){var o=a[i];o.length>0&&(n.append("Animation #{0} will ".format(r+1)),this.describeOne(e,o,n),n.append("\n"),r++)}}else this.describeOne(e,t,n);return n.length()>0&&(n.insert(0,n.toString().substring(0,1).toUpperCase()),n.delete(1,1)),n.toString()}registerOperation(e,t,n,a){this.InitActions[e]=t,this.PerformActions[e]=n,this.DescribeActions[e]=a}constructor(){this.allEasings=[easeLinear,easeInQuad,easeOutQuad,easeInOutQuad,easeInCubic,easeOutCubic,easeInOutCubic,easeInQuart,easeOutQuart,easeInOutQuart,easeInQuint,easeOutQuint,easeInOutQuint,easeInSine,easeOutSine,easeInOutSine,easeInExpo,easeOutExpo,easeInOutExpo,easeInCirc,easeOutCirc,easeInOutCirc,easeInBounce,easeOutBounce,easeInOutBounce,easeShake],this.allEasingsByName=["ease linear","ease out quad","ease in quad","ease in/out quad","ease in cubic","ease out cubic","ease in/out cubic","ease in quart","ease out quart","ease in/out quart","ease in quint","ease out quint","ease in/out quint","ease in sine","eas out sine","ease in/out sine","ease in expo","ease out expo","ease in out expo","ease in circ","ease out circ","ease in/out circ","ease in bounce","ease out bounce","ease in/out bounce","ease shake"],this.LabaDefaultValue=Number.MIN_VALUE,this.InitActions={},this.PerformActions={},this.DescribeActions={},this.kMaxPipes=40,this.kMaxActions=40,this.kDefaultDuration=.57,this.kTimeScale=1;let e=this.LabaDefaultValue,t=this.kDefaultDuration;this.registerOperation("L",(function(t){return t.rawValue==e&&(t.rawValue=-1),t.fromValue=t.toValue=t.rawValue,t}),(function(e,t,n){}),(function(e,t){})),this.registerOperation("l",(function(t){return t.rawValue==e&&(t.rawValue=-1),t.fromValue=t.toValue=t.rawValue,t}),(function(e,t,n){}),(function(e,t){})),this.registerOperation("d",(function(n){return n.rawValue==e&&(n.rawValue=t),n.fromValue=n.toValue=n.rawValue,n}),(function(e,t,n){}),(function(e,t){})),this.registerOperation("D",(function(n){n.rawValue==e&&(n.rawValue=t);for(var a=0,r=n.elem;null!=(r=r.previousSibling);)a++;return n.fromValue=n.toValue=n.rawValue*a,n}),(function(e,t,n){}),(function(e,t){})),this.registerOperation("x",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.rawValue,t.toValue=t.elem.labaTransformX):(t.fromValue=t.elem.labaTransformX,t.toValue=t.rawValue),t}),(function(e,t,n){e.labaTransformX=t}),(function(e,t){t.inverse?e.append("move from {0} x pos, ".format(t.rawValue)):e.append("move to {0} x pos, ".format(t.rawValue))})),this.registerOperation("y",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.rawValue,t.toValue=t.elem.labaTransformY):(t.fromValue=t.elem.labaTransformY,t.toValue=t.rawValue),t}),(function(e,t,n){e.labaTransformY=t}),(function(e,t){t.inverse?e.append("move from {0} y pos, ".format(t.rawValue)):e.append("move to {0} y pos, ".format(t.rawValue))})),this.registerOperation("z",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.rawValue,t.toValue=t.elem.labaTransformZ):(t.fromValue=t.elem.labaTransformZ,t.toValue=t.rawValue),t}),(function(e,t,n){e.labaTransformZ=t}),(function(e,t){t.inverse?e.append("move from {0} z pos, ".format(t.rawValue)):e.append("move to {0} z pos, ".format(t.rawValue))})),this.registerOperation("<",(function(t){return t.rawValue==e&&(t.rawValue=t.elem.offsetWidth),t.inverse?(t.fromValue=t.elem.labaTransformX+t.rawValue,t.toValue=t.elem.labaTransformX):(t.fromValue=t.elem.labaTransformX,t.toValue=t.elem.labaTransformX-t.rawValue),t}),(function(e,t,n){e.labaTransformX=t}),(function(e,t){t.inverse?e.append("move in from right {0} units, ".format(t.rawValue)):e.append("move left {0} units, ".format(t.rawValue))})),this.registerOperation(">",(function(t){return t.rawValue==e&&(t.rawValue=t.elem.offsetWidth),t.inverse?(t.fromValue=t.elem.labaTransformX-t.rawValue,t.toValue=t.elem.labaTransformX):(t.fromValue=t.elem.labaTransformX,t.toValue=t.elem.labaTransformX+t.rawValue),t}),(function(e,t,n){e.labaTransformX=t}),(function(e,t){t.inverse?e.append("move in from left {0} units, ".format(t.rawValue)):e.append("move right {0} units, ".format(t.rawValue))})),this.registerOperation("^",(function(t){return t.rawValue==e&&(t.rawValue=t.elem.offsetHeight),t.inverse?(t.fromValue=t.elem.labaTransformY+t.rawValue,t.toValue=t.elem.labaTransformY):(t.fromValue=t.elem.labaTransformY,t.toValue=t.elem.labaTransformY-t.rawValue),t}),(function(e,t,n){e.labaTransformY=t}),(function(e,t){t.inverse?e.append("move in from below {0} units, ".format(t.rawValue)):e.append("move up {0} units, ".format(t.rawValue))})),this.registerOperation("v",(function(t){return t.rawValue==e&&(t.rawValue=t.elem.offsetHeight),t.inverse?(t.fromValue=t.elem.labaTransformY-t.rawValue,t.toValue=t.elem.labaTransformY):(t.fromValue=t.elem.labaTransformY,t.toValue=t.elem.labaTransformY+t.rawValue),t}),(function(e,t,n){e.labaTransformY=t}),(function(e,t){t.inverse?e.append("move in from above {0} units, ".format(t.rawValue)):e.append("move down {0} units, ".format(t.rawValue))})),this.registerOperation("s",(function(t){return t.rawValue==e&&(t.rawValue=1),t.inverse?(t.fromValue=t.rawValue>.5?0:1,t.toValue=t.rawValue):(t.fromValue=t.elem.labaScale,t.toValue=t.rawValue),t}),(function(e,t,n){e.labaScale=t}),(function(e,t){t.inverse?e.append("scale in from {0}%, ".format(100*t.rawValue)):e.append("scale to {0}%, ".format(100*t.rawValue))})),this.registerOperation("r",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.elem.labaRotationZ+t.rawValue,t.toValue=t.elem.labaRotationZ):(t.fromValue=t.elem.labaRotationZ,t.toValue=t.elem.labaRotationZ-t.rawValue),t}),(function(e,t,n){e.labaRotationZ=t}),(function(e,t){t.inverse?e.append("rotate in from around z by {0}, ".format(t.rawValue)):e.append("rotate around z by {0}, ".format(t.rawValue))})),this.registerOperation("p",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.elem.labaRotationX+t.rawValue,t.toValue=t.elem.labaRotationX):(t.fromValue=t.elem.labaRotationX,t.toValue=t.elem.labaRotationX-t.rawValue),t}),(function(e,t,n){e.labaRotationX=t}),(function(e,t){t.inverse?e.append("rotate in from around x by {0}, ".format(t.rawValue)):e.append("rotate around x by {0}, ".format(t.rawValue))})),this.registerOperation("w",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.elem.labaRotationY+t.rawValue,t.toValue=t.elem.labaRotationY):(t.fromValue=t.elem.labaRotationY,t.toValue=t.elem.labaRotationY-t.rawValue),t}),(function(e,t,n){e.labaRotationY=t}),(function(e,t){t.inverse?e.append("rotate in from around y by {0}, ".format(t.rawValue)):e.append("rotate around y by {0}, ".format(t.rawValue))})),this.registerOperation("f",(function(t){return t.rawValue==e&&(t.rawValue=1),t.inverse?(t.fromValue=t.rawValue>.5?0:1,t.toValue=t.rawValue):(t.fromValue=t.elem.labaAlpha,t.toValue=t.rawValue),t}),(function(e,t,n){e.labaAlpha=t}),(function(e,t){t.inverse?e.append("fade from {0}% to {1}%, ".format(100*t.fromValue,100*t.toValue)):e.append("fade to {0}%, ".format(100*t.rawValue))}))}}var Laba=new _Laba;class Matrix{constructor(e,t,n,a,r,i,o,l,s,u,m,c,f,h,d,p){this.m00=e,this.m01=t,this.m02=n,this.m03=a,this.m10=r,this.m11=i,this.m12=o,this.m13=l,this.m20=s,this.m21=u,this.m22=m,this.m23=c,this.m30=f,this.m31=h,this.m32=d,this.m33=p}static identity(){return new Matrix(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1)}static translate(e,t,n){return new Matrix(1,0,0,e,0,1,0,t,0,0,1,n,0,0,0,1)}static scale(e,t,n){return new Matrix(e,0,0,0,0,t,0,0,0,0,n,0,0,0,0,1)}static rotateX(e){let t=Math.sin(e),n=Math.cos(e);return new Matrix(1,0,0,0,0,n,-t,0,0,t,n,0,0,0,0,1)}static rotateY(e){let t=Math.sin(e),n=Math.cos(e);return new Matrix(n,0,t,0,0,1,0,0,-t,0,n,0,0,0,0,1)}static rotateZ(e){let t=Math.sin(e),n=Math.cos(e);return new Matrix(n,-t,0,0,t,n,0,0,0,0,1,0,0,0,0,1)}static ortho(e,t,n,a,r,i){return new Matrix(2/(t-e),0,0,-(t+e)/(t-e),0,2/(a-n),0,-(a+n)/(a-n),0,0,-2/(i-r),-(i+r)/(i-r),0,0,0,1)}static ortho2d(e,t,n,a){return new Matrix.ortho(e,t,n,a,-1,1)}static frustrum(e,t,n,a,r,i){return new Matrix(2*r/(t-e),0,(t+e)/(t-e),0,0,2*r/(a-n),(a+n)/(a-n),0,0,0,-(i+r)/(i-r),-2*i*r/(i-r),0,0,-1,0)}static perspective(e,t,n,a){let r=n*tan(e*Float.pi/360),i=-r;return m4_frustrum(i*t,r*t,i,r,n,a)}static multiply(e,t){var n=Matrix.identity();return n.m00=e.m00*t.m00+e.m01*t.m10+e.m02*t.m20+e.m03*t.m30,n.m10=e.m10*t.m00+e.m11*t.m10+e.m12*t.m20+e.m13*t.m30,n.m20=e.m20*t.m00+e.m21*t.m10+e.m22*t.m20+e.m23*t.m30,n.m30=e.m30*t.m00+e.m31*t.m10+e.m32*t.m20+e.m33*t.m30,n.m01=e.m00*t.m01+e.m01*t.m11+e.m02*t.m21+e.m03*t.m31,n.m11=e.m10*t.m01+e.m11*t.m11+e.m12*t.m21+e.m13*t.m31,n.m21=e.m20*t.m01+e.m21*t.m11+e.m22*t.m21+e.m23*t.m31,n.m31=e.m30*t.m01+e.m31*t.m11+e.m32*t.m21+e.m33*t.m31,n.m02=e.m00*t.m02+e.m01*t.m12+e.m02*t.m22+e.m03*t.m32,n.m12=e.m10*t.m02+e.m11*t.m12+e.m12*t.m22+e.m13*t.m32,n.m22=e.m20*t.m02+e.m21*t.m12+e.m22*t.m22+e.m23*t.m32,n.m32=e.m30*t.m02+e.m31*t.m12+e.m32*t.m22+e.m33*t.m32,n.m03=e.m00*t.m03+e.m01*t.m13+e.m02*t.m23+e.m03*t.m33,n.m13=e.m10*t.m03+e.m11*t.m13+e.m12*t.m23+e.m13*t.m33,n.m23=e.m20*t.m03+e.m21*t.m13+e.m22*t.m23+e.m23*t.m33,n.m33=e.m30*t.m03+e.m31*t.m13+e.m32*t.m23+e.m33*t.m33,n}}function isDarkMode(){return!(!window.matchMedia||!window.matchMedia("(prefers-color-scheme: dark)").matches)}function watchDarkMode(e){window.matchMedia("(prefers-color-scheme: dark)").addEventListener("change",(t=>{e(t.matches)}))}function print(e){console.log(e)}function hide(e){e.style.display="none"}function show(e){e.style.display="flex"}function hashCode(e){return e.split("").reduce((function(e,t){return(e=(e<<5)-e+t.charCodeAt(0))&e}),0)}function onRangeChange(e,t){var n,a,r;e.addEventListener("input",(function(e){n=1,(a=e.target.value)!=r&&t(e),r=a})),e.addEventListener("change",(function(e){n||t(e)}))}function rad2Deg(e){return e*(180/Math.PI)}function deg2Rad(e){return e*(Math.PI/180)}function rand01(){return Math.random()}function randSign(){return Math.random()<.5?-1:1}function randomFromArray(e){return e[Math.floor(Math.random()*e.length)]}function getChild(e,t){return e.getElementById(t)}function insertAt(e,t,n){e.splice(t,0,n)}function removeAt(e,t){return e.splice(t,1),e}function removeOne(e,t){var n=e.indexOf(t);return n>-1&&e.splice(n,1),e}function removeAll(e,t){for(var n=0;n<e.length;)e[n]===t?e.splice(n,1):++n;return e}function removeAllChildren(e){for(;e.firstChild;)e.removeChild(e.firstChild)}function removeFromParent(e){e.parentElement&&e.parentElement.removeChild(e)}function disableDiv(e){e.style.opacity=.5,e.style.pointerEvents="none"}function enableDiv(e){e.style.opacity=1,e.style.pointerEvents="auto"}function replaceHtml(e,t){e.innerHTML=t,runAllScriptsIn(e)}function insertHtml(e,t){let n=e.children.length;e.insertAdjacentHTML("beforeend",t);for(var a=n;a<e.children.length;a++)runAllScriptsIn(e.children[a]);return e.children[n]}function runAllScriptsIn(div){"text/javascript"==div.type&&eval(div.innerHTML);var scripts=Array.from(div.getElementsByTagName("script"));for(let _arr=null!=scripts?scripts:[],_idx=0,child;child=_arr[_idx],_idx<_arr.length;_idx++)null!=child.type&&"text/javascript"!=child.type||eval(child.innerHTML)}function prettyDate(e,t=!0){if(0==t)return new Date(e).toLocaleDateString("en-US");let n=(new Date-new Date(e))/1e3,a=Math.floor(n/86400);return isNaN(a)||a<0||a>=31?new Date(e).toLocaleDateString("en-US"):0==a&&((n<60?"just now":n<120&&"1 minute ago")||n<3600&&Math.floor(n/60)+" minutes ago"||n<7200&&"1 hour ago"||n<86400&&Math.floor(n/3600)+" hours ago")||1==a&&"Yesterday"||a<7&&a+" days ago"||a<31&&Math.ceil(a/7)+" weeks ago"}function lerp(e,t,n){return e*(1-n)+t*n}function clamp(e,t,n){return e<=t?t:e>=n?n:e}function clamp01(e){return e<=0?0:e>=1?1:e}function parseVec(e){if(null==e)return{x:0,y:0};var t=e.split(",");return{x:parseFloat(t[0]),y:parseFloat(t[1])}}function distanceSq(e,t){return(t.x-e.x)*(t.x-e.x)+(t.y-e.y)*(t.y-e.y)}function allElementsFromPoint(e,t){for(var n,a=[],r=[];(n=document.elementFromPoint(e,t))&&n!==document.documentElement;)a.push(n),r.push(n.style.visibility),n.style.visibility="hidden";for(var i=0;i<a.length;i++)a[i].style.visibility=r[i];return a.reverse(),a}function textFieldOnReturn(e,t){e.addEventListener("keyup",(function(e){13===e.keyCode&&(e.preventDefault(),t())}))}function textFieldOnChange(e,t){e.addEventListener("keyup",(function(n){clearTimeout(e.searchTimeout),13===n.keyCode?(n.preventDefault(),t()):e.searchTimeout=setTimeout((function(){t()}),650)}))}function textFieldOnEnter(e,t){e.addEventListener("keyup",(function(e){13===e.keyCode&&(e.preventDefault(),t())}))}function UUID(){return"xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g,(function(e){var t=16*Math.random()|0;return("x"==e?t:3&t|8).toString(16)}))}function UNIQUEID(){return"bxxxxxxxxxxxx4xxxyxxxxxxxxxxxxxxx".replace(/[xy]/g,(function(e){var t=16*Math.random()|0;return("x"==e?t:3&t|8).toString(16)}))}function stripHtml(e){print(e);let t=(new DOMParser).parseFromString(e,"text/html");return print(t.body.textContent),t.body.textContent||""}function unstripHtml(e){return e.replace("&lt;","<")}function clone(e){return JSON.parse(JSON.stringify(e))}function isSmallScreen(){return window.innerWidth<window.innerHeight||window.innerWidth<900}function sendIfModified(e,t,n,a){var r=new XMLHttpRequest;r.onreadystatechange=function(){4==this.readyState&&(503==this.status?window.location.href="./":(200!=this.status&&(null!=this.responseText&&this.responseText.length>0||this.statusText),null!=a&&a(this)))},r.open("POST","./");let i=sessionStorage.getItem("Session-Id");null!=i&&r.setRequestHeader("Session-Id",i),r.setRequestHeader("Flynn-Tag","hotload"),r.setRequestHeader("Pragma","no-cache"),r.setRequestHeader("Expires","-1"),r.setRequestHeader("Cache-Control","no-cache"),null!=t&&r.setRequestHeader("If-Modified-Since",t),e instanceof FormData?r.send(e):(r.setRequestHeader("Content-Type","application/json;charset=UTF-8"),r.send(JSON.stringify(e)))}function send(e,t){return sendIfModified(e,void 0,!1,t)}function endSession(e){send({endUserSession:!0},(function(){e()}))}let globalTimers=[];function initTimers(){setInterval(callTimers,250)}function callTimers(){for(let e,t=null!=globalTimers?globalTimers:[],n=0;e=t[n],n<t.length;n++)e.counter-=250,e.counter<=0&&(e.counter=e.delay,e.callback())}function addTimer(e,t){globalTimers.push({callback:t,delay:e,counter:e})}function clearTimer(e){for(let t,n=null!=globalTimers?globalTimers:[],a=0;t=n[a],a<n.length;a++)t.callback==e&&removeOne(globalTimers,t)}function clearAllTimer(){globalTimers=[]}function InitFigurehead(){initTimers(),function e(){Laba.update(),window.requestAnimationFrame(e)}()}let endeavour={send:function(e,t){send(e,(function(e){let n=e.getResponseHeader("Service-Response");if(null!=n){let a=JSON.parse(n);t(e,a)}else t(e,void 0)}))},new:function(e){endeavour.send({service:"EndeavourService",command:"new"},e)},join:function(e,t){endeavour.send({service:"EndeavourService",command:"join",documentUUID:e},t)},leave:function(e,t){endeavour.send({service:"EndeavourService",command:"leave",documentUUID:e},t)},save:function(e,t){endeavour.send({service:"EndeavourService",command:"save",documentUUID:e},t)},revert:function(e,t){endeavour.send({service:"EndeavourService",command:"revert",documentUUID:e},t)}};

"""###
private let compressedScriptCombinedJs = Data(base64Encoded:"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")!

public extension EndeavourPamphlet.Private {
    #if DEBUG
    static func ShellFontsHtml() -> String {
        let fileOnDiskPath = "/Users/rjbowli/Development/chimerasw/Endeavour/Resources/private/shell.fonts.html"
        if let contents = try? String(contentsOf:URL(fileURLWithPath: fileOnDiskPath)) {
            if contents.hasPrefix("#define PAMPHLET_PREPROCESSOR") {
                do {
                    let task = Process()
                    task.executableURL = URL(fileURLWithPath: "/opt/homebrew/bin/pamphlet")
                    task.arguments = ["preprocess", fileOnDiskPath]
                    let outputPipe = Pipe()
                    task.standardOutput = outputPipe
                    try task.run()
                    let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
                    let output = String(decoding: outputData, as: UTF8.self)
                    return output
                } catch {
                    return "Failed to use /opt/homebrew/bin/pamphlet to preprocess the requested file"
                }
            }
            return contents
        }
        return String()
    }
    #else
    static func ShellFontsHtml() -> StaticString {
        return uncompressedShellFontsHtml
    }
    #endif
    static func ShellFontsHtmlGzip() -> Data {
        return compressedShellFontsHtml
    }
}

private let uncompressedShellFontsHtml: StaticString = ###"""
<link rel="preload" href="public/fonts/lato.woff2" as="font" type="font/woff2" crossorigin> <link rel="preload" href="public/fonts/roboto.woff2" as="font" type="font/woff2" crossorigin> <style>
    @font-face {
        font-family: 'Lato';
        font-style: normal;
        font-weight: 400;
        font-display: swap;
        src: url(public/fonts/lato.woff2) format('woff2');
        unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
    }
    @font-face {
        font-family: 'Roboto';
        font-style: normal;
        font-weight: 500;
        font-display: swap;
        src: url(public/fonts/roboto.woff2) format('woff2');
        unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
    }
</style>
"""###
private let compressedShellFontsHtml = Data(base64Encoded:"H4sIAAAAAAACA91SXU/DIBR991eQvnSL1lK2zli7xX3Ik08m/gDW0o7IoAGaZjH+dyk0mVtissw378M9PffA6eVCzpn4AIryedDYLEkZgJ2ilaXtlrMirqQwOubEyPtOVhUKANHzoK8GwBwa6r/jQSuU1FoqVjOxAPll3kpu5TXu2hw4XdwAG8/9qqgiBQWfrtDHUNszfshA+GpPED6dis4hA0KqPeFnWkdZvTMZmEJ4ppRMN5xYT92R5qhpVWSgVXz0y+DGdrf9jxmFjobj49ZWsEKWNFJE1Laf91toI4IQ47ueJJPEY4oimyaOoNUqsmntyXrmcbMc0NVRb4PgDHvyMPW49GKCkMfHZEDnjKwwYNojfvFtYIw3vuWvS2f+5m72mqmnf5v6zyf1n+aex/7RfwO/HPn2tgMAAA==")!

