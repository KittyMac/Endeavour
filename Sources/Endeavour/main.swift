import Foundation
import ArgumentParser

let httpPort: Int32 = 8080

struct EndeavourCLI: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Endeavour",
        subcommands: [Http.self],
        defaultSubcommand: Http.self)

    struct Http: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Http server")

        @Argument(help: "IP address to listen on")
        var address: String = "0.0.0.0"

        mutating func run() throws {
            Endeavour.http(address, httpPort)
        }
    }

}

EndeavourCLI.main()
