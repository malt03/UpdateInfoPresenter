// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UpdateInfoPresenter",
    platforms: [
        .iOS(.v9),
    ],
    products: [
        .library(name: "UpdateInfoPresenter", targets: ["UpdateInfoPresenter"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "UpdateInfoPresenter", dependencies: []),
        .testTarget(name: "UpdateInfoPresenterTests", dependencies: ["UpdateInfoPresenter"]),
    ]
)
