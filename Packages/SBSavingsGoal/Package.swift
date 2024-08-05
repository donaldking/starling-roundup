// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let commonModels = "SBCommonModels"
private let savingsGoalInterface = "SBSavingsGoalInterface"
private let webClient = "SBWebClientInterface"
private let foundation = "SBFoundation"

let package = Package(
    name: "SBSavingsGoal",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SBSavingsGoal",
            targets: ["SBSavingsGoal"]),
    ],
    dependencies: [
        .package(name: commonModels, path: "../\(commonModels)"),
        .package(name: savingsGoalInterface, path: "../\(savingsGoalInterface)"),
        .package(name: webClient, path: "../\(webClient)"),
        .package(name: foundation, path: "../\(foundation)"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SBSavingsGoal", dependencies: [
                .product(name: commonModels, package: commonModels),
                .product(name: savingsGoalInterface, package: savingsGoalInterface),
                .product(name: webClient, package: webClient),
                .product(name: foundation, package: foundation),
            ]),
        .testTarget(
            name: "SBSavingsGoalTests",
            dependencies: ["SBSavingsGoal"]),
    ]
)
