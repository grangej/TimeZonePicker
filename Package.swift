// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TimeZonePicker",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "TimeZonePicker",
            targets: ["TimeZonePicker"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "TimeZonePicker",
            path: "TimeZonePicker",
            exclude: ["Info.plist"],
            resources: [
                .process("Resources/all_cities_adj.plist")]
        ),
        .testTarget(
            name: "TimeZonePickerTests",
            dependencies: ["TimeZonePicker"],
            path: "TimeZonePickerTests",
            exclude: ["Info.plist"]
        )
    ]
)

