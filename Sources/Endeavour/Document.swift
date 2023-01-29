// swiftlint:disable weak_delegate

import Foundation
import ArgumentParser
import Picaroon
import Flynn
import Hitch
import Spanker

public class DocumentUser {
    var userUUID: UserUUID
    var name: Hitch?
    var clientID: Hitch?
    var peerIdx: Int = -1

    init(userUUID: UserUUID,
         name: Hitch?) {
        self.userUUID = userUUID
        self.name = name
    }

    func info() -> JsonElement {
        return JsonElement(unknown: [
            "clientID": clientID ?? NSNull(),
            "name": name ?? NSNull(),
            "peerIdx": peerIdx
        ])
    }
}

public enum UserAccessMode {
    case none
    case peer
    case observer
}

public struct DocumentInfo {
    public let uuid: DocumentUUID
    public let content: DocumentContent
    public let version: DocumentVersion
    public let canSave: Bool
    public let canRead: Bool
    public let canWrite: Bool

    func jsonElement() -> JsonElement {
        return JsonElement(unknown: [
            "documentUUID": uuid,
            "version": version,
            "canSave": canSave,
            "canRead": canRead,
            "canWrite": canWrite
        ])
    }
}

public protocol Documentable: Actor {
    @discardableResult
    func beSave(documentInfo: DocumentInfo,
                _ sender: Actor,
                _ callback: @escaping ((Error?) -> Void)) -> Self
    @discardableResult
    func beRevert(documentInfo: DocumentInfo,
                  _ sender: Actor,
                  _ callback: @escaping ((DocumentContent?, Error?) -> Void)) -> Self
    @discardableResult
    func beAuthorize(userSession: UserServiceableSession,
                     user: UserUUID,
                     _ sender: Actor,
                     _ callback: @escaping ((UserAccessMode, Hitch?) -> Void)) -> Self
}

extension Endeavour {
    public class Document: Actor {

        private let documentUUID: Hitch

        private var history = [Hitch]()
        private var utf16Document = CodeMirrorDocument()

        private var peerCursors = JsonElement(unknown: [:])

        private var delegate: Documentable?

        private let owner: DocumentUser
        private var peers = [UserUUID: DocumentUser]()
        private var observers = [UserUUID: DocumentUser]()

        private var closed = false

        private var subscribedServices = [Service]()

        public init(owner: UserUUID,
                    content: Hitch?) {
            self.owner = DocumentUser(userUUID: owner,
                                      name: nil)
            documentUUID = UUID().uuidHitch

            if let content = content {
                utf16Document.set(document: content.description)
            }
        }

        public init(owner: UserUUID,
                    named: Hitch?,
                    content: Hitch?) {
            self.owner = DocumentUser(userUUID: owner,
                                      name: nil)
            documentUUID = named ?? UUID().uuidHitch

            if let content = content {
                utf16Document.set(document: content.description)
            }
        }

        private func updateUsers(userUUID: UserUUID,
                                 clientID: Hitch?) {
            // Set the clientID for this user. Also ensure all peers have a unique peerIdx
            if owner.peerIdx < 0 {
                owner.peerIdx = 0
            }
            if owner.userUUID == userUUID {
                owner.clientID = clientID
            } else {
                for peer in peers.values where peer.userUUID == userUUID {
                    peer.clientID = clientID
                    break
                }
            }

            // owner is always 0
            var validPeerIdx = [0, 1, 2, 3, 4, 5, 6, 7]

            validPeerIdx.removeOne(owner.peerIdx)
            for peer in peers.values {
                validPeerIdx.removeOne(peer.peerIdx)
            }

            for peer in peers.values where peer.peerIdx < 0 {
                if let peerIdx = validPeerIdx.randomElement() {
                    peer.peerIdx = peerIdx
                    validPeerIdx.removeOne(peerIdx)
                }
            }
        }

        private func peersInfo() -> JsonElement {
            let peersInfo = JsonElement(unknown: [])
            for other in peers.values {
                peersInfo.append(value: other.info())
            }

            peersInfo.append(value: owner.info())

            return peersInfo
        }

