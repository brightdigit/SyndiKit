// swift-tools-version:5.10

import PackageDescription

// swiftlint:disable:next explicit_acl explicit_top_level_acl
let package = Package(
  name: "SyndiKit",
  platforms: [
    .macOS(.v10_15),
    .iOS(.v13),
    .watchOS(.v6),
    .tvOS(.v13)
  ],
  products: [
    .library(
      name: "SyndiKit",
      targets: ["SyndiKit"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/CoreOffice/XMLCoder", from: "0.18.0"),
    .package(url: "https://github.com/swiftlang/swift-testing", exact: "0.5.1")
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
        "SyndiKitTestSupport",
        .product(name: "Testing", package: "swift-testing")
      ]
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
