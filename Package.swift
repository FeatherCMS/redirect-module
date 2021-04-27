// swift-tools-version:5.3
import PackageDescription

let isLocalTestMode = false

var deps: [Package.Dependency] = [
    .package(url: "https://github.com/FeatherCMS/feather-core", .branch("main")), //from: "1.0.0-beta"),
]

var targets: [Target] = [
    .target(name: "RedirectModuleApi"),
    .target(name: "RedirectModule", dependencies: [
        .product(name: "FeatherCore", package: "feather-core"),
        .target(name: "RedirectModuleApi"),
    ],
    resources: [
        .copy("Bundle"),
    ]),
]

// @NOTE: https://bugs.swift.org/browse/SR-8658
if isLocalTestMode {
    deps.append(contentsOf: [
        /// drivers
        .package(url: "https://github.com/vapor/fluent-sqlite-driver", from: "4.0.0"),
        .package(url: "https://github.com/binarybirds/liquid-local-driver", from: "1.2.0"),
    ])
    targets.append(contentsOf: [
        .target(name: "Feather", dependencies: [
            /// drivers
            .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
            .product(name: "LiquidLocalDriver", package: "liquid-local-driver"),
            .target(name: "RedirectModule"),
        ]),
        .testTarget(name: "RedirectModuleTests", dependencies: [
            .target(name: "RedirectModule"),
        ])
    ])
}

let package = Package(
    name: "redirect-module",
    platforms: [
       .macOS(.v10_15)
    ],
    products: [
        .library(name: "RedirectModule", targets: ["RedirectModule"]),
    ],
    dependencies: deps,
    targets: targets
)
