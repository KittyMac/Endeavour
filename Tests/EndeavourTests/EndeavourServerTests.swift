import XCTest
import Flynn
import Endeavour
import Sextant
import Picaroon
import Hitch

@testable import Endeavour

public class TestingUserSession: UserServiceableSession {

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

        let headers: [HalfHitch] = [HalfHitch(string: "Set-Cookie: SESSION_UUID=\(unsafeJavascriptSessionUUID)")]

        connection.beSend(httpResponse: HttpResponse(html: "<html></html>",
                                                     headers: headers))
    }
}

final class EndeavourServerTests: XCTestCase {
    var webserver: PicaroonTesting.WebServer<TestingUserSession>?
    var ownerWebview: PicaroonTesting.WebView<UserSession>?
    var peerWebview: PicaroonTesting.WebView<UserSession>?
    var baseUrl = ""

    override func setUp() {
        let port = Int.random(in: 8000..<65500)
        webserver = PicaroonTesting.WebServer(port: port)
        ownerWebview = PicaroonTesting.WebView()
        peerWebview = PicaroonTesting.WebView()
        baseUrl = "http://127.0.0.1:\(port)/"
    }

    func testOpenDocument() {
        guard let _ = webserver else { return XCTFail() }
        guard let ownerWebview = ownerWebview else { return XCTFail() }
        guard let _ = peerWebview else { return XCTFail() }

        let expectation = XCTestExpectation(description: "success")

        ownerWebview.load(url: baseUrl) { _, _, error in
            XCTAssertNil(error)

            ownerWebview.ajax(payload: #"{"service":"EndeavourService","command":"new"}"#) { data, response, error in
                XCTAssertNil(error)
                XCTAssertNotNil(response)
                XCTAssertNotNil(data)

                guard let serviceResponseJson = response?.value(forHTTPHeaderField: "Service-Response") else {
                    return XCTFail()
                }

                serviceResponseJson.parsed { root in
                    guard let root = root else {
                        XCTFail(); return
                    }

                    if let documentUUID = root[string: "documentUUID"] {
                        print(documentUUID)
                        expectation.fulfill()
                    }
                }

            }
        }

        wait(for: [expectation], timeout: 2)
    }
}

extension EndeavourServerTests {
    static var allTests: [(String, (EndeavourServerTests) -> () throws -> Void)] {
        return [
            // ("testOpenDocument", testOpenDocument)
        ]
    }
}
