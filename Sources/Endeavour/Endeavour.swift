import Foundation
import ArgumentParser
import Picaroon
import Flynn
import Hitch
import Spanker

public typealias DocumentUUID = Hitch
public typealias DocumentContent = Hitch
public typealias DocumentVersion = Int

public typealias UserUUID = Hitch
public typealias Error = HalfHitch

public class Endeavour: Actor {
    public static let shared = Endeavour()
    override private init() {}

    private var documents: [DocumentUUID: Document] = [:]

    internal func _beNewDocument(userUUID: UserUUID,
                                 content: Hitch?,
                                 _ returnCallback: @escaping (DocumentInfo?, Document?, Error?) -> Void) {
        let document = Document(owner: userUUID,
                                content: content)
        document.beGetInfo(user: userUUID, self) { documentInfo, error in
            guard error == nil else { return returnCallback(nil, nil, error) }
            guard let documentInfo = documentInfo else { return returnCallback(nil, nil, "document info is missing") }
            self.documents[documentInfo.uuid] = document
            returnCallback(documentInfo, document, nil)
        }
    }

    internal func _beNewDocument(userUUID: UserUUID,
                                 named: Hitch?,
                                 content: Hitch?,
                                 _ returnCallback: @escaping (DocumentInfo?, Document?, Error?) -> Void) {
        let document = Document(owner: userUUID,
                                named: named,
                                content: content)
        document.beGetInfo(user: userUUID, self) { documentInfo, error in
            guard error == nil else { return returnCallback(nil, nil, error) }
            guard let documentInfo = documentInfo else { return returnCallback(nil, nil, "document info is missing") }
            self.documents[documentInfo.uuid] = document
            returnCallback(documentInfo, document, nil)
        }
    }

    internal func _beJoinDocument(userSession: UserServiceableSession,
                                  userUUID: UserUUID,
                                  documentUUID: DocumentUUID,
                                  _ returnCallback: @escaping (DocumentInfo?, Document?, Error?) -> Void) {
        guard let document = documents[documentUUID] else {
            return returnCallback(nil, nil, "The document does not exist")
        }
        document.beAdd(userSession: userSession,
                       user: userUUID,
                       self,
                       returnCallback)
    }

    internal func _beLeaveDocument(userUUID: UserUUID,
                                   service: Service,
                                   documentUUID: DocumentUUID,
                                   _ returnCallback: @escaping (Error?) -> Void) {
        guard let document = documents[documentUUID] else {
            return returnCallback("The document does not exist")
        }

        document.beLeave(user: userUUID,
                         service: service,
                         self) { closed, error in
            if closed {
                self.documents[documentUUID] = nil
            }
            returnCallback(error)
        }
    }
}
