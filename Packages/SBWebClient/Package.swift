// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let webClientInterface = "SBWebClientInterface"
private let network = "SBNetwork"

let package = Package(
    name: "SBWebClient",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SBWebClient",
            targets: ["SBWebClient"]),
    ],
    dependencies: [
        .package(name: webClientInterface, path: "../\(webClientInterface)"),
        .package(name: network, path: "../\(network)"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SBWebClient", dependencies: [
                .product(name: webClientInterface, package: webClientInterface),
                .product(name: network, package: network),
            ]),
        .testTarget(
            name: "SBWebClientTests",
            dependencies: ["SBWebClient"]),
    ]
)
