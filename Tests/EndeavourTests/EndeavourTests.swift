import XCTest
import Flynn
import Endeavour
import Sextant
import Picaroon
import Hitch
import Spanker

@testable import Endeavour

final class EndeavourTests: XCTestCase {

    func testJoinGlobalDocument() {
        let ownerUUID = UUID().uuidHitch
        let peerUUID = UUID().uuidHitch
        let documentUUID: Hitch = "SwiftSample"
        Endeavour.shared.beNewDocument(userUUID: ownerUUID,
                                       named: documentUUID,
                                       content: #"print("hello world")"#,
                                       Flynn.any) { documentInfo, document, error in
            guard let documentInfo = documentInfo,
                  let _ = document else {
                fatalError(error?.description ?? "failed to create \(documentUUID)")
            }

            // document.beSetPersistableDocument(persistableDocument: PersistDocument())

            Endeavour.shared.beJoinDocument(userUUID: peerUUID,
                                            documentUUID: documentInfo.uuid,
                                            Flynn.any) { documentInfo, document, error in
                guard let documentInfo = documentInfo,
                      let document = document else {
                    fatalError(error?.description ?? "failed to join \(documentUUID)")
                }

                print(documentInfo)
                print(document)
            }
        }
    }
}

extension EndeavourTests {
    static var allTests: [(String, (EndeavourTests) -> () throws -> Void)] {
        return [
            ("testJoinGlobalDocument", testJoinGlobalDocument)
        ]
    }
}
