// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ViewControllerTransitioningDelegator",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "ViewControllerTransitioningDelegator",
            targets: ["ViewControllerTransitioningDelegator"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ViewControllerTransitioningDelegator",
            dependencies: []),
    ],
    swiftLanguageVersions: [.v5]
)
