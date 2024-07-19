// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "BatchedCollection",
    products: [
        .library(
            name: "BatchedCollection",
            targets: ["BatchedCollection"]),
    ],
    targets: [
        .target(
            name: "BatchedCollection"),
        .testTarget(
            name: "BatchedCollectionTests",
            dependencies: ["BatchedCollection"]),
    ]
)
