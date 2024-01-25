// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(
            name: "Styles",
            targets: ["Styles"]),
        .library(
            name: "Analytics",
            targets: ["Analytics"]),
        .library(
            name: "Network",
            targets: ["Network"]),
        .library(
            name: "FlixCore",
            targets: ["FlixCore"])
    ],
    targets: [
        .target(
            name: "Styles"),
        .target(
            name: "Analytics"),
        .target(
            name: "Network"),
        .target(
            name: "FlixCore", dependencies: ["Network"]),
        .testTarget(name: "NetworkTests", dependencies: ["Network"]),
    ]
)
