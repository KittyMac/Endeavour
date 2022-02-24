import Foundation
import ArgumentParser
import Picaroon
import Flynn
import Hitch
import Spanker

public enum AccessMode {
    case `public`
    case `private`
}

public struct DocumentInfo {
    let uuid: DocumentUUID
    let content: DocumentContent
    let version: DocumentVersion
}

extension Endeavour {
    public class Document: Actor {

        private let documentUUID: Hitch

        private var history = [Hitch]()
        private let baseDocument: DocumentContent

        private let owner: UserUUID
        private var peers: [UserUUID] = []
        private var waitings: [UserUUID] = []

        private var accessMode = AccessMode.public

        private var subscribedServices = [Service]()

        // TODO: USERS SHOULD "LEAVE" A DOCUMENT NOT "CLOSE" A DOCUMENT
        // TODO: DOCUMENT IS "CLOSED" WHEN THE OWNER LEAVES THE DOCUMENT

        public init(owner: UserUUID,
                    content: Hitch?) {
            self.owner = owner
            documentUUID = UUID().uuidHitch
            baseDocument = content ?? ""
        }

        public init(owner: UserUUID,
                    named: Hitch?,
                    content: Hitch?) {
            self.owner = owner
            documentUUID = named ?? UUID().uuidHitch
            baseDocument = content ?? ""
        }

        private func getDocumentInfo() -> DocumentInfo {
            return DocumentInfo(uuid: documentUUID,
                                content: baseDocument,
                                version: 0)
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

        private func _beAdd(peer: UserUUID,
                            _ returnCallback: @escaping (DocumentInfo?, Error?) -> Void) {
            if canAdd(user: peer) {
                peers.append(peer)
            }
            returnCallback(getDocumentInfo(), nil)
        }

        private func _beAdd(waiting: UserUUID,
                            _ returnCallback: @escaping (DocumentInfo?, Error?) -> Void) {
            guard accessMode == .private else {
                // public documents have no waiting list, you can join as a peer
                return _beAdd(peer: waiting, returnCallback)
            }
            if canAdd(user: waiting) {
                waitings.append(waiting)
            }
            returnCallback(getDocumentInfo(), nil)
        }

        private func _beAuthorize(peer: UserUUID) -> Error? {
            guard peers.contains(peer) else { return "You are not authorized as a peer of this document" }
            return nil
        }

        private func _beAuthorize(owner: UserUUID) -> Error? {
            guard self.owner == owner else { return "You are not authorized as an owner of this document" }
            return nil
        }

        private func _beGetInfo(user: UserUUID,
                                _ returnCallback: (DocumentInfo?, Error?) -> Void) {
            guard canRead(user: user) else { return returnCallback(nil, "You are not authorized to access this document") }
            returnCallback(getDocumentInfo(), nil)
        }

        private func _bePublish(peer: UserUUID,
                                version: Int,
                                updates: JsonElement) -> Error? {
            guard owner == peer || peers.contains(peer) else { return "You are not authorized as a peer of this document" }
            guard version == history.count else {
                return "Wrong version ({0} != {1})" << [version, history.count]
            }

            for update in updates.iterValues {
                history.append(update.toHitch())
            }

            for service in subscribedServices {
                service.beDocumentDidUpdate(document: self,
                                            documentUUID: documentUUID,
                                            documentVersion: history.count)
            }

            return nil
        }

        private func _beSubscribe(peer: UserUUID,
                                  service: Endeavour.Service) {
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
    public func beAdd(peer: UserUUID,
                      _ sender: Actor,
                      _ callback: @escaping ((DocumentInfo?, Error?) -> Void)) -> Self {
        unsafeSend {
            self._beAdd(peer: peer) { arg0, arg1 in
                sender.unsafeSend {
                    callback(arg0, arg1)
                }
            }
        }
        return self
    }
    @discardableResult
    public func beAdd(waiting: UserUUID,
                      _ sender: Actor,
                      _ callback: @escaping ((DocumentInfo?, Error?) -> Void)) -> Self {
        unsafeSend {
            self._beAdd(waiting: waiting) { arg0, arg1 in
                sender.unsafeSend {
                    callback(arg0, arg1)
                }
            }
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
