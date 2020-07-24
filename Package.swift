// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OrchardNest",
    platforms: [.macOS(.v10_12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "OrchardNest",
            targets: ["OrchardNest"]),
      .executable(name: "orcnst", targets: ["orcnst"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/nmdias/FeedKit.git", from: "9.1.0"),
      .package(url: "https://github.com/shibapm/Komondor", from: "1.0.5"),
      .package(url: "https://github.com/eneko/SourceDocs", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(name: "orcnst",
              dependencies: ["OrchardNest"]),
        .target(
            name: "OrchardNest",
            dependencies: ["FeedKit"]),
        .testTarget(
            name: "OrchardNestTests",
            dependencies: ["OrchardNest"]),
    ]
)

#if canImport(PackageConfig)
  import PackageConfig

  let config = PackageConfiguration([
    "komondor": [
      "pre-push": "swift test --enable-code-coverage --enable-test-discovery",
      "pre-commit": [
        "swift test --enable-code-coverage --enable-test-discovery --generate-linuxmain",
        "swift run swiftformat .",
        "swift run swiftlint autocorrect",
        "swift run sourcedocs generate --spm-module OrchardNest -r",
        // "swift run swiftpmls mine",
        "git add .",
        "swift run swiftformat --lint .",
        "swift run swiftlint"
      ]
    ]
  ]).write()
#endif
