// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Endeavour",
    platforms: [
        .macOS(.v10_15), .iOS(.v9)
    ],
    products: [
        .library(name: "Endeavour", targets: ["Endeavour"]),
        .executable(name: "EndeavourApp", targets: ["EndeavourApp"])
    ],
    dependencies: [
        .package(url: "https://github.com/KittyMac/Figurehead.git", .branch("main")),
		.package(url: "https://github.com/KittyMac/Flynn.git", .upToNextMinor(from: "0.2.0")),
        .package(url: "https://github.com/KittyMac/Sextant.git", .upToNextMinor(from: "0.4.0")),
        .package(url: "https://github.com/KittyMac/Hitch.git", .upToNextMinor(from: "0.3.0")),
        .package(name: "Gzip", url: "https://github.com/1024jp/GzipSwift.git", .branch("develop")),
        .package(url: "https://github.com/KittyMac/Picaroon.git", .branch("master")),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0"),
    ],
    targets: [
        .target(
            name: "Endeavour",
            dependencies: [
                "Flynn",
                "Sextant",
                "Hitch"
            ]
        ),
        .target(
            name: "EndeavourApp",
            dependencies: [
                "Endeavour",
                "Flynn",
                "Sextant",
                "Hitch",
                "Pamphlet",
                "Gzip",
				.product(name: "PicaroonFramework", package: "Picaroon"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .target(
            name: "Pamphlet"
        ),
        .testTarget(
            name: "EndeavourTests",
            dependencies: [
                "Endeavour"
            ],
            exclude: [
                "Resources"
            ]
        ),
        .testTarget(
            name: "EndeavourAppTests",
            dependencies: [
                "EndeavourApp"
            ],
            exclude: [
                "Resources"
            ]
        )
    ]
)
