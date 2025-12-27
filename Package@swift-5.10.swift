// swift-tools-version:5.10

import PackageDescription

// swiftlint:disable:next explicit_acl explicit_top_level_acl
let package = Package(
  name: "SyndiKit",
  products: [
    .library(
      name: "SyndiKit",
      targets: ["SyndiKit"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/brightdigit/XMLCoder", from: "1.0.0-alpha.1"),
    .package(url: "https://github.com/swiftlang/swift-testing", from: "0.6.0")
  ],
  targets: [
    .target(
      name: "SyndiKit",
      dependencies: ["XMLCoder"]
    ),
    .testTarget(
      name: "SyndiKitTests",
      dependencies: [
        "SyndiKit",
        .product(name: "Testing", package: "swift-testing")
      ]
    )
  ]
)
