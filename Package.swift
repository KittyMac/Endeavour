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
        .package(url: "https://github.com/KittyMac/Pamphlet.git", branch: "master"),
        .package(url: "https://github.com/KittyMac/Figurehead.git", branch: "SPM_Build_Tool"),
		.package(url: "https://github.com/KittyMac/Flynn.git", branch: "SPM_Build_Tool"),
        .package(url: "https://github.com/KittyMac/Sextant.git", .upToNextMinor(from: "0.4.0")),
        .package(url: "https://github.com/KittyMac/Hitch.git", .upToNextMinor(from: "0.4.0")),
        .package(url: "https://github.com/KittyMac/Picaroon.git", branch: "SPM_Build_Tool"),
        .package(url: "https://github.com/1024jp/GzipSwift.git", branch: "develop"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Endeavour",
            dependencies: [
                "Flynn",
                "Sextant",
                "Hitch",
                "Picaroon",
                "Pamphlet"
            ],
            plugins: [
                .plugin(name: "PamphletPlugin", package: "Pamphlet")
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
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Gzip", package: "GzipSwift"),
            ],
            plugins: [
                .plugin(name: "PamphletPlugin", package: "Pamphlet")
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
