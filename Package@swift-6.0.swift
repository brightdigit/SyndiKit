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
    .package(url: "https://github.com/CoreOffice/XMLCoder", from: "0.18.0")
  ],
  targets: [
    .target(
      name: "SyndiKit",
      dependencies: ["XMLCoder"]
    ),

    .target(
      name: "SyndiKitTestSupport",
      dependencies: [
        "SyndiKit",
        "XMLCoder"
      ],
      path: "Tests/SyndiKitTestSupport"
    ),

    .testTarget(
      name: "SyndiKitTests",
      dependencies: [
        "SyndiKit",
        "SyndiKitTestSupport"
      ]
      // Swift Testing is built into Swift 6.0 toolchain
    ),

    .testTarget(
      name: "SyndiKitXCTests",
      dependencies: [
        "SyndiKit",
        "SyndiKitTestSupport",
        "XMLCoder"
      ],
      path: "Tests/SyndiKitXCTests"
    )
  ]
)
