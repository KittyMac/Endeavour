import Foundation
import ArgumentParser
import Picaroon
import Flynn
import Sextant
import Spanker
import Hitch

typealias SubscribeLongPull = (JsonElement?, HttpResponse?) -> Void

extension Endeavour {
    public class Service: ServiceActor, Equatable {
        public static func == (lhs: Endeavour.Service, rhs: Endeavour.Service) -> Bool {
            lhs.userUUID == rhs.userUUID
        }

        private let userUUID: UserUUID = UUID().uuidHitch

        private var longPullLastSendDate = Date()
        private var longPull: SubscribeLongPull?
        private var openDocumentVersions: [DocumentUUID: DocumentVersion] = [:]

        public override var unsafeServiceName: Hitch { "EndeavourService" }

        public override func safeHandleRequest(jsonElement: JsonElement,
                                               httpRequest: HttpRequest,
                                               _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {
            guard let command = jsonElement[halfhitch: "command"] else {
                return returnCallback(nil, HttpResponse(error: "command is missing"))
            }

            // print(jsonElement)

            switch command {
            case "new":
                safeNewDocument(jsonElement, returnCallback)
            case "leave":
                safeLeaveDocument(jsonElement, returnCallback)
            case "join":
                safeJoinDocument(jsonElement, returnCallback)
            case "push":
                safePushToDocument(jsonElement, returnCallback)
            case "pull":
                safePullDocument(jsonElement, returnCallback)
            default:
                return returnCallback(nil, HttpResponse(error: "unknown command"))
            }
        }

        func safeNewDocument(_ jsonElement: JsonElement,
                             _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {
            let content: Hitch? = jsonElement[hitch: "content"]
            let name: Hitch? = jsonElement[hitch: "name"]

            Endeavour.shared.beNewDocument(userUUID: userUUID,
                                           named: name,
                                           content: content,
                                           self) { documentInfo, error in
                if let error = error {
                    return returnCallback(nil, HttpResponse(error: error))
                }
                guard let documentInfo = documentInfo else {
                    return returnCallback(nil, HttpResponse(error: "document info is nil"))
                }

                Endeavour.shared.beSubscribe(userUUID: self.userUUID,
                                             documentUUID: documentInfo.uuid,
                                             service: self)

                returnCallback(JsonElement(unknown: [
                    "documentUUID": documentInfo.uuid,
                    "version": documentInfo.version
                ]), HttpResponse(text: documentInfo.content))
            }
        }

        func safeLeaveDocument(_ jsonElement: JsonElement,
                               _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {
            guard let documentUUID = jsonElement[hitch: "documentUUID"] else {
                return returnCallback(nil, HttpResponse(error: "documentUUID is missing"))
            }

            Endeavour.shared.beLeaveDocument(userUUID: userUUID,
                                             documentUUID: documentUUID,
                                             self) { error in
                if let error = error {
                    return returnCallback(nil, HttpResponse(error: error))
                }

                returnCallback(JsonElement(unknown: [
                    "documentUUID": documentUUID
                ]), nil)
            }
        }

        func safeJoinDocument(_ jsonElement: JsonElement,
                               _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {
            guard let documentUUID = jsonElement[hitch: "documentUUID"] else {
                return returnCallback(nil, HttpResponse(error: "documentUUID is missing"))
            }

            Endeavour.shared.beJoinDocument(userUUID: userUUID,
                                            documentUUID: documentUUID,
                                            self) { documentInfo, error in
                if let error = error {
                    return returnCallback(nil, HttpResponse(error: error))
                }
                guard let documentInfo = documentInfo else {
                    return returnCallback(nil, HttpResponse(error: "document info is nil"))
                }

                Endeavour.shared.beSubscribe(userUUID: self.userUUID,
                                             documentUUID: documentUUID,
                                             service: self)

                returnCallback(JsonElement(unknown: [
                    "documentUUID": documentInfo.uuid,
                    "version": documentInfo.version
                ]), HttpResponse(text: documentInfo.content))
            }
        }

        func safePushToDocument(_ jsonElement: JsonElement,
                                _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {
            guard let documentUUID = jsonElement[hitch: "documentUUID"] else {
                return returnCallback(nil, HttpResponse(error: "documentUUID is missing"))
            }
            guard let version = jsonElement[int: "version"] else {
                return returnCallback(nil, HttpResponse(error: "version is missing"))
            }
            guard let updates = jsonElement[element: "updates"] else {
                return returnCallback(nil, HttpResponse(error: "updates is missing"))
            }

            Endeavour.shared.bePushToDocument(userUUID: userUUID,
                                              documentUUID: documentUUID,
                                              version: version,
                                              updates: updates,
                                              self) { error in
                if let error = error {
                    return returnCallback(nil, HttpResponse(error: error))
                }

                returnCallback(JsonElement(unknown: [
                    "documentUUID": documentUUID
                ]), nil)
            }
        }

        func safePullDocument(_ jsonElement: JsonElement,
                              _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {

            openDocumentVersions.removeAll()
            if let documentUUIDs = jsonElement[element: "documentUUIDs"],
               let documentVersions = jsonElement[element: "documentVersions"],
               documentUUIDs.count == documentVersions.count {
                for idx in 0..<documentUUIDs.count {
                    if let documentUUID = documentUUIDs[hitch: idx],
                       let version = documentVersions[int: idx] {
                        openDocumentVersions[documentUUID] = version
                    }
                }
            }

            if let longPull = longPull {
                longPull(nil, HttpResponse(error: "cancelled by another call to pull"))
            }

            longPull = returnCallback
        }

        private func _beDocumentDidUpdate(document: Endeavour.Document,
                                          documentUUID: DocumentUUID,
                                          documentVersion: DocumentVersion) {
            let clientVersion = openDocumentVersions[documentUUID] ?? 0
            guard clientVersion < documentVersion else { return }

            document.beGetUpdates(peer: userUUID,
                                  version: clientVersion,
                                  self) { updateJson in
                guard let updateJson = updateJson else { return }

                if let longPull = self.longPull {
                    longPull(JsonElement(unknown: ["documentUUID": documentUUID]),
                                    HttpResponse(json: updateJson))
                    self.longPull = nil
                    self.longPullLastSendDate = Date()
                } else {
                    // We might be sending to someone who no longer exists.  We give them a short
                    // period of time to reconnect otherwise we make them leave all documents they
                    // are connected to
                    if abs(self.longPullLastSendDate.timeIntervalSinceNow) > 10.0 {
                        print("User self.userUUID disconnected due to inactivity")
                        for documentUUID in self.openDocumentVersions.keys {
                            Endeavour.shared.beLeaveDocument(userUUID: self.userUUID,
                                                             documentUUID: documentUUID,
                                                             self) { _ in }
                        }
                    }
                }

            }
        }

        private func _beDocumentDidClose(documentUUID: DocumentUUID) {
            self.longPull?(JsonElement(unknown: ["documentUUID": documentUUID]),
                           HttpResponse(error: "Document was closed by the owner"))
        }
    }
}

// MARK: - Autogenerated by FlynnLint
// Contents of file after this marker will be overwritten as needed

extension Endeavour.Service {

    @discardableResult
    public func beDocumentDidUpdate(document: Endeavour.Document,
                                    documentUUID: DocumentUUID,
                                    documentVersion: DocumentVersion) -> Self {
        unsafeSend { self._beDocumentDidUpdate(document: document, documentUUID: documentUUID, documentVersion: documentVersion) }
        return self
    }
    @discardableResult
    public func beDocumentDidClose(documentUUID: DocumentUUID) -> Self {
        unsafeSend { self._beDocumentDidClose(documentUUID: documentUUID) }
        return self
    }

}

extension Endeavour {

}
