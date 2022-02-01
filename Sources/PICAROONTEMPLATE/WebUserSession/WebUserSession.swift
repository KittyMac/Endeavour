import Flynn
import Foundation
import Socket
import PicaroonFramework
import Pamphlet
import Hitch
import Sextant

struct QueryRequest: Codable {
    let json: String
    let path: String
}

public class WebUserSession: UserSession {

    private var supportsGzip: Bool = false
    private var queryLimiter: Date = Date(timeIntervalSinceNow: -1)

    public required init() {
        super.init()
        unsafePriority = 99
    }

    required init(cookieSessionUUID: String?, javascriptSessionUUID: String?) {
        super.init(cookieSessionUUID: cookieSessionUUID, javascriptSessionUUID: javascriptSessionUUID)
        unsafePriority = 99
    }

    public override func safeHandleRequest(_ connection: AnyConnection,
                                           _ httpRequest: HttpRequest) {

        if let content = httpRequest.content,
           httpRequest.method == .POST {
            if let request: QueryRequest = try? content.decoded() {

                if abs(queryLimiter.timeIntervalSinceNow) < 0.5 {
                    connection.beSendNotModified()
                    return
                }

                queryLimiter = Date()

                let paths: [String] = request.path.split(separator: "\n").map { String($0) }

                let resultJson: String? = request.json.parsed { root in
                    guard let root = root else { return nil }
                    guard let results = root.query(values: paths) else { return nil }
                    guard let resultsData = try? JSONSerialization.data(withJSONObject: results, options: [.sortedKeys]) else { return nil }
                    return String(data: resultsData, encoding: .utf8)
                }

                if let resultJson = resultJson {
                    connection.beSendData(HttpResponse.asData(self, .ok, .json, resultJson))
                } else {
                    connection.beSendData(HttpResponse.asData(self, .ok, .json, ""))
                }

                return
            }
        }

#if !DEBUG
        if let acceptEncoding = httpRequest.acceptEncoding {
            supportsGzip = acceptEncoding.contains("gzip")
        }
#endif

        if supportsGzip {
            let response = HttpResponse.asData(self, .ok, .html, Pamphlet.Private.ShellHtmlGzip(),
                                               headers: ["Set-Cookie: SESSION_UUID=\(unsafeJavascriptSessionUUID)"],
                                               encoding: "gzip")
            connection.beSendData(response)
            return
        } else {
            let response = HttpResponse.asData(self, .ok, .html, Pamphlet.Private.ShellHtml(),
                                               headers: ["Set-Cookie: SESSION_UUID=\(unsafeJavascriptSessionUUID)"])
            connection.beSendData(response)
            return
        }

        connection.beSendInternalError()
    }

    private func handleMessage(_ connection: AnyConnection,
                               _ httpRequest: HttpRequest,
                               _ content: Data) {
        print("**** UNHANDLED MESSAGE - SENDING 503 ERROR ****\n(httpRequest)")
        connection.beSendServiceUnavailable()
    }
}
