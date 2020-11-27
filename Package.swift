// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "redirect-module",
    platforms: [
       .macOS(.v10_15)
    ],
    products: [
        .library(name: "RedirectModule", targets: ["RedirectModule"]),
    ],
    dependencies: [
        .package(url: "https://github.com/binarybirds/feather-core", from: "1.0.0-beta"),
    ],
    targets: [
        .target(name: "RedirectModule", dependencies: [
            .product(name: "FeatherCore", package: "feather-core"),
        ], resources: [
            .copy("Bundle"),
        ]),
        .testTarget(name: "RedirectModuleTests", dependencies: [
            .target(name: "RedirectModule"),
        ])
    ]
)
