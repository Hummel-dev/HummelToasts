// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HummelToasts",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "HummelConfirmationDialogs",
            targets: ["ToastsFoundation"]
        ),
    ],
    targets: [
        .foundation(),
    ]
)

extension Target {
    static func foundation() -> Target {
        .target(
            name: "ToastsFoundation",
            path: "./Sources/Foundation"
        )
    }
}
