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

final class EndeavourTests: XCTestCase {
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
        guard let webserver = webserver else { return XCTFail() }
        guard let ownerWebview = ownerWebview else { return XCTFail() }
        guard let peerWebview = peerWebview else { return XCTFail() }

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
/*
        manager.beNewDocument(session: owner, owner) { documentUUID in
            guard let documentUUID = documentUUID else {
                return XCTFail()
            }

            print(documentUUID)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
 */
    }

    /*
    func testCloseDocumentByOwner() {
        let expectation = XCTestExpectation(description: "success")
        let manager = self.manager
        let owner = self.owner

        manager.beNewDocument(session: owner, owner) { documentUUID in
            guard let documentUUID = documentUUID else {
                return XCTFail()
            }

            manager.beCloseDocument(session: owner, documentUUID: documentUUID, owner) { error in
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 2)
    }

    func testCloseDocumentByPeer() {
        let expectation = XCTestExpectation(description: "success")
        let manager = self.manager
        let owner = self.owner
        let peer = self.peer

        manager.beNewDocument(session: owner, owner) { documentUUID in
            guard let documentUUID = documentUUID else {
                return XCTFail()
            }

            manager.beCloseDocument(session: peer, documentUUID: documentUUID, peer) { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 2)
    }

    func testJoinDocument() {
        let expectation = XCTestExpectation(description: "success")
        let manager = self.manager
        let owner = self.owner
        let peer = self.peer

        manager.beNewDocument(session: owner, owner) { documentUUID in
            guard let documentUUID = documentUUID else {
                return XCTFail()
            }

            peer.handleRequest(<#T##connection: AnyConnection##AnyConnection#>, <#T##httpRequest: HttpRequest##HttpRequest#>)

            manager.beJoinDocument(session: peer, documentUUID: documentUUID, peer) { error in
                guard error == nil else { return XCTFail() }

                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 2)
    }
*/
    static var allTests = [
        ("testEndeavour", testOpenDocument)
    ]
}
