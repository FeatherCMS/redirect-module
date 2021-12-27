// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "redirect-module",
    platforms: [
       .macOS(.v12),
    ],
    products: [
        .library(name: "RedirectModule", targets: ["RedirectModule"]),
    ],
    dependencies: [
        .package(url: "https://github.com/FeatherCMS/feather-core", .branch("dev")),
    ],
    targets: [
        .target(name: "RedirectApi", dependencies: [
            .product(name: "FeatherCoreApi", package: "feather-core"),
        ]),
        .target(name: "RedirectModule", dependencies: [
            .product(name: "FeatherCore", package: "feather-core"),
            .target(name: "RedirectApi"),
        ],
        resources: [
//            .copy("Bundle"),
        ]),
    ]
)
