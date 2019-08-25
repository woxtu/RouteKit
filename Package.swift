// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "RouteKit",
    products: [
        .library(
            name: "RouteKit",
            targets: ["RouteKit"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "RouteKit",
            dependencies: []
        ),
        .testTarget(
            name: "RouteKitTests",
            dependencies: ["RouteKit"]
        ),
    ],
    swiftLanguageVersions: [4]
)
