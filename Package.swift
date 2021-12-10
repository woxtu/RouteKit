// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "RouteKit",
	platforms: [
		.iOS(.v14),
	],
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
    swiftLanguageVersions: [.v5]
)
