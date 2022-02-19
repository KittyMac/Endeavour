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

public extension Endeavour {
    class Document: Actor {

        let documentUUID: Hitch = UUID().uuidHitch

        private var history = [Hitch]()
        private let baseDocument: DocumentContent = "Hello World"

        private var owners: [OwnerUUID] = []
        private var peers: [OwnerUUID] = []
        private var waitings: [OwnerUUID] = []

        private var accessMode = AccessMode.public

        private var waitingPulls = [(HalfHitch?) -> Void]()

        public init(owner: OwnerUUID) {
            owners.append(owner)
        }

        private func getDocumentInfo() -> DocumentInfo {
            return DocumentInfo(uuid: documentUUID,
                                content: baseDocument,
                                version: 0)
        }

        private func canAdd(user: OwnerUUID) -> Bool {
            return owners.contains(user) == false && peers.contains(user) == false && waitings.contains(user) == false
        }

        private func canRead(user: OwnerUUID) -> Bool {
            return owners.contains(user) || peers.contains(user)
        }

        private func canWrite(user: OwnerUUID) -> Bool {
            return owners.contains(user) || peers.contains(user)
        }

        private func _beAdd(peer: OwnerUUID,
                            _ returnCallback: @escaping (DocumentInfo?, Error?) -> Void) {
            if canAdd(user: peer) {
                peers.append(peer)
            }
            returnCallback(getDocumentInfo(), nil)
        }

        private func _beAdd(owner: OwnerUUID,
                            _ returnCallback: @escaping (DocumentInfo?, Error?) -> Void) {
            if canAdd(user: owner) {
                owners.append(owner)
            }
            returnCallback(getDocumentInfo(), nil)
        }

        private func _beAdd(waiting: OwnerUUID,
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

        private func _beAuthorize(peer: OwnerUUID) -> Error? {
            guard peers.contains(peer) else { return "You are not authorized as a peer of this document" }
            return nil
        }

        private func _beAuthorize(owner: OwnerUUID) -> Error? {
            guard owners.contains(owner) else { return "You are not authorized as an owner of this document" }
            return nil
        }

        private func _beGetInfo(user: OwnerUUID,
                                _ returnCallback: (DocumentInfo?, Error?) -> Void) {
            guard canRead(user: user) else { return returnCallback(nil, "You are not authorized to access this document") }
            returnCallback(getDocumentInfo(), nil)
        }

        private func _bePushTo(peer: OwnerUUID,
                               version: Int,
                               updates: JsonElement) -> Error? {
            guard peers.contains(peer) || owners.contains(peer) else { return "You are not authorized as a peer of this document" }
            guard version == history.count else { return "Wrong version ({0} != {1})" << [version, history.count] }

            for update in updates.iterValues {
                history.append(update.toHitch())
            }

            let updatesJson = updates.toHitch().halfhitch()
            for longPull in waitingPulls {
                longPull(updatesJson)
            }
            waitingPulls.removeAll()

            return nil
        }

        private func _bePull(peer: OwnerUUID,
                             version: Int,
                             _ returnCallback: @escaping (HalfHitch?) -> Void) {
            guard peers.contains(peer) || owners.contains(peer) else {
               return returnCallback(nil)
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
                returnCallback(combined.halfhitch())
                return
            }

            waitingPulls.append(returnCallback)
        }
    }
}

// MARK: - Autogenerated by FlynnLint
// Contents of file after this marker will be overwritten as needed

extension Endeavour.Document {

    @discardableResult
    public func beAdd(peer: OwnerUUID,
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
    public func beAdd(owner: OwnerUUID,
                      _ sender: Actor,
                      _ callback: @escaping ((DocumentInfo?, Error?) -> Void)) -> Self {
        unsafeSend {
            self._beAdd(owner: owner) { arg0, arg1 in
                sender.unsafeSend {
                    callback(arg0, arg1)
                }
            }
        }
        return self
    }
    @discardableResult
    public func beAdd(waiting: OwnerUUID,
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
    public func beAuthorize(peer: OwnerUUID,
                            _ sender: Actor,
                            _ callback: @escaping ((Error?) -> Void)) -> Self {
        unsafeSend {
            let result = self._beAuthorize(peer: peer)
            sender.unsafeSend { callback(result) }
        }
        return self
    }
    @discardableResult
    public func beAuthorize(owner: OwnerUUID,
                            _ sender: Actor,
                            _ callback: @escaping ((Error?) -> Void)) -> Self {
        unsafeSend {
            let result = self._beAuthorize(owner: owner)
            sender.unsafeSend { callback(result) }
        }
        return self
    }
    @discardableResult
    public func beGetInfo(user: OwnerUUID,
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
    public func bePushTo(peer: OwnerUUID,
                         version: Int,
                         updates: JsonElement,
                         _ sender: Actor,
                         _ callback: @escaping ((Error?) -> Void)) -> Self {
        unsafeSend {
            let result = self._bePushTo(peer: peer, version: version, updates: updates)
            sender.unsafeSend { callback(result) }
        }
        return self
    }
    @discardableResult
    public func bePull(peer: OwnerUUID,
                       version: Int,
                       _ sender: Actor,
                       _ callback: @escaping ((HalfHitch?) -> Void)) -> Self {
        unsafeSend {
            self._bePull(peer: peer, version: version) { arg0 in
                sender.unsafeSend {
                    callback(arg0)
                }
            }
        }
        return self
    }

}
