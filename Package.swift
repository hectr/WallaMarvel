// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "WallaMarvelPackage",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(name: "LeanRedux", targets: ["LeanRedux"])
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.17.6"),
    ],
    targets: [
        .target(
            name: "LeanRedux",
            dependencies: []
        ),
        .testTarget(
            name: "LeanReduxTests",
            dependencies: ["LeanRedux"]
        ),
    ]
)
