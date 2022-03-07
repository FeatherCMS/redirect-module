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
        .package(url: "https://github.com/FeatherCMS/redirect-api", .branch("main")),
    ],
    targets: [
        .target(name: "RedirectModule", dependencies: [
            .product(name: "Feather", package: "feather-core"),
            .product(name: "RedirectApi", package: "redirect-api"),
        ],
        resources: [
//            .copy("Bundle"),
        ]),
    ]
)
