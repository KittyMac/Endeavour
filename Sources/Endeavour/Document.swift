import Foundation
import ArgumentParser
import Picaroon
import Flynn
import Hitch
import Spanker

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

public protocol PersistableDocument {
    func save(documentInfo: DocumentInfo) -> Error?
    func revert(content: inout Hitch, documentInfo: DocumentInfo) -> Error?
}

public protocol AuthorizableDocument {
    func authorized(observer: UserUUID) -> UserAccessMode
}

extension Endeavour {
    public class Document: Actor {

        private let documentUUID: Hitch

        private var history = [Hitch]()

        private var utf16Document = CodeMirrorDocument()

        private var persistableDocument: PersistableDocument?
        private var authorizableDocument: AuthorizableDocument?

        private let owner: UserUUID
        private var peers = Set<UserUUID>()
        private var observers = Set<UserUUID>()

        private var closed = false

        private var subscribedServices = [Service]()

        public init(owner: UserUUID,
                    content: Hitch?) {
            self.owner = owner
            documentUUID = UUID().uuidHitch

            if let content = content {
                utf16Document.set(document: content.description)
            }
        }

        public init(owner: UserUUID,
                    named: Hitch?,
                    content: Hitch?) {
            self.owner = owner
            documentUUID = named ?? UUID().uuidHitch

            if let content = content {
                utf16Document.set(document: content.description)
            }
        }

        private func getDocumentInfo(user: UserUUID) -> DocumentInfo {
            return DocumentInfo(uuid: documentUUID,
                                content: utf16Document.hitch(),
                                version: history.count,
                                canSave: persistableDocument != nil && canWrite(user: user),
                                canRead: canRead(user: user),
                                canWrite: canWrite(user: user))
        }

        private func canRead(user: UserUUID) -> Bool {
            return owner == user || peers.contains(user)
        }

        private func canWrite(user: UserUUID) -> Bool {
            return owner == user || peers.contains(user)
        }

        private func _beSetPersistableDocument(persistableDocument: PersistableDocument) {
            self.persistableDocument = persistableDocument
        }

        private func _beSetAuthorizableDocument(authorizableDocument: AuthorizableDocument) {
            self.authorizableDocument = authorizableDocument
        }

        private func _beAdd(user: UserUUID,
                            _ returnCallback: @escaping (DocumentInfo?, Endeavour.Document?, Error?) -> Void) {
            guard closed == false else { return returnCallback(nil, nil, "document is closed") }
            if user != owner {
                if let authorizableDocument = authorizableDocument {
                    switch authorizableDocument.authorized(observer: user) {
                    case .observer:
                        observers.insert(user)
                        break
                    case .peer:
                        peers.insert(user)
                        break
                    default:
                        return returnCallback(nil, nil, "You are not authorized to access this document")
                    }
                } else {
                    peers.insert(user)
                }
            }
            returnCallback(getDocumentInfo(user: user), self, nil)
        }

        private func _beLeave(user: UserUUID,
                              service: Endeavour.Service) -> (Bool, Error?) {

            observers.remove(user)
            peers.remove(user)

            subscribedServices.removeAll(service)

            if owner == user {
                closed = true

                peers.removeAll()
                observers.removeAll()

                for service in subscribedServices {
                    service.beDocumentDidClose(documentUUID: documentUUID)
                }

                subscribedServices.removeAll()

                return (true, nil)
            }
            return (false, nil)
        }

        private func _beAuthorize(peer: UserUUID) -> Error? {
            guard closed == false else { return "document is closed" }
            guard peers.contains(peer) else { return "You are not authorized as a peer of this document" }
            return nil
        }

        private func _beAuthorize(owner: UserUUID) -> Error? {
            guard closed == false else { return "document is closed" }
            guard self.owner == owner else { return "You are not authorized as an owner of this document" }
            return nil
        }

        private func _beGetInfo(user: UserUUID,
                                _ returnCallback: (DocumentInfo?, Error?) -> Void) {
            guard closed == false else { return returnCallback(nil, "document is closed") }
            guard canRead(user: user) else { return returnCallback(nil, "You are not authorized to access this document") }
            returnCallback(getDocumentInfo(user: user), nil)
        }

