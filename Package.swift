// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AnytaxEstimatorSdk",
    defaultLocalization: "en",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "AnytaxEstimatorSdk",
            targets: ["AnytaxEstimatorSdk"]
        )
    ],
    targets: [
        .target(
            name: "AnytaxEstimatorSdk",
            path: "Sources/AnytaxEstimatorSdk",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "AnytaxEstimatorSdkTests",
            dependencies: ["AnytaxEstimatorSdk"]
        )
    ]
)
