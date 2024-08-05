// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
private let transactionInterface = "SBTransactionInterface"
private let webClientInterface = "SBWebClientInterface"
private let commonModels = "SBCommonModels"
private let foundation = "SBFoundation"

let package = Package(
    name: "SBTransaction",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SBTransaction",
            targets: ["SBTransaction"]),
    ],
    dependencies: [
        .package(name: transactionInterface, path: "../\(transactionInterface)"),
        .package(name: commonModels, path: "../\(commonModels)"),
        .package(name: webClientInterface, path: "../\(webClientInterface)"),
        .package(name: foundation, path: "../\(foundation)")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SBTransaction", dependencies: [
                .product(name: transactionInterface, package: transactionInterface),
                .product(name: commonModels, package: commonModels),
                .product(name: webClientInterface, package: webClientInterface),
                .product(name: foundation, package: foundation)
            ]),
        .testTarget(
            name: "SBTransactionTests",
            dependencies: ["SBTransaction"]),
    ]
)
