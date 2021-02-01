// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "OrchardNest",
  platforms: [.macOS(.v10_15)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "OrchardNestKit",
      targets: ["OrchardNestKit"]
    ),
    .library(
      name: "OrchardNestServer",
      targets: ["OrchardNestServer"]
    ),
    .executable(name: "orchardnestd", targets: ["orchardnestd"])
  ],
  dependencies: [
    .package(url: "https://github.com/brightdigit/FeedKit.git", .branch("master")),
    .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
    .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
    .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.0.0"),
    .package(name: "QueuesFluentDriver", url: "https://github.com/m-barthelemy/vapor-queues-fluent-driver.git", from: "0.3.8"),
    .package(name: "Plot", url: "https://github.com/johnsundell/plot.git", from: "0.8.0"),
    .package(url: "https://github.com/JohnSundell/Ink.git", from: "0.1.0"),
    .package(url: "https://github.com/shibapm/Komondor", from: "1.0.6"), // dev
    .package(url: "https://github.com/eneko/SourceDocs", from: "1.2.1"), // dev
    .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.47.0"), // dev
    .package(url: "https://github.com/realm/SwiftLint", from: "0.41.0"), // dev
    .package(url: "https://github.com/brightdigit/Rocket", .branch("feature/yams-4.0.0")), // dev
    .package(url: "https://github.com/mattpolzin/swift-test-codecov", .branch("master")) // dev
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "OrchardNestKit",
      dependencies: ["FeedKit"]
    ),
    .target(
      name: "OrchardNestServer",
      dependencies: ["OrchardNestKit",
                     .product(name: "Fluent", package: "fluent"),
                     .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                     .product(name: "Vapor", package: "vapor"),
                     .product(name: "QueuesFluentDriver", package: "QueuesFluentDriver"),
                     .product(name: "Plot", package: "Plot"),
                     .product(name: "Ink", package: "Ink")]
    ),
    .target(name: "orchardnestd",
            dependencies: ["OrchardNestKit", "OrchardNestServer", "FeedKit"]),
    .testTarget(
      name: "OrchardNestKitTests",
      dependencies: ["OrchardNestKit"]
    )
  ]
)

#if canImport(PackageConfig)
  import PackageConfig

  let requiredCoverage: Int = 0

  let config = PackageConfiguration([
    "komondor": [
      "pre-push": [
        "swift test --enable-code-coverage --enable-test-discovery",
        "swift run swift-test-codecov .build/debug/codecov/OrchardNest.json -v \(requiredCoverage)"
      ],
      "pre-commit": [
        "swift test --enable-code-coverage --enable-test-discovery --generate-linuxmain",
        "swift run swiftformat .",
        "swift run swiftlint autocorrect",
        "swift run sourcedocs generate build -cra",
        "git add .",
        "swift run swiftformat --lint .",
        "swift run swiftlint"
      ]
    ]
  ]).write()
#endif
