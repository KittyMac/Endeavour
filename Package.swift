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
        .package(url: "https://github.com/KittyMac/Hitch.git", .upToNextMinor(from: "0.4.0")),
        .package(url: "https://github.com/KittyMac/Picaroon.git", .upToNextMinor(from: "0.3.0")),
        .package(name: "Gzip", url: "https://github.com/1024jp/GzipSwift.git", .branch("develop")),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Endeavour",
            dependencies: [
                "Flynn",
                "Sextant",
                "Hitch",
                "Picaroon"
            ]
        ),
        .target(
            name: "EndeavourApp",
            dependencies: [
                "Endeavour",
                "Flynn",
                "Sextant",
                "Hitch",
                "Gzip",
                "Picaroon",
                "EndeavourPamphlet",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .target(
            name: "EndeavourPamphlet"
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
