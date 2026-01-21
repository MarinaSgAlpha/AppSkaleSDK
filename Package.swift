// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppSkaleSDK",
    platforms: [
        .iOS(.v14)  // Minimum iOS 14.3 as per your podspec
    ],
    products: [
        // The main library product that developers will import
        .library(
            name: "AppSkaleSDK",
            targets: ["AppSkaleSDK"]
        ),
    ],
    dependencies: [
        // Optional: Add RevenueCat dependency if you want to support it directly
        // Uncomment this line if you want SPM users to automatically get RevenueCat
        // .package(url: "https://github.com/RevenueCat/purchases-ios.git", from: "4.0.0"),
    ],
    targets: [
        // Main SDK target
        .target(
            name: "AppSkaleSDK",
            dependencies: [
                // Uncomment if you enabled RevenueCat dependency above
                // .product(name: "RevenueCat", package: "purchases-ios"),
            ],
            path: "AppSkaleSDK/Classes",
            exclude: [],
            sources: nil,  // Will automatically include all .swift files in path
            publicHeadersPath: nil,
            cSettings: nil,
            cxxSettings: nil,
            swiftSettings: [
                .define("SPM_BUILD", .when(platforms: [.iOS]))
            ],
            linkerSettings: [
                .linkedFramework("AdServices"),
                .linkedFramework("StoreKit"),
                .linkedFramework("Foundation")
            ]
        ),
        
        // Test target (optional but recommended)
        .testTarget(
            name: "AppSkaleSDKTests",
            dependencies: ["AppSkaleSDK"],
            path: "Example/Tests"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
