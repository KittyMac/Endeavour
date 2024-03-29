import Foundation
import ArgumentParser
import Picaroon
import Flynn
import Sextant
import Spanker
import Hitch

typealias SubscribeLongPull = (JsonElement?, HttpResponse?) -> Void

extension Endeavour {
    public class Service: ServiceActor {

        private var userUUID: UserUUID = UUID().uuidHitch

        private var longPullQueue: [(JsonElement?, HttpResponse?)] = []
        private var longPull: SubscribeLongPull?

        private var lastActivityDate = Date()

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

            // print(jsonElement.toHitch())
            lastActivityDate = Date()

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
                  let clientID = jsonElement[hitch: "clientID"],
                  let version = jsonElement[int: "version"],
                  let document = openDocuments[documentUUID] else {
                return returnCallback(jsonElement,
                                      HttpStaticResponse.badRequest)
            }

            document.bePublish(peer: userUUID,
                               clientID: clientID,
                               version: version,
                               updates: jsonElement[element: "updates"],
                               cursors: jsonElement[element: "cursors"],
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
            handleLongPullQueue()
        }

        private func queueForLongPull(serviceResponse: JsonElement,
                                      httpResponse: HttpResponse) {
            while longPullQueue.count > 3 {
                _ = longPullQueue.removeFirst()
            }
            longPullQueue.append((serviceResponse, httpResponse))
            handleLongPullQueue()
        }

        private func handleLongPullQueue() {
            guard let longPull = longPull else {
                // We might be sending to someone who no longer exists.  We give them a short
                // period of time to reconnect otherwise we make them leave all documents they
                // are connected to
                if abs(self.lastActivityDate.timeIntervalSinceNow) > 10.0 {
                    safeHandleShutdown {
                        print("User \(self.userUUID) disconnected due to inactivity ( \(self.lastActivityDate.timeIntervalSinceNow) > \(10.0) )")
                    }
                }
                return
            }
            guard longPullQueue.count > 0 else { return }

            let next = longPullQueue.removeFirst()
            longPull(next.0, next.1)
            self.longPull = nil
            self.lastActivityDate = Date()
        }

        internal func _beDocumentDidSave(document: Endeavour.Document,
                                         documentInfo: DocumentInfo) {
            self.openDocumentVersions[documentInfo.uuid] = 0
            self.openDocuments[documentInfo.uuid] = document

            let serviceResponse = JsonElement(unknown: [
                "documentUUID": documentInfo.uuid,
                "version": documentInfo.version,
                "command": "save"
            ])

            self.queueForLongPull(serviceResponse: serviceResponse,
                                  httpResponse: HttpResponse(text: documentInfo.content))
        }

        internal func _beDocumentDidUpdate(document: Endeavour.Document,
                                           documentUUID: DocumentUUID,
                                           documentVersion: DocumentVersion) {
            let clientVersion = openDocumentVersions[documentUUID] ?? 0
            guard clientVersion < documentVersion else { return }

            document.beGetUpdates(peer: userUUID,
                                  version: clientVersion,
                                  self) { updateJson in
                guard let updateJson = updateJson else { return }

                self.queueForLongPull(serviceResponse: JsonElement(unknown: [
                    "documentUUID": documentUUID,
                    "command": "update"
                ]),
                httpResponse: HttpResponse(json: updateJson))

            }
        }

        internal func _beDocumentDidClose(documentUUID: DocumentUUID) {
            self.longPull?(JsonElement(unknown: ["documentUUID": documentUUID]),
                           HttpResponse(error: "Document was closed by the owner"))
        }

        internal func _beDocumentDidUpdateCursors(documentUUID: DocumentUUID,
                                                  cursorsJson: Hitch) {
            self.queueForLongPull(serviceResponse: JsonElement(unknown: [
                "documentUUID": documentUUID,
                "command": "cursors"
            ]),
            httpResponse: HttpResponse(json: cursorsJson))
        }
    }
}
