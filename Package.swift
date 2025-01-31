// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "WallaMarvelPackage",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(name: "Data", targets: ["Data", "DataContracts"]),
        .library(name: "Domain", targets: ["Domain", "DomainContracts"]),
        .library(name: "HeroList", targets: ["HeroList"]),
        .library(name: "HeroDetail", targets: ["HeroDetail"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.17.6"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.1.3"),
    ],
    targets: [
        // Data library
        .target(
            name: "Data",
            dependencies: ["DataContracts"]
        ),
        .target(name: "DataContracts"),

        // Domain library
        .target(
            name: "Domain",
            dependencies: [
                "DataContracts",
                "DomainContracts",
            ]
        ),
        .target(name: "DomainContracts"),

        // HeroList library
        .target(
            name: "HeroList",
            dependencies: [
                "DomainContracts",
                .product(name: "Kingfisher", package: "Kingfisher"),
            ]
        ),

        // HeroDetail library
        .target(
            name: "HeroDetail",
            dependencies: [
                .product(name: "Kingfisher", package: "Kingfisher"),
                "LeanRedux",
                "Routing"
            ]
        ),
        .testTarget(
            name: "HeroDetailTests",
            dependencies: [
                "HeroDetailTestSupport",
                "RoutingTestSupport",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
        .target(
            name: "HeroDetailTestSupport",
            dependencies: ["HeroDetail"]
        ),

        // Redux module
        .target(name: "LeanRedux"),
        .testTarget(
            name: "LeanReduxTests",
            dependencies: ["LeanRedux"]
        ),

        // Routing module
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
