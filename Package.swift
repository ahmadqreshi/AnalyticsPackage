// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LaAnalytics",
    platforms: [
            .iOS(.v13)
        ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "LaAnalytics",
            targets: ["LaAnalytics"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/moengage/MoEngage-iOS-SDK.git", from: "9.3.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.4.0"),
        .package(url: "https://github.com/facebook/facebook-ios-sdk.git", from: "15.1.0"),
        .package(url: "https://github.com/uxcam/ios-sdk.git", from: "3.5.2")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "LaAnalytics",
            dependencies: [
                .product(name: "MoEngage-iOS-SDK", package: "MoEngage-iOS-SDK"),
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
                .product(name: "FacebookCore", package: "facebook-ios-sdk"),
                .product(name: "UXCam", package: "ios-sdk")
            ],
            path: "Sources"),
        .testTarget(
            name: "LaAnalyticsTests",
            dependencies: ["LaAnalytics"]),
    ]
)
