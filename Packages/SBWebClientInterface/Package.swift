// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let commonModels = "SBCommonModels"

let package = Package(
    name: "SBWebClientInterface",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SBWebClientInterface",
            targets: ["SBWebClientInterface"]),
    ],
    dependencies: [
        .package(name: commonModels, path: "../\(commonModels)")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SBWebClientInterface", dependencies: [
                .product(name: commonModels, package: commonModels)
            ])
    ]
)
