// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OrchardNest",
    platforms: [
        .macOS(.v10_12), //FIXME strictly 10.10 (only tests need 10.12)
        .iOS(.v10),      //FIXME strictly 8.0
        .tvOS(.v10),     //FIXME strictly 9.0
        .watchOS(.v2)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .executable(
            name: "OrchardNest",
            targets: ["OrchardNest"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/mxcl/PromiseKit", from: "7.0.0-alpha3")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "OrchardNest",
            dependencies: ["PromiseKit"]),
        .testTarget(
            name: "OrchardNestTests",
            dependencies: ["OrchardNest"]),
    ]
)
