// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "Preferences",
  products: [
    .library(
      name: "Preferences",
      targets: ["Preferences"]
    ),
  ],
  targets: [

    .target(
      name: "Preferences",
      dependencies: [
      ],
      path: "Sources"
    ),
    .testTarget(
      name: "PreferencesTests",
      dependencies: ["Preferences"]
    ),
  ],
  swiftLanguageVersions: [.v5]
)
