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

public extension Endeavour {
    class Document: Actor {

        let unsafeDocumentUUID = UUID().uuidHitch.halfhitch()

        private var owners: [OwnerUUID] = []
        private var peers: [OwnerUUID] = []
        private var waitings: [OwnerUUID] = []

        private var accessMode = AccessMode.private

        public init(owner: OwnerUUID) {
            owners.append(owner)
        }

        private func confirm(new: OwnerUUID) -> Bool {
            return owners.contains(new) == false && peers.contains(new) == false && waitings.contains(new) == false
        }

        private func _beAdd(peer: OwnerUUID) -> Error? {
            guard confirm(new: peer) else { return "You are already a peer of this document" }
            peers.append(peer)
            return nil
        }

        private func _beAdd(owner: OwnerUUID) -> Error? {
            guard confirm(new: owner) else { return "You are already an owner of this document" }
            owners.append(owner)
            return nil
        }

        private func _beAdd(waiting: OwnerUUID) -> Error? {
            guard confirm(new: waiting) else { return "You are already waiting to join this document" }
            waitings.append(waiting)
            return nil
        }

        private func _beAuthorize(peer: OwnerUUID) -> Error? {
            guard peers.contains(peer) || owners.contains(peer) else { return "You are not authorized as a peer of this document" }
            return nil
        }

        private func _beAuthorize(owner: OwnerUUID) -> Error? {
            guard owners.contains(owner) else { return "You are not authorized as an owner of this document" }
            return nil
        }

        private func _bePushTo(peer: OwnerUUID,
                               version: Int,
                               updates: JsonElement) -> Error? {
            guard peers.contains(peer) || owners.contains(peer) else { return "You are not authorized as a peer of this document" }

            // TODO: save the updates?
            print("""
            Received updates for document {0}
            Document version {1}
            {2}
            """ << [unsafeDocumentUUID, version, updates])

            return nil
        }
    }
}

// MARK: - Autogenerated by FlynnLint
// Contents of file after this marker will be overwritten as needed

extension Endeavour.Document {

    @discardableResult
    public func beAdd(peer: OwnerUUID,
                      _ sender: Actor,
                      _ callback: @escaping ((Error?) -> Void)) -> Self {
        unsafeSend {
            let result = self._beAdd(peer: peer)
            sender.unsafeSend { callback(result) }
        }
        return self
    }
    @discardableResult
    public func beAdd(owner: OwnerUUID,
                      _ sender: Actor,
                      _ callback: @escaping ((Error?) -> Void)) -> Self {
        unsafeSend {
            let result = self._beAdd(owner: owner)
            sender.unsafeSend { callback(result) }
        }
        return self
    }
    @discardableResult
    public func beAdd(waiting: OwnerUUID,
                      _ sender: Actor,
                      _ callback: @escaping ((Error?) -> Void)) -> Self {
        unsafeSend {
            let result = self._beAdd(waiting: waiting)
            sender.unsafeSend { callback(result) }
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

}
