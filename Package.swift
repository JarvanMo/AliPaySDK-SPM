// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "AlipaySDK",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "AlipaySDK",
            targets: ["AlipaySDK", "AlipaySDKSupport"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "AlipaySDK",
            path: "AlipaySDK/AlipaySDK.xcframework"
        ),
        .target(
            name: "AlipaySDKSupport",
            dependencies: ["AlipaySDK"],
            path: "AlipaySDK",
            exclude: [
                "AlipaySDK.xcframework",
            ],
            resources: [
                .copy("AlipaySDK.bundle"),
            ],
            linkerSettings: [
                .linkedFramework("CFNetwork"),
                .linkedFramework("CoreGraphics"),
                .linkedFramework("CoreTelephony"),
                .linkedFramework("Foundation"),
                .linkedFramework("Network"),
                .linkedFramework("QuartzCore"),
                .linkedFramework("Security"),
                .linkedFramework("SystemConfiguration"),
                .linkedFramework("UIKit"),
                .linkedFramework("WebKit"),
                .linkedLibrary("c++"),
                .linkedLibrary("z"),
            ]
        ),
    ]
)