        private func broadcastPeers() {
            let json = JsonElement(unknown: [
                "peers": peersInfo(),
                "cursors": peerCursors.values
            ]).toHitch()
            for service in subscribedServices {
                service.beDocumentDidUpdateCursors(documentUUID: documentUUID,
                                                   cursorsJson: json)
            }
        }

        internal func _beSetDelegate(userSession: UserServiceableSession,
                                     delegate: Documentable) {
            self.delegate = delegate

            delegate.beAuthorize(userSession: userSession,
                                 user: owner.userUUID,
                                 self) { _, userName in
                self.owner.name = userName
            }
        }

        internal func _beSetDelegate(ownerName: Hitch?,
                                     delegate: Documentable) {
            self.delegate = delegate
            self.owner.name = ownerName
        }

        private func getDocumentInfo(user: UserUUID) -> DocumentInfo {
            return DocumentInfo(uuid: documentUUID,
                                content: utf16Document.hitch(),
                                version: history.count,
                                canSave: delegate != nil && canWrite(user: user),
                                canRead: canRead(user: user),
                                canWrite: canWrite(user: user))
        }

        private func canRead(user: UserUUID) -> Bool {
            return owner.userUUID == user || peers[user] != nil
        }

        private func canWrite(user: UserUUID) -> Bool {
            return owner.userUUID == user || peers[user] != nil
        }

        internal func _beAdd(userSession: UserServiceableSession,
                             user: UserUUID,
                             _ returnCallback: @escaping (DocumentInfo?, Endeavour.Document?, Error?) -> Void) {
            guard closed == false else { return returnCallback(nil, nil, "document is closed") }

            observers[user] = nil
            peers[user] = nil

            if user != owner.userUUID {
                if let delegate = delegate {
                    delegate.beAuthorize(userSession: userSession,
                                         user: user,
                                         self) { accessMode, userName in
                        switch accessMode {
                        case .observer:
                            self.observers[user] = DocumentUser(userUUID: user, name: userName)
                            break
                        case .peer:
                            self.peers[user] = DocumentUser(userUUID: user, name: userName)
                            break
                        default:
                            return returnCallback(nil, nil, "You are not authorized to access this document")
                        }
                        returnCallback(self.getDocumentInfo(user: user), self, nil)

                        self.broadcastPeers()
                        return
                    }
                    return
                } else {
                    self.peers[user] = DocumentUser(userUUID: user, name: nil)
                }
            }
            returnCallback(getDocumentInfo(user: user), self, nil)

            broadcastPeers()
        }

        internal func _beLeave(user: UserUUID,
                               service: Endeavour.Service) -> (Bool, Error?) {

            observers[user] = nil
            peers[user] = nil
            peerCursors.remove(key: user.halfhitch())

            subscribedServices.removeAll(service)

            if owner.userUUID == user {
                closed = true

                peers.removeAll()
                observers.removeAll()

                for service in subscribedServices {
                    service.beDocumentDidClose(documentUUID: documentUUID)
                }

                subscribedServices.removeAll()
                self.broadcastPeers()

                return (true, nil)
            }
            return (false, nil)
        }

        internal func _beAuthorize(peer: UserUUID) -> Error? {
            guard closed == false else { return "document is closed" }
            guard peers[peer] != nil else { return "You are not authorized as a peer of this document" }
            return nil
        }

        internal func _beAuthorize(owner: UserUUID) -> Error? {
            guard closed == false else { return "document is closed" }
            guard self.owner.userUUID == owner else { return "You are not authorized as an owner of this document" }
            return nil
        }

        internal func _beGetInfo(user: UserUUID,
                                _ returnCallback: (DocumentInfo?, Error?) -> Void) {
            guard closed == false else { return returnCallback(nil, "document is closed") }
            guard canRead(user: user) else { return returnCallback(nil, "You are not authorized to access this document") }
            returnCallback(getDocumentInfo(user: user), nil)
        }

