// swift-tools-version: 6.0.0

import PackageDescription
import CompilerPluginSupport

/// Package definition.
let package = Package(
    name: "WallaMarvelPackage",
    platforms: [
        .iOS(.v15),
        .macOS(.v15),
    ],
    products: Core.products + Domain.products + Features.products,
    dependencies: ExternalDependencies.packages,
    targets: Core.targets + Domain.targets + Features.targets
)

// MARK: - Dependencies

/// External dependencies used across modules.
enum ExternalDependencies
{
    static var packages: [Package.Dependency]
    {[
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.1.3"),
        .package(url: "https://github.com/apple/swift-collections.git", from: "1.1.0"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.17.6"),
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.0-latest"),
    ]}

    static var collections: Target.Dependency
    { .product(name: "Collections", package: "swift-collections") }

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
    {[
        .library(name: "LeanRedux", targets: ["LeanRedux"]),
        .library(name: "Networking", targets: ["Networking", "NetworkingTestSupport"]),
        .library(name: "Routing", targets: ["Routing", "RoutingTestSupport"]),
    ]}

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

        // Networking
        .target(
            name: "Networking",
            dependencies: [ExternalDependencies.collections],
            path: sourcesPath + "Networking"
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["NetworkingTestSupport"],
            path: testsPath + "NetworkingTests"
        ),
        .target(
            name: "NetworkingTestSupport",
            dependencies: ["Networking"],
            path: sourcesPath + "NetworkingTestSupport"
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

/// Shared business logic.
enum Domain
{
    static let sourcesPath = "Sources/Domain/"
    static let testsPath = "Tests/Domain/"

    static var products: [PackageDescription.Product]
    {[
        .library(name: "CoreDomain", targets: ["CoreDomain", "CoreDomainContracts", "CoreDomainContractsTestSupport", "CoreDomainTestSupport"]),
    ]}

    static var targets: [PackageDescription.Target]
    {[
        // CoreDomain library
        .target(
            name: "CoreDomain",
            dependencies: [
                "CoreDomainContracts",
                "Networking",
            ],
            path: sourcesPath + "CoreDomain"
        ),
        .target(
            name: "CoreDomainContracts",
            path: sourcesPath + "CoreDomainContracts"
        ),
        .target(
            name: "CoreDomainContractsTestSupport",
            dependencies: ["CoreDomainContracts"],
            path: sourcesPath + "CoreDomainContractsTestSupport"
        ),
        .testTarget(
            name: "CoreDomainTests",
            dependencies: [
                "CoreDomain",
                "CoreDomainTestSupport",
            ],
            path: testsPath + "CoreDomainTests"
        ),
        .target(
            name: "CoreDomainTestSupport",
            dependencies: ["CoreDomain"],
            path: sourcesPath + "CoreDomainTestSupport"
        ),
    ]}
}

/// Features UI and business logic.
enum Features
{
    static let sourcesPath = "Sources/Features/"
    static let testsPath = "Tests/Features/"

    static var products: [PackageDescription.Product]
    {[
        .library(name: "HeroDetail", targets: ["HeroDetail", "HeroDetailTestSupport"]),
        .library(name: "HeroList", targets: ["HeroList", "HeroListTestSupport"]),
    ]}

    static var targets: [PackageDescription.Target]
    {[
        // HeroList library
        .target(
            name: "HeroList",
            dependencies: [
                "CoreDomainContracts",
                ExternalDependencies.kingfisher,
            ],
            path: sourcesPath + "HeroList"
        ),
        .testTarget(
            name: "HeroListTests",
            dependencies: [
                "CoreDomainContractsTestSupport",
                "HeroListTestSupport",
                ExternalDependencies.snapshotTesting,
            ],
            path: testsPath + "HeroListTests"
        ),
        .target(
            name: "HeroListTestSupport",
            dependencies: [
                "HeroList",
            ],
            path: sourcesPath + "HeroListTestSupport"
        ),

        // HeroDetail library
        .target(
            name: "HeroDetail",
            dependencies: [
                "CoreDomainContracts",
                ExternalDependencies.kingfisher,
                "LeanRedux",
                "Routing"
            ],
            path: sourcesPath + "HeroDetail"
        ),
        .testTarget(
            name: "HeroDetailTests",
            dependencies: [
                "CoreDomainContractsTestSupport",
                "HeroDetailTestSupport",
                "RoutingTestSupport",
                ExternalDependencies.snapshotTesting,
            ],
            path: testsPath + "HeroDetailTests"
        ),
        .target(
            name: "HeroDetailTestSupport",
            dependencies: [
                "CoreDomainContracts",
                "HeroDetail",
            ],
            path: sourcesPath + "HeroDetailTestSupport"
        ),
    ]}
}
