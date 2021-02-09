// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Swiftification",
    platforms: [
        .iOS(.v10),
        .tvOS(.v10),
        .macOS(.v10_11),
    ],
    products: [
        .library(name: "Swiftification", targets: ["Swiftification"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Swiftification",
            dependencies: [],
            resources: [.copy("Resources")]),
        .testTarget(
            name: "SwiftificationTests",
            dependencies: ["Swiftification"],
            resources: [.copy("Resources")]),
    ]
)
