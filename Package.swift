// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyPackage",
    dependencies: [
        .package(url: "https://github.com/mongodb/mongo-swift-driver.git", from: "0.0.0"),
    ],
    targets: [
        // Async module
        .target(name: "MyAsyncTarget", dependencies: ["MongoSwift"]),
        // Sync module
        .target(name: "MySyncTarget", dependencies: ["MongoSwiftSync"])
    ]
)
