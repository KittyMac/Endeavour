import Foundation
import ArgumentParser
import PicaroonFramework
import Flynn
import Pamphlet

#if DEBUG
let cacheMaxAge = 5
#else
let cacheMaxAge = 3600
#endif

func handleStaticRequest(_ httpRequest: HttpRequest) -> Data? {
    if let url = httpRequest.url {

        var supportsGzip = false
        if let acceptEncoding = httpRequest.acceptEncoding {
            supportsGzip = acceptEncoding.contains("gzip")
        }

        if url.contains("private/") {
            return HttpResponse.asData(nil, .internalServerError, .txt)
        } else {

            // Request for HTML are never satisfied by the static resources
            if url.hasSuffix(".htm") {
                return HttpResponse.asData(nil, .internalServerError, .txt)
            }

            // We only ever allow script.combined.js to be downloaded, and it is a combination of scripts.
            if url.hasSuffix("script.combined.js") {
#if DEBUG
                let script = Pamphlet.Private.ScriptCombinedJs()
                return HttpResponse.asData(nil, .ok, .js, script)
#else
                if supportsGzip {
                    return HttpResponse.asData(nil, .ok, .js, Pamphlet.Private.ScriptCombinedJsGzip(),
                                               encoding: "gzip")
                }
                return HttpResponse.asData(nil, .ok, .js, Pamphlet.Private.ScriptCombinedJs())
#endif
            }

            if let content = Pamphlet.get(gzip: url), supportsGzip {
                return HttpResponse.asData(nil, .ok, HttpContentType.fromPath(url), content,
                                           encoding: "gzip",
                                           cacheMaxAge: cacheMaxAge)
            } else if let content = Pamphlet.get(data: url) {
                return HttpResponse.asData(nil, .ok, HttpContentType.fromPath(url), content,
                                           cacheMaxAge: cacheMaxAge)
            } else if let content = Pamphlet.get(string: url) {
                return HttpResponse.asData(nil, .ok, HttpContentType.fromPath(url), content,
                                           cacheMaxAge: cacheMaxAge)
            }
        }
    }
    return nil
}

public enum PICAROONTEMPLATE {

    public static func http(_ address: String,
                            _ httpPort: Int32) {

        Flynn.startup()

        let config = ServerConfig(address: address,
                                  port: Int(httpPort),
                                  requestTimeout: 30.0,
                                  maxRequestInBytes: 65536)

        Server<WebUserSession>(config: config,
                               staticStorageHandler: handleStaticRequest).run()
    }

}
