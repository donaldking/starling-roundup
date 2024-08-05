// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let webClientInterface = "SBWebClientInterface"

let package = Package(
    name: "SBAccountInterface",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SBAccountInterface",
            targets: ["SBAccountInterface"]),
    ],
    dependencies: [
        .package(name: webClientInterface, path: "../\(webClientInterface)")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SBAccountInterface", dependencies: [
                .product(name: webClientInterface, package: webClientInterface)
            ])
    ]
)
