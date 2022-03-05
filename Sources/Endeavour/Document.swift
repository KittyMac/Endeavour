import Foundation
import ArgumentParser
import Picaroon
import Flynn
import Hitch
import Spanker

public enum AccessMode {
    case closed
    case `public`
    case `private`
}

public struct DocumentInfo {
    public let uuid: DocumentUUID
    public let content: DocumentContent
    public let version: DocumentVersion
}

public protocol PersistableDocument {
    func save(documentInfo: DocumentInfo) -> Error?
}

extension Endeavour {
    public class Document: Actor {

        private let documentUUID: Hitch

        private var history = [Hitch]()

        private var utf16Document = CodeMirrorDocument()

        private var persistableDocument: PersistableDocument?

        private let owner: UserUUID
        private var peers: [UserUUID] = []
        private var waitings: [UserUUID] = []

        private var accessMode = AccessMode.public

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

        private func getDocumentInfo() -> DocumentInfo {
            return DocumentInfo(uuid: documentUUID,
                                content: utf16Document.hitch(),
                                version: history.count)
        }

        private func canAdd(user: UserUUID) -> Bool {
            return owner != user && peers.contains(user) == false && waitings.contains(user) == false
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

        private func _beAdd(peer: UserUUID,
                            _ returnCallback: @escaping (DocumentInfo?, Endeavour.Document?, Error?) -> Void) {
            guard accessMode != .closed else { return returnCallback(nil, nil, "document is closed") }
            guard canAdd(user: peer) else {
                return returnCallback(nil, nil, "You are already a peer of this document")
            }
            peers.append(peer)
            returnCallback(getDocumentInfo(), self, nil)
        }

        private func _beAdd(waiting: UserUUID,
                            _ returnCallback: @escaping (DocumentInfo?, Endeavour.Document?, Error?) -> Void) {
            guard accessMode != .closed else { return returnCallback(nil, nil, "document is closed") }
            guard accessMode == .private else {
                // public documents have no waiting list, you can join as a peer immediately
                return _beAdd(peer: waiting, returnCallback)
            }
            guard canAdd(user: waiting) else {
                return returnCallback(nil, nil, "You are already waiting to join this document")
            }
            waitings.append(waiting)
            returnCallback(getDocumentInfo(), self, nil)
        }

        private func _beLeave(user: UserUUID,
                              service: Endeavour.Service) -> (Bool, Error?) {

            waitings.removeOne(user)
            peers.removeOne(user)

            subscribedServices.removeAll(service)

            if owner == user {
                accessMode = .closed

                peers.removeAll()
                waitings.removeAll()

                for service in subscribedServices {
                    service.beDocumentDidClose(documentUUID: documentUUID)
                }

                subscribedServices.removeAll()

                return (true, nil)
            }
            return (false, nil)
        }

        private func _beAuthorize(peer: UserUUID) -> Error? {
            guard accessMode != .closed else { return "document is closed" }
            guard peers.contains(peer) else { return "You are not authorized as a peer of this document" }
            return nil
        }

        private func _beAuthorize(owner: UserUUID) -> Error? {
            guard accessMode != .closed else { return "document is closed" }
            guard self.owner == owner else { return "You are not authorized as an owner of this document" }
            return nil
        }

        private func _beGetInfo(user: UserUUID,
                                _ returnCallback: (DocumentInfo?, Error?) -> Void) {
            guard accessMode != .closed else { return returnCallback(nil, "document is closed") }
            guard canRead(user: user) else { return returnCallback(nil, "You are not authorized to access this document") }
            returnCallback(getDocumentInfo(), nil)
        }

        private func _bePublish(peer: UserUUID,
                                version: Int,
                                updates: JsonElement) -> Error? {
            guard accessMode != .closed else { return "document is closed" }
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
            guard accessMode != .closed else { return "document is closed" }
            guard owner == peer || peers.contains(peer) else { return "You are not authorized as a peer of this document" }
            guard version == history.count else {
                return "Version mismatch ({0} != {1})" << [version, history.count]
            }
            guard let persistableDocument = persistableDocument else {
                return "Document does not support saving"
            }

            // "save" the document by:
            // 1. tell some other thing that the document wants to be saved
            // 2. other thing persists the document, returns nil on success and error if not
            if let error = persistableDocument.save(documentInfo: getDocumentInfo()) {
                return error
            }

            // 3. clear the update history
            history.removeAll()

            // 4. tell all clients something changed
            for service in subscribedServices {
                service.beDocumentDidSave(document: self,
                                          documentInfo: getDocumentInfo())
            }

            return nil
        }

        private func _beSubscribe(peer: UserUUID,
                                  service: Endeavour.Service) {
            guard accessMode != .closed else { return }
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
            guard accessMode != .closed else { return nil }
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
    public func beAdd(peer: UserUUID,
                      _ sender: Actor,
                      _ callback: @escaping ((DocumentInfo?, Endeavour.Document?, Error?) -> Void)) -> Self {
        unsafeSend {
            self._beAdd(peer: peer) { arg0, arg1, arg2 in
                sender.unsafeSend {
                    callback(arg0, arg1, arg2)
                }
            }
        }
        return self
    }
    @discardableResult
    public func beAdd(waiting: UserUUID,
                      _ sender: Actor,
                      _ callback: @escaping ((DocumentInfo?, Endeavour.Document?, Error?) -> Void)) -> Self {
        unsafeSend {
            self._beAdd(waiting: waiting) { arg0, arg1, arg2 in
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
