import ProjectDescription

let project = Project(
    name: "WallaMarvel",
    packages: [
        .package(path: "."),
    ],
    settings: .settings(configurations: [
        .debug(name: "Debug", xcconfig: "./Resources/WallaMarvel-Project.xcconfig"),
        .release(name: "Release", xcconfig: "./Resources/WallaMarvel-Project.xcconfig"),
    ]),
    targets: [
        .target(
            name: "WallaMarvel",
            destinations: .iOS,
            product: .app,
            bundleId: "com.wallapop.WallaMarvel",
            infoPlist: .file(path: "Resources/Info.plist"),
            sources: ["Sources/Application/WallaMarvel/**"],
            resources: [
                "Resources/Assets.xcassets",
                "Resources/Base.lproj/LaunchScreen.storyboard",
            ],
            dependencies: [
                .package(product: "CoreDomain", type: .runtime, condition: nil),
                .package(product: "HeroList", type: .runtime, condition: nil),
                .package(product: "HeroDetail", type: .runtime, condition: nil),
            ],
            settings: .settings(configurations: [
                .debug(name: "Debug", xcconfig: "./Resources/WallaMarvel-Target.xcconfig"),
                .release(name: "Release", xcconfig: "./Resources/WallaMarvel-Target.xcconfig"),
            ])
        ),
        .target(
            name: "CoreDomainTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.wallapop.CoreDomainTests",
            sources: ["Tests/Domain/CoreDomainTests/**"],
            dependencies: [
                .package(product: "CoreDomain", type: .runtime, condition: nil),
            ]
        ),
        .target(
            name: "LeanReduxTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.wallapop.LeanReduxTests",
            sources: ["Tests/Core/LeanReduxTests/**"],
            dependencies: [
                .package(product: "LeanRedux", type: .runtime, condition: nil),
            ]
        ),
        .target(
            name: "NetworkingTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.wallapop.NetworkingTests",
            sources: ["Tests/Core/NetworkingTests/**"],
            dependencies: [
                .package(product: "Networking", type: .runtime, condition: nil),
                .package(product: "Collections", type: .runtime, condition: nil),
            ]
        ),
        .target(
            name: "HeroDetailTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.wallapop.HeroDetailTests",
            sources: ["Tests/Features/HeroDetailTests/**"],
            dependencies: [
                .package(product: "HeroDetail", type: .runtime, condition: nil),
                .package(product: "CoreDomain", type: .runtime, condition: nil),
                .package(product: "Routing", type: .runtime, condition: nil),
                .package(product: "SnapshotTesting", type: .runtime, condition: nil),
            ]
        ),
    ]
)
