import XCTest
import Flynn
import Endeavour
import Picaroon
import Hitch
import Spanker

@testable import Endeavour

struct FakeConnection: AnyConnection {
    func beSetTimeout(_ timeout: TimeInterval) -> Self {
        return self
    }
    func beSend(httpResponse: HttpResponse) -> Self {
        return self
    }
    func beSendIfModified(httpRequest: HttpRequest,
                          httpResponse: HttpResponse) -> Self {
        return self
    }
    func beEndUserSession() -> Self {
        return self
    }
    func beSendInternalError() -> Self {
        return self
    }
    func beSendServiceUnavailable() -> Self {
        return self
    }
    func beSendSuccess(_ message: Hitch) -> Self {
        return self
    }
    func beSendError(_ error: Hitch) -> Self {
        return self
    }
    func beSendNotModified() -> Self {
        return self
    }
}

private class WebUserSession: UserServiceableSession {

    public required init() {
        super.init()
        unsafePriority = 99

        beAdd(service: Endeavour.Service())
    }

    required init(cookieSessionUUID: Hitch?, javascriptSessionUUID: Hitch?) {
        super.init(cookieSessionUUID: cookieSessionUUID, javascriptSessionUUID: javascriptSessionUUID)
        unsafePriority = 99

        beAdd(service: Endeavour.Service())
    }

    public override func safeHandleRequest(connection: AnyConnection,
                                           httpRequest: HttpRequest) {

        let headers: [HalfHitch] = ["Set-Cookie: SESSION_UUID={0}" << [unsafeJavascriptSessionUUID]]

        let payload: Payloadable = "<html></html>"

        connection.beSend(httpResponse: HttpResponse(html: payload,
                                                     headers: headers))
    }
}

final class EndeavourAppTests: XCTestCase {

    private let config = ServerConfig(address: "127.0.0.1", port: 8080)

    private func makeRequest(json: String) -> HttpRequest {
        let raw = """
        POST / HTTP/1.1\r
        Accept: */*\r
        Content-Type: application/json\r
        Content-Length: 45\r
        \r
        {0}
        """ << [json]

        if let rawPtr = raw.raw(),
           let request = HttpRequest(config: config,
                                     request: rawPtr,
                                     size: raw.count) {
            return request
        }
        fatalError()
    }

    func testEndeavourApp() {
        let session = WebUserSession()
        let connection = FakeConnection()
        session.beHandleRequest(connection: connection,
                                httpRequest: makeRequest(json: #"{"service":"EndeavourService","command":"new"}"#))

    }

    static var allTests = [
        ("testEndeavourApp", testEndeavourApp)
    ]
}
