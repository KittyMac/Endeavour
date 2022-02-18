import Foundation
import ArgumentParser
import Picaroon
import Flynn
import Sextant
import Spanker
import Hitch

func errorJson(_ message: HalfHitch) -> JsonElement {
    return JsonElement(unknown:
        [
            "error": message
        ]
    )
}

public class EndeavourService: ServiceActor {

    private let userUUID: OwnerUUID = UUID().uuidHitch.halfhitch()

    public override func safeHandleRequest(jsonElement: JsonElement,
                                           httpRequest: HttpRequest,
                                           _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {
        guard let command = jsonElement[halfhitch: "command"] else { return returnCallback(errorJson("command is missing"), nil) }

        switch command {
        case "new":
            safeNewDocument(jsonElement, returnCallback)
        case "close":
            safeCloseDocument(jsonElement, returnCallback)
        case "join":
            safeJoinDocument(jsonElement, returnCallback)
        case "push":
            safePushToDocument(jsonElement, returnCallback)
        default:

            print(jsonElement.description)

            return returnCallback(errorJson("unknown command"), nil)
        }
    }
}

extension EndeavourService {
    func safeNewDocument(_ jsonElement: JsonElement,
                         _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {
        Endeavour.Manager.shared.beNewDocument(userUUID: userUUID,
                                               self) { documentUUID in
            guard let documentUUID = documentUUID else {
                returnCallback(errorJson("failed to create document"), nil)
                return
            }

            returnCallback(JsonElement(unknown: [
                "documentUUID": documentUUID
            ]), nil)
        }
    }

    func safeCloseDocument(_ jsonElement: JsonElement,
                           _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {
        guard let documentUUID = jsonElement[halfhitch: "documentUUID"] else {
            return returnCallback(errorJson("documentUUID is missing"), nil)
        }

        Endeavour.Manager.shared.beCloseDocument(userUUID: userUUID,
                                                 documentUUID: documentUUID,
                                                 self) { error in
            if let error = error {
                returnCallback(errorJson(error), nil)
            }

            returnCallback(JsonElement(unknown: [
                "documentUUID": documentUUID
            ]), nil)
        }
    }

    func safeJoinDocument(_ jsonElement: JsonElement,
                           _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {
        guard let documentUUID = jsonElement[halfhitch: "documentUUID"] else {
            return returnCallback(errorJson("documentUUID is missing"), nil)
        }

        Endeavour.Manager.shared.beCloseDocument(userUUID: userUUID,
                                                 documentUUID: documentUUID,
                                                 self) { error in
            if let error = error {
                returnCallback(errorJson(error), nil)
            }

            returnCallback(JsonElement(unknown: [
                "documentUUID": documentUUID
            ]), nil)
        }
    }

    func safePushToDocument(_ jsonElement: JsonElement,
                            _ returnCallback: @escaping (JsonElement?, HttpResponse?) -> Void) {
        guard let documentUUID = jsonElement[halfhitch: "documentUUID"] else {
            return returnCallback(errorJson("documentUUID is missing"), nil)
        }
        guard let version = jsonElement[int: "version"] else {
            return returnCallback(errorJson("version is missing"), nil)
        }
        guard let updates = jsonElement[element: "updates"] else {
            return returnCallback(errorJson("updates is missing"), nil)
        }

        Endeavour.Manager.shared.bePushToDocument(userUUID: userUUID,
                                                  documentUUID: documentUUID,
                                                  version: version,
                                                  updates: updates,
                                                  self) { error in
            if let error = error {
                returnCallback(errorJson(error), nil)
            }

            returnCallback(JsonElement(unknown: [
                "documentUUID": documentUUID
            ]), nil)
        }
    }
}
