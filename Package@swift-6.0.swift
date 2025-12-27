// swift-tools-version:6.0

import PackageDescription

// swiftlint:disable:next explicit_acl explicit_top_level_acl
let package = Package(
  name: "SyndiKit",
  platforms: [
    .macOS(.v13),
    .iOS(.v16),
    .watchOS(.v9),
    .tvOS(.v16)
  ],
  products: [
    .library(
      name: "SyndiKit",
      targets: ["SyndiKit"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/brightdigit/XMLCoder", from: "1.0.0-alpha.1")
  ],
  targets: [
    .target(
      name: "SyndiKit",
      dependencies: ["XMLCoder"]
    ),
    .testTarget(
      name: "SyndiKitTests",
      dependencies: ["SyndiKit"]
      // Swift Testing is built into Swift 6.0 toolchain
    )
  ]
)
