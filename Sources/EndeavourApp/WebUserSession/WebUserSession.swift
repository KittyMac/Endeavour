import Flynn
import Foundation
import Picaroon
import EndeavourPamphlet
import Hitch
import Sextant
import Endeavour

public class WebUserSession: UserServiceableSession {

    public required init() {
        super.init()
        unsafePriority = 99

        beAdd(service: EndeavourService())
    }

    required init(cookieSessionUUID: Hitch?, javascriptSessionUUID: Hitch?) {
        super.init(cookieSessionUUID: cookieSessionUUID, javascriptSessionUUID: javascriptSessionUUID)
        unsafePriority = 99

        beAdd(service: EndeavourService())
    }

    public override func safeHandleRequest(connection: AnyConnection,
                                           httpRequest: HttpRequest) {

        let headers: [HalfHitch] = ["Set-Cookie: SESSION_UUID={0}" << [unsafeJavascriptSessionUUID]]

        let payload: Payloadable = httpRequest.supportsGzip ? EndeavourPamphlet.Private.ShellHtmlGzip() : EndeavourPamphlet.Private.ShellHtml()

        connection.beSend(httpResponse: HttpResponse(html: payload,
                                                     headers: headers))
    }
}
