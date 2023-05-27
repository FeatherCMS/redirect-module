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
		.package(path: "../feather-core"),
		.package(path: "../redirect-objects"),
//        .package(url: "https://github.com/FeatherCMS/feather-core", .branch("dev")),
//        .package(url: "https://github.com/FeatherCMS/redirect-objects", .branch("main")),
    ],
    targets: [
        .target(name: "RedirectModule", dependencies: [
            .product(name: "FeatherCore", package: "feather-core"),
            .product(name: "RedirectObjects", package: "redirect-objects"),
        ],
        resources: [
//            .copy("Bundle"),
        ]),
    ]
)
