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
        .enableUpcomingFeature("MemberImportVisibility")
      ]
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
        .enableUpcomingFeature("MemberImportVisibility")
      ]
    ),

    .testTarget(
      name: "SyndiKitXCTests",
      dependencies: [
        "SyndiKit",
        "SyndiKitTestSupport",
        "XMLCoder"
      ],
      path: "Tests/SyndiKitXCTests",
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
        .enableUpcomingFeature("MemberImportVisibility")
      ]
    )
  ]
)
