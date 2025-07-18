import Flynn
import Foundation
import Picaroon
import Hitch
import Sextant
import Endeavour

public class WebUserSession: UserServiceableSession {

    public required init() {
        super.init()
        unsafePriority = 99

        beAdd(service: Endeavour.Service())
    }

    required init(cookieSessionUUID: Hitch?,
                  javascriptSessionUUID: Hitch?,
                  sessionActivityTimeout: TimeInterval) {
        super.init(cookieSessionUUID: cookieSessionUUID,
                   javascriptSessionUUID: javascriptSessionUUID,
                   sessionActivityTimeout: sessionActivityTimeout)
        unsafePriority = 99

        beAdd(service: Endeavour.Service())
    }

    public override func safeHandleRequest(connection: AnyConnection,
                                           httpRequest: HttpRequest) {

        let headers: [HalfHitch] = ["Set-Cookie: SESSION_UUID={0}" << [unsafeJavascriptSessionUUID]]

        let payload: Payloadable = httpRequest.supportsGzip ? EndeavourAppPamphlet.Private.ShellHtmlGzip() : EndeavourAppPamphlet.Private.ShellHtml()

        connection.beSend(httpResponse: HttpResponse(html: payload,
                                                     headers: headers))
    }
}
