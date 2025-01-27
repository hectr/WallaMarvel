// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "WallaMarvelPackage",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(name: "LeanRedux", targets: ["LeanRedux"])
    ],
    dependencies: [],
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
