// swift-tools-version:5.5
// swiftlint:disable explicit_top_level_acl
import PackageDescription

let package = Package(
  name: "SyndiKit",
  products: [
    .library(
      name: "SyndiKit",
      targets: ["SyndiKit"]
    )
  ],
  // swiftlint:disable line_length
  dependencies: [
    .package(url: "https://github.com/MaxDesiatov/XMLCoder.git", from: "0.12.0"),
//    .package(url: "https://github.com/shibapm/Komondor", from: "1.1.1"), // dev
//    .package(url: "https://github.com/eneko/SourceDocs", from: "1.2.1"), // dev
//    .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.47.0"), // dev
//    .package(url: "https://github.com/realm/SwiftLint", from: "0.43.0"), // dev
//    .package(url: "https://github.com/shibapm/Rocket", from: "1.2.1"), // dev
//    .package(url: "https://github.com/brightdigit/swift-test-codecov", from: "1.0.0") // dev
  ],
  // swiftlint:enable line_length
  targets: [
    .target(
      name: "SyndiKit",
      dependencies: ["XMLCoder"]
    ),
    .testTarget(
      name: "SyndiKitTests",
      dependencies: ["SyndiKit"]
    )
  ]
)

#if canImport(PackageConfig)
  import PackageConfig

  let requiredCoverage: Int = 80

  let config = PackageConfiguration([
    "rocket": [
      "steps": [
        ["hide_dev_dependencies": ["package_path": "Package@swift-5.5.swift"]],
        "hide_dev_dependencies",
        "git_add",
        ["commit": ["no_verify" : true]],
        "tag",
        "unhide_dev_dependencies",
        ["unhide_dev_dependencies": ["package_path": "Package@swift-5.5.swift"]],
        "git_add",
        ["commit": ["message": "Unhide dev dependencies"]]
      ]
    ],
    "komondor": [
      "pre-push": [
        "swift test --enable-code-coverage --enable-test-discovery",
        // swiftlint:disable:next line_length
        "swift run swift-test-codecov .build/debug/codecov/SyndiKit.json --minimum \(requiredCoverage)"
      ],
      "pre-commit": [
        "swift test --enable-code-coverage --enable-test-discovery --generate-linuxmain",
        "swift run swiftformat .",
        "swift run swiftlint autocorrect",
        "swift run sourcedocs generate build --clean --reproducible-docs --all-modules",
        "git add .",
        "swift run swiftformat --lint .",
        "swift run swiftlint"
      ]
    ]
  ]).write()
#endif
