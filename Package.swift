// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "QuestradeAPI",
    platforms: [.iOS(.v14), .tvOS(.v14), .watchOS(.v8), .macOS(.v11)],
    products: [
        .library(
            name: "QuestradeAPI",
            targets: ["QuestradeAPI"]
        ),
        .library(
            name: "QuestradeAPIFakes",
            targets: ["QuestradeAPIFakes"]
        ),
    ],
    targets: [
        .target(name: "QuestradeAPI"),
        .target(
            name: "QuestradeAPIFakes",
            dependencies: ["QuestradeAPI"],
            resources: [ .process("FakeResponses") ]
        ),
        .testTarget(
            name: "QuestradeAPITests",
            dependencies: ["QuestradeAPI", "QuestradeAPIFakes"]
        )
    ]
)
