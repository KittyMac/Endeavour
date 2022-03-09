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

        private var userUUID: UserUUID = UUID().uuidHitch

        private var longPullLastSendDate = Date()
        private var longPull: SubscribeLongPull?
        private var openDocumentVersions: [DocumentUUID: DocumentVersion] = [:]
        private var openDocuments: [DocumentUUID: Document] = [:]

        public override var unsafeServiceName: Hitch { "EndeavourService" }

        public override func safeHandleShutdown(_ returnCallback: @escaping () -> Void) {
            var documentsToLeave = openDocumentVersions.count

            for documentUUID in openDocumentVersions.keys {
                Endeavour.shared.beLeaveDocument(userUUID: self.userUUID,
                                                 service: self,
                                                 documentUUID: documentUUID,
                                                 self) { _ in
                    documentsToLeave -= 1
                    if documentsToLeave <= 0 {
                        returnCallback()
                    }
                }
            }
        }

        public override func safeHandleRequest(userSession: UserServiceableSession,
                                               jsonElement: JsonElement,
                                               httpRequest: HttpRequest,
                                               _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {
            guard let command = jsonElement[halfhitch: "command"] else {
                return returnCallback(jsonElement, HttpStaticResponse.badRequest)
            }

            userUUID = userSession.unsafeSessionUUID

            switch command {
            case "new":
                safeNewDocument(userSession, jsonElement, returnCallback)
            case "leave":
                safeLeaveDocument(userSession, jsonElement, returnCallback)
            case "join":
                safeJoinDocument(userSession, jsonElement, returnCallback)
            case "save":
                safeSaveDocument(userSession, jsonElement, returnCallback)
            case "revert":
                safeRevertDocument(userSession, jsonElement, returnCallback)
            case "push":
                safePushToDocument(userSession, jsonElement, returnCallback)
            case "cursors":
                safeCursorToDocument(userSession, jsonElement, returnCallback)
            case "pull":
                safePullDocument(userSession, jsonElement, returnCallback)
            default:
                return returnCallback(jsonElement, HttpResponse(error: "unknown command"))
            }
        }

        func safeNewDocument(_ userSession: UserServiceableSession,
                             _ jsonElement: JsonElement,
                             _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {
            let content: Hitch? = jsonElement[hitch: "content"]
            let name: Hitch? = jsonElement[hitch: "name"]

            Endeavour.shared.beNewDocument(userUUID: userUUID,
                                           named: name,
                                           content: content,
                                           self) { documentInfo, document, error in
                if let error = error {
                    return returnCallback(jsonElement,
                                          HttpResponse(error: error))
                }
                guard let documentInfo = documentInfo,
                      let document = document else {
                    return returnCallback(jsonElement,
                                          HttpResponse(error: "document is nil"))
                }

                document.beSubscribe(peer: self.userUUID, service: self)

                self.openDocumentVersions[documentInfo.uuid] = documentInfo.version
                self.openDocuments[documentInfo.uuid] = document

                returnCallback(documentInfo.jsonElement(),
                               HttpResponse(text: documentInfo.content))
            }
        }

        func safeLeaveDocument(_ userSession: UserServiceableSession,
                               _ jsonElement: JsonElement,
                               _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {
            guard let documentUUID = jsonElement[hitch: "documentUUID"] else {
                return returnCallback(jsonElement,
                                      HttpStaticResponse.badRequest)
            }

            Endeavour.shared.beLeaveDocument(userUUID: userUUID,
                                             service: self,
                                             documentUUID: documentUUID,
                                             self) { error in
                if let error = error {
                    return returnCallback(jsonElement,
                                          HttpResponse(error: error))
                }

                returnCallback(JsonElement(unknown: [
                    "documentUUID": documentUUID
                ]), nil)
            }
        }

        func safeJoinDocument(_ userSession: UserServiceableSession,
                              _ jsonElement: JsonElement,
                               _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {
            guard let documentUUID = jsonElement[hitch: "documentUUID"] else {
                return returnCallback(jsonElement,
                                      HttpStaticResponse.badRequest)
            }

            Endeavour.shared.beJoinDocument(userSession: userSession,
                                            userUUID: userUUID,
                                            documentUUID: documentUUID,
                                            self) { documentInfo, document, error in
                if let error = error {
                    return returnCallback(jsonElement,
                                          HttpResponse(error: error))
                }
                guard let documentInfo = documentInfo,
                      let document = document else {
                    return returnCallback(jsonElement,
                                          HttpResponse(error: "document is nil"))
                }

                document.beSubscribe(peer: self.userUUID,
                                     service: self)

                self.openDocumentVersions[documentInfo.uuid] = documentInfo.version
                self.openDocuments[documentInfo.uuid] = document

                returnCallback(documentInfo.jsonElement(),
                               HttpResponse(text: documentInfo.content))
            }
        }

        func safeSaveDocument(_ userSession: UserServiceableSession,
                              _ jsonElement: JsonElement,
                              _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {
            guard let documentUUID = jsonElement[hitch: "documentUUID"],
                  let version = openDocumentVersions[documentUUID],
                  let document = openDocuments[documentUUID] else {
                return returnCallback(jsonElement,
                                      HttpStaticResponse.badRequest)
            }

            document.beSave(peer: userUUID,
                            version: version,
                            self) { error in
                if let error = error {
                    return returnCallback(jsonElement,
                                          HttpResponse(error: error))
                }

                returnCallback(JsonElement(unknown: [
                    "documentUUID": documentUUID
                ]), nil)
            }
        }

        func safeRevertDocument(_ userSession: UserServiceableSession,
                                _ jsonElement: JsonElement,
                                _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {
            guard let documentUUID = jsonElement[hitch: "documentUUID"],
                  let version = openDocumentVersions[documentUUID],
                  let document = openDocuments[documentUUID] else {
                return returnCallback(jsonElement,
                                      HttpStaticResponse.badRequest)
            }

            document.beRevert(peer: userUUID,
                              version: version,
                              self) { error in
                if let error = error {
                    return returnCallback(jsonElement,
                                          HttpResponse(error: error))
                }

                returnCallback(JsonElement(unknown: [
                    "documentUUID": documentUUID
                ]), nil)
            }
        }

        func safePushToDocument(_ userSession: UserServiceableSession,
                                _ jsonElement: JsonElement,
                                _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {
            guard let documentUUID = jsonElement[hitch: "documentUUID"],
                  let version = jsonElement[int: "version"],
                  let updates = jsonElement[element: "updates"],
                  let document = openDocuments[documentUUID] else {
                return returnCallback(jsonElement,
                                      HttpStaticResponse.badRequest)
            }

            document.bePublish(peer: userUUID,
                               version: version,
                               updates: updates,
                               self) { error in
                if let error = error {
                    return returnCallback(jsonElement,
                                          HttpResponse(error: error))
                }

                returnCallback(JsonElement(unknown: [
                    "documentUUID": documentUUID
                ]), nil)
            }
        }

        func safeCursorToDocument(_ userSession: UserServiceableSession,
                                  _ jsonElement: JsonElement,
                                  _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {
            guard let documentUUID = jsonElement[hitch: "documentUUID"],
                  let cursors = jsonElement[element: "cursors"],
                  let document = openDocuments[documentUUID] else {
                return returnCallback(jsonElement,
                                      HttpStaticResponse.badRequest)
            }

            document.bePublish(peer: userUUID,
                               cursors: cursors,
                               self) { error in
                if let error = error {
                    return returnCallback(jsonElement,
                                          HttpResponse(error: error))
                }

                returnCallback(JsonElement(unknown: [
                    "documentUUID": documentUUID
                ]), nil)
            }
        }

        func safePullDocument(_ userSession: UserServiceableSession,
                              _ jsonElement: JsonElement,
                              _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {

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

        private func sendToLongPull(serviceResponse: JsonElement,
                                    httpResponse: HttpResponse) {
            if let longPull = self.longPull {
                longPull(serviceResponse,
                         httpResponse)
                self.longPull = nil
                self.longPullLastSendDate = Date()
            } else {
                // We might be sending to someone who no longer exists.  We give them a short
                // period of time to reconnect otherwise we make them leave all documents they
                // are connected to
                if abs(self.longPullLastSendDate.timeIntervalSinceNow) > 10.0 {
                    safeHandleShutdown {
                        print("User \(self.userUUID) disconnected due to inactivity")
                    }
                }
            }
        }

        private func _beDocumentDidSave(document: Endeavour.Document,
                                        documentInfo: DocumentInfo) {
            self.openDocumentVersions[documentInfo.uuid] = 0
            self.openDocuments[documentInfo.uuid] = document

            let serviceResponse = JsonElement(unknown: [
                "documentUUID": documentInfo.uuid,
                "version": documentInfo.version,
                "command": "save"
            ])

            self.sendToLongPull(serviceResponse: serviceResponse,
                                httpResponse: HttpResponse(text: documentInfo.content))
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

                self.sendToLongPull(serviceResponse: JsonElement(unknown: [
                    "documentUUID": documentUUID,
                    "command": "update"
                ]),
                httpResponse: HttpResponse(json: updateJson))

            }
        }

        private func _beDocumentDidClose(documentUUID: DocumentUUID) {
            self.longPull?(JsonElement(unknown: ["documentUUID": documentUUID]),
                           HttpResponse(error: "Document was closed by the owner"))
        }

        private func _beDocumentDidUpdateCursors(documentUUID: DocumentUUID,
                                                 cursorsJson: Hitch) {
            self.sendToLongPull(serviceResponse: JsonElement(unknown: [
                "documentUUID": documentUUID,
                "command": "cursors"
            ]),
            httpResponse: HttpResponse(json: cursorsJson))
        }
    }
}

// MARK: - Autogenerated by FlynnLint
// Contents of file after this marker will be overwritten as needed

extension Endeavour.Service {

    @discardableResult
    public func beDocumentDidSave(document: Endeavour.Document,
                                  documentInfo: DocumentInfo) -> Self {
        unsafeSend { self._beDocumentDidSave(document: document, documentInfo: documentInfo) }
        return self
    }
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
    @discardableResult
    public func beDocumentDidUpdateCursors(documentUUID: DocumentUUID,
                                           cursorsJson: Hitch) -> Self {
        unsafeSend { self._beDocumentDidUpdateCursors(documentUUID: documentUUID, cursorsJson: cursorsJson) }
        return self
    }

}

extension Endeavour {

}
