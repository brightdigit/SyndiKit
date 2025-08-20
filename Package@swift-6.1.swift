// swift-tools-version:6.1

import PackageDescription

// swiftlint:disable:next explicit_acl explicit_top_level_acl
let package = Package(
  name: "SyndiKit",
  platforms: [
    .macOS(.v13)
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
      dependencies: ["XMLCoder"],
      swiftSettings: [
        // Upcoming features that are not yet enabled by default in Swift 6
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("StrictConcurrency"),
        .enableUpcomingFeature("TransferringArgsAndResults"),
        .enableUpcomingFeature("TypedThrows"),
        .enableUpcomingFeature("VariadicGenerics"),
        .enableUpcomingFeature("AccessLevelOnImport"),
        .enableUpcomingFeature("DisableAvailabilityChecking"),
        .enableUpcomingFeature("FullTypedThrows"),
        .enableUpcomingFeature("MoveOnlyClasses"),
        .enableUpcomingFeature("NoImplicitCopy"),
        .enableUpcomingFeature("OldOwnershipOperatorSpelling"),
        .enableUpcomingFeature("OneWayClosureParameters"),
        .enableUpcomingFeature("PackageDescriptionAPI"),
        .enableUpcomingFeature("PreliminaryConcurrency"),
        .enableUpcomingFeature("ReferenceBindings"),
        .enableUpcomingFeature("SendingArgsAndResults"),
        .enableUpcomingFeature("Swift6Concurrency"),
        .enableUpcomingFeature("Swift6ImplicitCopy"),
        .enableUpcomingFeature("Swift6Language"),
        .enableUpcomingFeature("Swift6Mode"),
        .enableUpcomingFeature("UnavailableFromAsync"),
        .enableUpcomingFeature("VoidResultBuilder"),
        .enableUpcomingFeature("YieldsIsolated"),
        // Additional upcoming features from SE proposals
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableUpcomingFeature("NonescapableTypes"),
        .enableUpcomingFeature("MemberImportVisibility"),
        // Experimental features
        .enableExperimentalFeature("AccessLevelOnImport"),
        .enableExperimentalFeature("ExistentialAny"),
        .enableExperimentalFeature("StrictConcurrency"),
        .enableExperimentalFeature("TransferringArgsAndResults"),
        .enableExperimentalFeature("TypedThrows"),
        .enableExperimentalFeature("VariadicGenerics")
      ]
    ),
    .testTarget(
      name: "SyndiKitTests",
      dependencies: ["SyndiKit"],
      swiftSettings: [
        // Upcoming features that are not yet enabled by default in Swift 6
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("StrictConcurrency"),
        .enableUpcomingFeature("TransferringArgsAndResults"),
        .enableUpcomingFeature("TypedThrows"),
        .enableUpcomingFeature("VariadicGenerics"),
        .enableUpcomingFeature("AccessLevelOnImport"),
        .enableUpcomingFeature("DisableAvailabilityChecking"),
        .enableUpcomingFeature("FullTypedThrows"),
        .enableUpcomingFeature("MoveOnlyClasses"),
        .enableUpcomingFeature("NoImplicitCopy"),
        .enableUpcomingFeature("OldOwnershipOperatorSpelling"),
        .enableUpcomingFeature("OneWayClosureParameters"),
        .enableUpcomingFeature("PackageDescriptionAPI"),
        .enableUpcomingFeature("PreliminaryConcurrency"),
        .enableUpcomingFeature("ReferenceBindings"),
        .enableUpcomingFeature("SendingArgsAndResults"),
        .enableUpcomingFeature("Swift6Concurrency"),
        .enableUpcomingFeature("Swift6ImplicitCopy"),
        .enableUpcomingFeature("Swift6Language"),
        .enableUpcomingFeature("Swift6Mode"),
        .enableUpcomingFeature("UnavailableFromAsync"),
        .enableUpcomingFeature("VoidResultBuilder"),
        .enableUpcomingFeature("YieldsIsolated"),
        // Additional upcoming features from SE proposals
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableUpcomingFeature("NonescapableTypes"),
        .enableUpcomingFeature("MemberImportVisibility"),
        // Experimental features
        .enableExperimentalFeature("AccessLevelOnImport"),
        .enableExperimentalFeature("ExistentialAny"),
        .enableExperimentalFeature("StrictConcurrency"),
        .enableExperimentalFeature("TransferringArgsAndResults"),
        .enableExperimentalFeature("TypedThrows"),
        .enableExperimentalFeature("VariadicGenerics"),
      ]
    )
  ]
)