        private func _bePublish(peer: UserUUID,
                                version: Int,
                                updates: JsonElement) -> Error? {
            guard closed == false else { return "document is closed" }
            guard owner == peer || peers.contains(peer) else { return "You are not authorized as a peer of this document" }
            guard version == history.count else {
                return "Version mismatch ({0} != {1})" << [version, history.count]
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

            return nil
        }

        private func _beSave(peer: UserUUID,
                             version: Int) -> Error? {
            guard closed == false else { return "document is closed" }
            guard owner == peer || peers.contains(peer) else { return "You are not authorized as a peer of this document" }
            guard version == history.count else {
                return "Version mismatch ({0} != {1})" << [version, history.count]
            }
            guard let persistableDocument = persistableDocument else {
                return "Document does not support persistent storage"
            }

            // "save" the document by:
            // 1. tell some other thing that the document wants to be saved
            // 2. other thing persists the document, returns nil on success and error if not
            if let error = persistableDocument.save(documentInfo: getDocumentInfo(user: peer)) {
                return error
            }

            // 3. clear the update history
            history.removeAll()

            // 4. tell all clients something changed
            for service in subscribedServices {
                service.beDocumentDidSave(document: self,
                                          documentInfo: getDocumentInfo(user: peer))
            }

            return nil
        }

        private func _beRevert(peer: UserUUID,
                               version: Int) -> Error? {
            guard closed == false else { return "document is closed" }
            guard owner == peer || peers.contains(peer) else { return "You are not authorized as a peer of this document" }
            guard version == history.count else {
                return "Version mismatch ({0} != {1})" << [version, history.count]
            }
            guard let persistableDocument = persistableDocument else {
                return "Document does not support persistent storage"
            }

            // all the delegate to reset the content of the document
            var content = utf16Document.hitch()
            if let error = persistableDocument.revert(content: &content,
                                                      documentInfo: getDocumentInfo(user: peer)) {
                return error
            }

            utf16Document.set(document: content.description)

            // 3. clear the update history
            history.removeAll()

            // 4. tell all clients something changed
            for service in subscribedServices {
                service.beDocumentDidSave(document: self,
                                          documentInfo: getDocumentInfo(user: peer))
            }

            return nil
        }

        private func _beSubscribe(peer: UserUUID,
                                  service: Endeavour.Service) {
            guard closed == false else { return }
            guard owner == peer || peers.contains(peer) else {
               return
            }

            subscribedServices.removeAll(service)
            subscribedServices.append(service)

            service.beDocumentDidUpdate(document: self,
                                        documentUUID: documentUUID,
                                        documentVersion: history.count)
        }

        private func _beGetUpdates(peer: UserUUID,
                                   version: DocumentVersion) -> HalfHitch? {
            guard closed == false else { return nil }
            guard owner == peer || peers.contains(peer) else {
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

// MARK: - Autogenerated by FlynnLint
// Contents of file after this marker will be overwritten as needed

extension Endeavour.Document {

    @discardableResult
    public func beSetPersistableDocument(persistableDocument: PersistableDocument) -> Self {
        unsafeSend { self._beSetPersistableDocument(persistableDocument: persistableDocument) }
        return self
    }
    @discardableResult
    public func beSetAuthorizableDocument(authorizableDocument: AuthorizableDocument) -> Self {
        unsafeSend { self._beSetAuthorizableDocument(authorizableDocument: authorizableDocument) }
        return self
    }
    @discardableResult
    public func beAdd(user: UserUUID,
                      _ sender: Actor,
                      _ callback: @escaping ((DocumentInfo?, Endeavour.Document?, Error?) -> Void)) -> Self {
        unsafeSend {
            self._beAdd(user: user) { arg0, arg1, arg2 in
                sender.unsafeSend {
                    callback(arg0, arg1, arg2)
                }
            }
        }
        return self
    }
    @discardableResult
    public func beLeave(user: UserUUID,
                        service: Endeavour.Service,
                        _ sender: Actor,
                        _ callback: @escaping (((Bool, Error?)) -> Void)) -> Self {
        unsafeSend {
            let result = self._beLeave(user: user, service: service)
            sender.unsafeSend { callback(result) }
        }
        return self
    }
    @discardableResult
    public func beAuthorize(peer: UserUUID,
                            _ sender: Actor,
                            _ callback: @escaping ((Error?) -> Void)) -> Self {
        unsafeSend {
            let result = self._beAuthorize(peer: peer)
            sender.unsafeSend { callback(result) }
        }
        return self
    }
    @discardableResult
    public func beAuthorize(owner: UserUUID,
                            _ sender: Actor,
                            _ callback: @escaping ((Error?) -> Void)) -> Self {
        unsafeSend {
            let result = self._beAuthorize(owner: owner)
            sender.unsafeSend { callback(result) }
        }
        return self
    }
    @discardableResult
    public func beGetInfo(user: UserUUID,
                          _ sender: Actor,
                          _ callback: @escaping ((DocumentInfo?, Error?) -> Void)) -> Self {
        unsafeSend {
            self._beGetInfo(user: user) { arg0, arg1 in
                sender.unsafeSend {
                    callback(arg0, arg1)
                }
            }
        }
        return self
    }
    @discardableResult
    public func bePublish(peer: UserUUID,
                          version: Int,
                          updates: JsonElement,
                          _ sender: Actor,
                          _ callback: @escaping ((Error?) -> Void)) -> Self {
        unsafeSend {
            let result = self._bePublish(peer: peer, version: version, updates: updates)
            sender.unsafeSend { callback(result) }
        }
        return self
    }
    @discardableResult
    public func beSave(peer: UserUUID,
                       version: Int,
                       _ sender: Actor,
                       _ callback: @escaping ((Error?) -> Void)) -> Self {
        unsafeSend {
            let result = self._beSave(peer: peer, version: version)
            sender.unsafeSend { callback(result) }
        }
        return self
    }
    @discardableResult
    public func beRevert(peer: UserUUID,
                         version: Int,
                         _ sender: Actor,
                         _ callback: @escaping ((Error?) -> Void)) -> Self {
        unsafeSend {
            let result = self._beRevert(peer: peer, version: version)
            sender.unsafeSend { callback(result) }
        }
        return self
    }
    @discardableResult
    public func beSubscribe(peer: UserUUID,
                            service: Endeavour.Service) -> Self {
        unsafeSend { self._beSubscribe(peer: peer, service: service) }
        return self
    }
    @discardableResult
    public func beGetUpdates(peer: UserUUID,
                             version: DocumentVersion,
                             _ sender: Actor,
                             _ callback: @escaping ((HalfHitch?) -> Void)) -> Self {
        unsafeSend {
            let result = self._beGetUpdates(peer: peer, version: version)
            sender.unsafeSend { callback(result) }
        }
        return self
    }

}

extension Endeavour {

}
