// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TFL_v2",
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git", .upToNextMajor(from: "1.1.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "TFL_v2",
            dependencies: [
                .product(name: "Collections", package: "swift-collections")
            ]
        )
    ]
)