        internal func _bePublish(peer: UserUUID,
                                 clientID: Hitch?,
                                 version: Int,
                                 updates: JsonElement?,
                                 cursors: JsonElement?) -> Error? {
            guard closed == false else { return "document is closed" }
            guard owner.userUUID == peer || peers[peer] != nil else { return "You are not authorized as a peer of this document" }

            updateUsers(userUUID: peer,
                        clientID: clientID)

            if let updates = updates {
                guard version == history.count else {
                    return "Version mismatch ({0} != {1})" << [version, history.count]
                    //return nil
                }
                for update in updates.iterValues {
                    utf16Document.apply(changeSet: update)
                    history.append(update.toHitch())
                }
                for service in subscribedServices {
                    service.beDocumentDidUpdate(document: self,
                                                documentUUID: documentUUID,
                                                documentVersion: history.count)
                }
            }

            if let cursors = cursors {
                peerCursors.set(key: peer.halfhitch(),
                                value: cursors)
                broadcastPeers()
            }

            return nil
        }

        internal func _beSave(peer: UserUUID,
                              version: Int,
                              _ returnCallback: @escaping ((Error?) -> Void)) {
            guard closed == false else { return returnCallback("document is closed") }
            guard owner.userUUID == peer || peers[peer] != nil else { return returnCallback("You are not authorized as a peer of this document") }
            guard version == history.count else {
                return returnCallback("Version mismatch ({0} != {1})" << [version, history.count])
            }
            guard let delegate = delegate else {
                return returnCallback("Document does not support persistent storage")
            }

            // "save" the document by:
            // 1. tell some other thing that the document wants to be saved
            // 2. other thing persists the document, returns nil on success and error if not
            delegate.beSave(documentInfo: getDocumentInfo(user: peer), self) { error in
                if let error = error {
                    return returnCallback(error)
                }

                // 3. clear the update history
                self.history.removeAll()

                // 4. tell all clients something changed
                for service in self.subscribedServices {
                    service.beDocumentDidSave(document: self,
                                              documentInfo: self.getDocumentInfo(user: peer))
                }
                returnCallback(nil)
            }
        }

        internal func _beRevert(peer: UserUUID,
                                version: Int,
                                _ returnCallback: @escaping ((Error?) -> Void)) {
            guard closed == false else { return returnCallback("document is closed") }
            guard owner.userUUID == peer || peers[peer] != nil else { return returnCallback("You are not authorized as a peer of this document") }
            guard version == history.count else {
                return returnCallback("Version mismatch ({0} != {1})" << [version, history.count])
            }
            guard let delegate = delegate else {
                return returnCallback("Document does not support persistent storage")
            }

            // all the delegate to reset the content of the document
            delegate.beRevert(documentInfo: getDocumentInfo(user: peer), self) { content, error in
                guard let content = content else {
                    return returnCallback("Reverted content was nil")
                }
                if let error = error {
                    return returnCallback(error)
                }

                self.utf16Document.set(document: content.description)

                // 3. clear the update history
                self.history.removeAll()

                // 4. tell all clients something changed
                for service in self.subscribedServices {
                    service.beDocumentDidSave(document: self,
                                              documentInfo: self.getDocumentInfo(user: peer))
                }

                return returnCallback(nil)
            }
        }

        internal func _beSubscribe(peer: UserUUID,
                                   service: Endeavour.Service) {
            guard closed == false else { return }
            guard owner.userUUID == peer || peers[peer] != nil else {
               return
            }

            subscribedServices.removeAll(service)
            subscribedServices.append(service)

            service.beDocumentDidUpdate(document: self,
                                        documentUUID: documentUUID,
                                        documentVersion: history.count)

            self.broadcastPeers()
        }

        internal func _beGetUpdates(peer: UserUUID,
                                    version: DocumentVersion) -> HalfHitch? {
            guard closed == false else { return nil }
            guard owner.userUUID == peer || peers[peer] != nil else {
               return nil
            }

            if version < history.count {
                let combined = Hitch(capacity: 1024)
                combined.append(.openBrace)
                for idx in version..<history.count {
                    let part = history[idx]
                    combined.append(part)
                    combined.append(.comma)
                }
                if combined.count > 1 {
                    combined.count = combined.count - 1
                }
                combined.append(.closeBrace)

                return combined.halfhitch()
            }

            return nil
        }
    }
}
