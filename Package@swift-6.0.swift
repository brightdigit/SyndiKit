// swift-tools-version:6.0

import PackageDescription

// MARK: - Swift Feature Flags

// Upcoming features that will be enabled in Swift 7, but we want to adopt early in Swift 6.0
// Note: Features already enabled in Swift 6.0 (like StrictConcurrency) should NOT be listed here
let swift6_0Features: [SwiftSetting] = [
  // Swift 7 upcoming features (enabled_in: "7")
  .enableUpcomingFeature("ExistentialAny"),
  .enableUpcomingFeature("InternalImportsByDefault"),
  .enableUpcomingFeature("MemberImportVisibility"),
  .enableUpcomingFeature("InferIsolatedConformances"),
  .enableUpcomingFeature("NonisolatedNonsendingByDefault"),

  // Experimental features
  .enableUpcomingFeature("FullTypedThrows")
]

// Additional features for Swift 6.1+ when Package@swift-6.1.swift is created
// These features may become available as upcoming or be promoted to experimental status
let swift6_1AdditionalFeatures: [SwiftSetting] = [
  // Placeholder for future features that become available in Swift 6.1+
  // Check `swift -print-supported-features` for the latest list
]

// Features already enabled by default in Swift 6.0 (DO NOT enable these):
// - ConciseMagicFile
// - ForwardTrailingClosures
// - StrictConcurrency ⚠️ (This was causing build errors)
// - BareSlashRegexLiterals
// - DeprecateApplicationMain
// - ImportObjcForwardDeclarations
// - DisableOutwardActorInference
// - IsolatedDefaultValues
// - GlobalConcurrency
// - InferSendableFromCaptures
// - ImplicitOpenExistentials
// - RegionBasedIsolation
// - DynamicActorIsolation
// - NonfrozenEnumExhaustivity
// - GlobalActorIsolatedTypesUsability

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
      dependencies: ["XMLCoder"],
      swiftSettings: swift6_0Features
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
      ],
      // Swift Testing is built into Swift 6.0 toolchain
      swiftSettings: swift6_0Features
    ),

    .testTarget(
      name: "SyndiKitXCTests",
      dependencies: [
        "SyndiKit",
        "SyndiKitTestSupport",
        "XMLCoder"
      ],
      path: "Tests/SyndiKitXCTests",
      swiftSettings: swift6_0Features
    )
  ]
)
