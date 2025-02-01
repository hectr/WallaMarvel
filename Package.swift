// swift-tools-version: 6.0

import PackageDescription
import CompilerPluginSupport

/// Package definition.
let package = Package(
    name: "WallaMarvelPackage",
    platforms: [
        .iOS(.v15),
        .macOS(.v15),
    ],
    products: Core.products + Data.products + Domain.products + Feature.products,
    dependencies: ExternalDependencies.packages,
    targets: Core.targets + Data.targets + Domain.targets + Feature.targets
)

// MARK: - Dependencies

/// External dependencies used across modules.
enum ExternalDependencies
{
    static var packages: [Package.Dependency]
    {[
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.1.3"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.17.6"),
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.0-latest"),
    ]}

    static var kingfisher: Target.Dependency
    { .product(name: "Kingfisher", package: "Kingfisher") }

    static var snapshotTesting: Target.Dependency
    { .product(name: "SnapshotTesting", package: "swift-snapshot-testing") }

    static var swiftCompilerPlugin: Target.Dependency
    { .product(name: "SwiftCompilerPlugin", package: "swift-syntax") }

    static var swiftSyntaxMacros: Target.Dependency
    { .product(name: "SwiftSyntaxMacros", package: "swift-syntax") }

    static var swiftSyntaxMacrosTestSupport: Target.Dependency
    { .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax") }
}

// MARK: - Module Layers

/**

 # Dependency Rules:

 - Modules at the same level should not depend on each other.
 - A module should only depend on lower-level modules, never on higher-level ones.

 */

/// Low-level modules.
enum Core
{
    static let sourcesPath = "Sources/Core/"
    static let testsPath = "Tests/Core/"

    static var products: [PackageDescription.Product]
    {[]}

    static var targets: [PackageDescription.Target]
    {[
        // LeanRedux module
        .target(
            name: "LeanRedux",
            dependencies: ["LeanReduxMacros"],
            path: sourcesPath + "LeanRedux"
        ),
        .macro(
            name: "LeanReduxMacros",
            dependencies: [
                ExternalDependencies.swiftCompilerPlugin,
                ExternalDependencies.swiftSyntaxMacros,
            ],
            path: sourcesPath + "LeanReduxMacros"
        ),
        .testTarget(
            name: "LeanReduxMacrosTests",
            dependencies: [
                "LeanReduxMacros",
                ExternalDependencies.swiftSyntaxMacrosTestSupport,
            ],
            path: testsPath + "LeanReduxMacrosTests"
        ),
        .executableTarget(
            name: "LeanReduxClient",
            dependencies: ["LeanRedux"],
            path: sourcesPath + "LeanReduxClient"
        ),
        .testTarget(
            name: "LeanReduxTests",
            dependencies: ["LeanRedux"],
            path: testsPath + "LeanReduxTests"
        ),

        // Routing module
        .target(
            name: "Routing",
            path: sourcesPath + "Routing"
        ),
        .testTarget(
            name: "RoutingTests",
            dependencies: ["RoutingTestSupport"],
            path: testsPath + "RoutingTests"
        ),
        .target(
            name: "RoutingTestSupport",
            dependencies: ["Routing"],
            path: sourcesPath + "RoutingTestSupport"
        ),
    ]}
}

/// Shared data management.
enum Data
{
    static let sourcesPath = "Sources/Data/"
    static let testsPath = "Tests/Data/"

    static var products: [PackageDescription.Product]
    {[
        .library(name: "Data", targets: ["Data", "DataContracts"]),
    ]}

    static var targets: [PackageDescription.Target]
    {[
        // Data library
        .target(
            name: "Data",
            dependencies: ["DataContracts"],
            path: sourcesPath + "Data"
        ),
        .target(
            name: "DataContracts",
            path: sourcesPath + "DataContracts"
        ),
        .target(
            name: "DataContractsTestSupport",
            dependencies: ["DataContracts"],
            path: sourcesPath + "DataContractsTestSupport"
        ),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data"],
            path: testsPath + "DataTests"
        ),
    ]}
}

/// Shared UI and business logic.
enum Domain
{
    static let sourcesPath = "Sources/Domain/"
    static let testsPath = "Tests/Domain/"

    static var products: [PackageDescription.Product]
    {[
        .library(name: "Domain", targets: ["Domain", "DomainContracts"]),
    ]}

    static var targets: [PackageDescription.Target]
    {[
        // Domain library
        .target(
            name: "Domain",
            dependencies: [
                "DataContracts",
                "DomainContracts",
            ],
            path: sourcesPath + "Domain"
        ),
        .target(
            name: "DomainTestSupport",
            path: sourcesPath + "DomainTestSupport"
        ),
        .target(
            name: "DomainContracts",
            path: sourcesPath + "DomainContracts"
        ),
        .target(
            name: "DomainContractsTestSupport",
            dependencies: ["DomainContracts"],
            path: sourcesPath + "DomainContractsTestSupport"
        ),
        .testTarget(
            name: "DomainTests",
            dependencies: [
                "DataContractsTestSupport",
                "Domain",
                "DomainTestSupport",
            ],
            path: testsPath + "DomainTests"
        ),
    ]}
}

/// Feature UI and business logic.
enum Feature
{
    static let sourcesPath = "Sources/Features/"
    static let testsPath = "Tests/Features/"

    static var products: [PackageDescription.Product]
    {[
        .library(name: "HeroList", targets: ["HeroList"]),
        .library(name: "HeroDetail", targets: ["HeroDetail"]),
    ]}

    static var targets: [PackageDescription.Target]
    {[
        // HeroList library
        .target(
            name: "HeroList",
            dependencies: [
                "DomainContracts",
                ExternalDependencies.kingfisher,
            ],
            path: sourcesPath + "HeroList"
        ),

        // HeroDetail library
        .target(
            name: "HeroDetail",
            dependencies: [
                "DomainContracts",
                ExternalDependencies.kingfisher,
                "LeanRedux",
                "Routing"
            ],
            path: sourcesPath + "HeroDetail"
        ),
        .testTarget(
            name: "HeroDetailTests",
            dependencies: [
                "DomainContractsTestSupport",
                "HeroDetailTestSupport",
                "RoutingTestSupport",
                ExternalDependencies.snapshotTesting,
            ],
            path: testsPath + "HeroDetailTests"
        ),
        .target(
            name: "HeroDetailTestSupport",
            dependencies: [
                "DomainContracts",
                "HeroDetail",
            ],
            path: sourcesPath + "HeroDetailTestSupport"
        ),
    ]}
}
