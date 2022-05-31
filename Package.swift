// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "Preferences",
    products: [
        .library(
            name: "Preferences",
            targets: ["Preferences"]
        ),
        .library(
            name: "PreferencesForSwiftUI",
            targets: ["PreferencesForSwiftUI"]
        ),
    ],
    targets: [
        .target(
            name: "Preferences",
            dependencies: [
            ]
        ),
        .target(
            name: "PreferencesForSwiftUI",
            dependencies: [
                "Preferences",
            ]
        ),
        .testTarget(
            name: "PreferencesTests",
            dependencies: ["Preferences"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
