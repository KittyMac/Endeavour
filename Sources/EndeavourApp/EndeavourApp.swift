import Foundation
import ArgumentParser
import Picaroon
import Flynn
import Endeavour
import Hitch

#if DEBUG
let cacheMaxAge = 5
#else
let cacheMaxAge = 3600
#endif

func handleStaticRequest(config: ServerConfig,
                         httpRequest: HttpRequest) -> HttpResponse? {
    if let url = httpRequest.url {

        if url.contains("private/") {
            return HttpStaticResponse.internalServerError
        } else {

            // Request for HTML are never satisfied by the static resources
            if url.ends(with: ".htm") {
                return HttpStaticResponse.internalServerError
            }

            // We only ever allow script.combined.js to be downloaded, and it is a combination of scripts.
            if url.ends(with: "script.combined.js") {
                let payload: Payloadable = httpRequest.supportsGzip ? EndeavourAppPamphlet.Private.ScriptCombinedJsGzip() : EndeavourAppPamphlet.Private.ScriptCombinedJs()
                return HttpResponse(javascript: payload)
            }
            
            let urlString = url.description
            if let content = EndeavourAppPamphlet.get(gzip: urlString), httpRequest.supportsGzip {
                return HttpResponse(status: .ok,
                                    type: HttpContentType.fromPath(url),
                                    payload: content,
                                    encoding: HttpEncoding.gzip.rawValue,
                                    cacheMaxAge: cacheMaxAge)
            } else if let content = EndeavourAppPamphlet.get(data: urlString) {
                return HttpResponse(status: .ok,
                                    type: HttpContentType.fromPath(url),
                                    payload: content,
                                    cacheMaxAge: cacheMaxAge)
            } else if let content = EndeavourAppPamphlet.get(string: urlString) {
                return HttpResponse(status: .ok,
                                    type: HttpContentType.fromPath(url),
                                    payload: content,
                                    cacheMaxAge: cacheMaxAge)
            }
        }
    }
    return nil
}

class DocumentsDelegate: Actor, Documentable {

    internal func _beSave(documentInfo: DocumentInfo) -> Error? {
        do {
            let path = "/tmp/endeavour.\(documentInfo.uuid).swift"
            try documentInfo.content.description.write(toFile: path, atomically: true, encoding: .utf8)
            return nil
        } catch {
            return "Failed to save document to persistant storage"
        }
    }

    internal func _beRevert(documentInfo: DocumentInfo,
                            _ returnCallback: (DocumentContent?, Error?) -> Void) {
        let path = "/tmp/endeavour.\(documentInfo.uuid).swift"
        do {
            returnCallback(Hitch(string: try String(contentsOfFile: path)), nil)
        } catch {
            return returnCallback(nil, "Failed to revert document to previously saved version")
        }
    }

    internal func _beAuthorize(userSession: UserServiceableSession,
                               user: UserUUID,
                               _ returnCallback: @escaping (UserAccessMode, Hitch?) -> Void) {
        let randomNames: [Hitch] = [
            "Jack",
            "Jill",
            "Humpty",
            "Dumpty",
            "Alice",
            "Rabbit",
            "Hatter",
            "Mouse",
            "Cheshire"
        ]

        returnCallback(.peer, randomNames.randomElement())
    }
}

public enum EndeavourApp {
    public static func http(_ address: String,
                            _ httpPort: Int32) {

        Flynn.startup()

        let ownerUUID = UUID().uuidHitch
        Endeavour.shared.beNewDocument(userUUID: ownerUUID,
                                       named: "SwiftSample",
                                       content: swiftSample,
                                       Flynn.any) { documentInfo, document, error in
            guard let _ = documentInfo,
                  let document = document else {
                fatalError(error?.description ?? "failed to create SwiftSample")
            }

            document.beSetDelegate(ownerName: "Endeavour",
                                   delegate: DocumentsDelegate())
        }

        let config = ServerConfig(address: address,
                                  port: Int(httpPort),
                                  requestTimeout: 30.0,
                                  maxRequestInBytes: 1024 * 1024 * 15)

        Server<WebUserSession>(config: config,
                               staticStorageHandler: handleStaticRequest).run()
    }

}

let swiftSample: Hitch = """
import Sextant

var x: Int = 0
let z: Double = 1.0
var x3 = 5
var y = "hello"
let f = x
var x1 = "a", y1 = "b", z1 = "c"
let x2 = 0, y2 = 1, z2 = 1

func test() {
    var x = 10
    repeat {
        x -= 1
    } while x >= 0

    while true {
        if true {
            continue
        }
        break
    }

    switch x {
        // Comment
        case 0: break
        case 1: return
        default: print("default") break
    }
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

func sextantSample() {
    let json = #"{"store":{"book":[{"category":"reference","author":"Nigel Rees","title":"Sayings of the Century","display-price":8.95,"bargain":true},{"category":"fiction","author":"Evelyn Waugh","title":"Sword of Honour","display-price":12.99,"bargain":false},{"category":"fiction","author":"Herman Melville","title":"Moby Dick","isbn":"0-553-21311-3","display-price":8.99,"bargain":true},{"category":"fiction","author":"J. R. R. Tolkien","title":"The Lord of the Rings","isbn":"0-395-19395-8","display-price":22.99,"bargain":false}],"bicycle":{"color":"red","display-price":19.95,"foo:bar":"fooBar","dot.notation":"new","dash-notation":"dashes"}}}"#
    if let results = json.query(values: "$.store.book[*].author") {
        print(results)
    }
}

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
        private let baseDocument: DocumentContent = sampleSwift

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

"""
