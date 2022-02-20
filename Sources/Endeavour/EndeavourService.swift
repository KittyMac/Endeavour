import Foundation
import ArgumentParser
import Picaroon
import Flynn
import Sextant
import Spanker
import Hitch
/*
func errorJson(_ message: HalfHitch) -> JsonElement {
    return JsonElement(unknown:
        [
            "error": message
        ]
    )
}
 */

public class EndeavourService: ServiceActor {

    private let userUUID: OwnerUUID = UUID().uuidHitch

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
        case "close":
            safeCloseDocument(jsonElement, returnCallback)
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
}

extension EndeavourService {
    func safeNewDocument(_ jsonElement: JsonElement,
                         _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {
        Endeavour.Manager.shared.beNewDocument(userUUID: userUUID,
                                               self) { documentInfo, error in
            if let error = error {
                return returnCallback(nil, HttpResponse(error: error))
            }
            guard let documentInfo = documentInfo else {
                return returnCallback(nil, HttpResponse(error: "document info is nil"))
            }

            returnCallback(JsonElement(unknown: [
                "documentUUID": documentInfo.uuid,
                "version": documentInfo.version
            ]), HttpResponse(text: documentInfo.content))
        }
    }

    func safeCloseDocument(_ jsonElement: JsonElement,
                           _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {
        guard let documentUUID = jsonElement[hitch: "documentUUID"] else {
            return returnCallback(nil, HttpResponse(error: "documentUUID is missing"))
        }

        Endeavour.Manager.shared.beCloseDocument(userUUID: userUUID,
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

        Endeavour.Manager.shared.beJoinDocument(userUUID: userUUID,
                                                 documentUUID: documentUUID,
                                                 self) { documentInfo, error in
            if let error = error {
                return returnCallback(nil, HttpResponse(error: error))
            }
            guard let documentInfo = documentInfo else {
                return returnCallback(nil, HttpResponse(error: "document info is nil"))
            }

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

        Endeavour.Manager.shared.bePushToDocument(userUUID: userUUID,
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
        guard let documentUUID = jsonElement[hitch: "documentUUID"] else {
            return returnCallback(nil, HttpResponse(error: "documentUUID is missing"))
        }
        guard let version = jsonElement[int: "version"] else {
            return returnCallback(nil, HttpResponse(error: "version is missing"))
        }

        Endeavour.Manager.shared.bePullDocument(userUUID: userUUID,
                                                documentUUID: documentUUID,
                                                version: version,
                                                self) { json in
            guard let json = json else {
                return returnCallback(nil, HttpResponse(error: "document history is nil"))
            }
            returnCallback(nil, HttpResponse(json: json))
        }
    }
}
