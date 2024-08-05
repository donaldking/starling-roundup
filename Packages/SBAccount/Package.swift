// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let webClientInterface = "SBWebClientInterface"
private let commonModels = "SBCommonModels"
private let accountInterface = "SBAccountInterface"
private let dependencyContainer = "SBDependencyContainer"
private let transactionInterface = "SBTransactionInterface"
private let savingsGoalInterface = "SBSavingsGoalInterface"
private let foundation = "SBFoundation"

let package = Package(
    name: "SBAccount",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SBAccount",
            targets: ["SBAccount"]),
    ],
    dependencies: [
        .package(name: webClientInterface, path: "../\(webClientInterface)"),
        .package(name: commonModels, path: "../\(commonModels)"),
        .package(name: accountInterface, path: "../\(accountInterface)"),
        .package(name: dependencyContainer, path: "../\(dependencyContainer)"),
        .package(name: transactionInterface, path: "../\(transactionInterface)"),
        .package(name: savingsGoalInterface, path: "../\(savingsGoalInterface)"),
        .package(name: foundation, path: "../\(foundation)")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SBAccount", dependencies: [
                .product(name: webClientInterface, package: webClientInterface),
                .product(name: commonModels, package: commonModels),
                .product(name: accountInterface, package: accountInterface),
                .product(name: dependencyContainer, package: dependencyContainer),
                .product(name: transactionInterface, package: transactionInterface),
                .product(name: savingsGoalInterface, package: savingsGoalInterface),
                .product(name: foundation, package: foundation)
            ]),
        .testTarget(
            name: "SBAccountTests",
            dependencies: ["SBAccount"]),
    ]
)
