// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "QuestradeAPI",
    platforms: [.iOS(.v10), .tvOS(.v10), .watchOS(.v3), .macOS(.v10_12)],
    products: [
        .library(
            name: "QuestradeAPI",
            targets: ["QuestradeAPI"]
        ),
    ],
    targets: [
        .target(
            name: "QuestradeAPI",
            resources: [ .process("FakeResponses") ]
        ),
        .testTarget(
            name: "QuestradeAPITests",
            dependencies: ["QuestradeAPI"]
        ),
    ]
)
