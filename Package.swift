// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "WallaMarvelPackage",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(name: "HeroList", targets: ["HeroList"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.17.6"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.1.3"),
    ],
    targets: [
        .target(name: "Data"),

        .target(
            name: "Domain",
            dependencies: ["Data"]
        ),

        .target(
            name: "HeroList",
            dependencies: [
                "Domain",
                "HeroDetail",
                "Routing",
            ]
        ),

        .target(
            name: "HeroDetail",
            dependencies: [
                "LeanRedux",
                .product(name: "Kingfisher", package: "Kingfisher"),
            ]
        ),

        .testTarget(
            name: "HeroDetailTests",
            dependencies: [
                "HeroDetail",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),

        .target(name: "LeanRedux"),
        .testTarget(
            name: "LeanReduxTests",
            dependencies: ["LeanRedux"]
        ),

        .target(name: "Routing"),
        .testTarget(
            name: "RoutingTests",
            dependencies: ["RoutingTestSupport"]
        ),
        .target(
            name: "RoutingTestSupport",
            dependencies: ["Routing"]
        ),
    ]
)
