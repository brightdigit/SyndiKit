// swift-tools-version:6.1

import PackageDescription


// MARK: - Swift Settings Configuration
let swiftSettings: [SwiftSetting] = [
    // Swift 6.2 Upcoming Features (not yet enabled by default)
    .enableUpcomingFeature("ExistentialAny"),                    // SE-0335: Introduce existential `any`
    .enableUpcomingFeature("InternalImportsByDefault"),          // SE-0409: Access-level modifiers on import declarations  
    .enableUpcomingFeature("MemberImportVisibility"),            // SE-0444: Member import visibility (Swift 6.1+)
    .enableUpcomingFeature("FullTypedThrows"),                   // SE-0413: Typed throws

    // Experimental Features (stable enough for use)
    .enableExperimentalFeature("BitwiseCopyable"),               // SE-0426: BitwiseCopyable protocol
    .enableExperimentalFeature("BorrowingSwitch"),               // SE-0432: Borrowing and consuming pattern matching for noncopyable types
    .enableExperimentalFeature("ExtensionMacros"),               // Extension macros
    .enableExperimentalFeature("FreestandingExpressionMacros"),  // Freestanding expression macros
    .enableExperimentalFeature("InitAccessors"),                 // Init accessors
    .enableExperimentalFeature("IsolatedAny"),                   // Isolated any types
    .enableExperimentalFeature("MoveOnlyClasses"),               // Move-only classes
    .enableExperimentalFeature("MoveOnlyEnumDeinits"),           // Move-only enum deinits
    .enableExperimentalFeature("MoveOnlyPartialConsumption"),    // SE-0429: Partial consumption of noncopyable values
    .enableExperimentalFeature("MoveOnlyResilientTypes"),        // Move-only resilient types
    .enableExperimentalFeature("MoveOnlyTuples"),                // Move-only tuples
    .enableExperimentalFeature("NoncopyableGenerics"),           // SE-0427: Noncopyable generics
    .enableExperimentalFeature("OneWayClosureParameters"),       // One-way closure parameters
    .enableExperimentalFeature("RawLayout"),                     // Raw layout types
    .enableExperimentalFeature("ReferenceBindings"),             // Reference bindings
    .enableExperimentalFeature("SendingArgsAndResults"),         // SE-0430: sending parameter and result values
    .enableExperimentalFeature("SymbolLinkageMarkers"),          // Symbol linkage markers
    .enableExperimentalFeature("TransferringArgsAndResults"),    // Transferring args and results
    .enableExperimentalFeature("VariadicGenerics"),              // SE-0393: Value and Type Parameter Packs
    .enableExperimentalFeature("WarnUnsafeReflection"),          // Warn unsafe reflection

    // Enhanced compiler checking
    .unsafeFlags([
        "-warn-concurrency",                    // Enable concurrency warnings
        "-enable-actor-data-race-checks",       // Enable actor data race checks
        "-strict-concurrency=complete",         // Complete strict concurrency checking
        "-enable-testing",                      // Enable testing support
        "-Xfrontend", "-warn-long-function-bodies=100",       // Warn about functions with >100 lines
        "-Xfrontend", "-warn-long-expression-type-checking=100" // Warn about slow type checking expressions
    ])
]

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
      swiftSettings: swiftSettings
    ),
    .testTarget(
      name: "SyndiKitTests",
      dependencies: ["SyndiKit"],
      swiftSettings: swiftSettings
    )
  ]
)
