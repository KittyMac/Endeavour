// swift-tools-version:5.6
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
        .package(url: "https://github.com/KittyMac/Pamphlet.git", from: "0.3.5"),
        .package(url: "https://github.com/KittyMac/Figurehead.git", from: "0.2.0"),
		.package(url: "https://github.com/KittyMac/Flynn.git", from: "0.3.0"),
        .package(url: "https://github.com/KittyMac/Sextant.git", from: "0.4.0"),
        .package(url: "https://github.com/KittyMac/Hitch.git", from: "0.4.0"),
        .package(url: "https://github.com/KittyMac/Picaroon.git", from: "0.4.0"),
        .package(url: "https://github.com/1024jp/GzipSwift.git", from: "5.2.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Endeavour",
            dependencies: [
                "Flynn",
                "Sextant",
                "Hitch",
                "Picaroon",
                "Pamphlet",
                .product(name: "PamphletFramework", package: "Pamphlet"),
            ],
            plugins: [
                .plugin(name: "PamphletPlugin", package: "Pamphlet"),
                .plugin(name: "FlynnPlugin", package: "Flynn")
            ]
        ),
        .executableTarget(
            name: "EndeavourApp",
            dependencies: [
                "Figurehead",
                "Endeavour",
                "Flynn",
                "Sextant",
                "Hitch",
                "Picaroon",
                "Pamphlet",
                .product(name: "PamphletFramework", package: "Pamphlet"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Gzip", package: "GzipSwift"),
            ],
            plugins: [
                .plugin(name: "PamphletPlugin", package: "Pamphlet"),
                .plugin(name: "FlynnPlugin", package: "Flynn")
            ]
        ),
        .testTarget(
            name: "EndeavourTests",
            dependencies: [
                "Endeavour"
            ]
        )
    ]
)
