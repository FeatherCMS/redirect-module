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
//		.package(path: "../feather-core"),
//		.package(path: "../redirect-objects"),
        .package(url: "https://github.com/Rando-Coderissian/feather-core", .branch("test-refactored-modules")),
        .package(url: "https://github.com/Rando-Coderissian/redirect-objects", .branch("test-refactor-modules")),
		
//        .package(url: "https://github.com/feathercms/feather-core", .branch("dev")),
//        .package(url: "https://github.com/feathercms/redirect-objects", .branch("main")),
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
