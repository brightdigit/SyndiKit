<img alt="SyndiKit" title="SyndiKit" src="Assets/logo.svg" height="200">

# SyndiKit

Swift Package built on top of [XMLCoder](https://github.com/CoreOffice/XMLCoder) for Decoding RSS Feeds. Check out the [DocC-Built Site!](https://swiftpackageindex.com/brightdigit/syndikit/~/documentation)

<!-- Platform Compatibility -->
[![Swift Versions](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbrightdigit%2FSyndiKit%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/brightdigit/SyndiKit)
[![Platforms](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbrightdigit%2FSyndiKit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/brightdigit/SyndiKit)

<!-- Documentation & Quality -->
[![Static Badge](https://img.shields.io/badge/-Source_Compatibility-white?logo=swift&link=https%3A%2F%2Fwww.swift.org%2Fdocumentation%2Fsource-compatibility%2F)](https://www.swift.org/documentation/source-compatibility/)
[![Documentation](https://img.shields.io/badge/docc-read_documentation-blue)](https://swiftpackageindex.com/brightdigit/SyndiKit/documentation)
[![License](https://img.shields.io/github/license/brightdigit/SyndiKit)](LICENSE)

<!-- CI/CD & Code Quality -->
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/brightdigit/SyndiKit/syndikit.yml?label=actions&logo=github&?branch=main)](https://github.com/brightdigit/SyndiKit/actions)
[![Maintainability](https://qlty.sh/gh/brightdigit/projects/SyndiKit/maintainability.svg)](https://qlty.sh/gh/brightdigit/projects/SyndiKit)
[![Codecov](https://img.shields.io/codecov/c/github/brightdigit/SyndiKit)](https://codecov.io/gh/brightdigit/SyndiKit)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/brightdigit/SyndiKit)](https://www.codefactor.io/repository/github/brightdigit/SyndiKit)

## Table of Contents


* [Introduction](#introduction)
* [Features](#features)
* [Installation](#installation)
  * [Requirements](#requirements)
  * [Swift Package Manager](#swift-package-manager)
* [Usage](#usage)
  * [Decoding Your First Feed](#decoding-your-first-feed)
  * [Working with Abstractions](#working-with-abstractions)
  * [Specifying Formats](#specifying-formats)
  * [Accessing Extensions](#accessing-extensions)
* [Documentation](#documentation)
* [Roadmap](#roadmap)
* [License](#license)

## Introduction

Built on top of [XMLCoder](https://github.com/CoreOffice/XMLCoder), SyndiKit can be used to import and read site data whether from a WordPress site, RSS feeds, YouTube channel or podcast.

## Features

* Import of RSS 2.0, Atom, and JSONFeed formats
* Extensions for iTunes-compatabile podcasts, YouTube channels, as well as WordPress export data
* User-friendly errors
* Abstractions for format-agnostic parsing

## Installation

### Requirements

**Apple Platforms**

- Xcode 13.3 or later
- Swift 5.5.2 or later
- iOS 15.4 / watchOS 8.5 / tvOS 15.4 / macOS 12.3 or later deployment targets

**Linux**

- Ubuntu 18.04 or later
- Swift 5.5.2 or later

### Swift Package Manager

Swift Package Manager is Apple's decentralized dependency manager to integrate libraries to your Swift projects. It is now fully integrated with Xcode 11.

To integrate **SyndiKit** into your project using SPM, specify it in your Package.swift file:

```swift
let package = Package(
  ...
  dependencies: [
    .package(url: "https://github.com/brightdigit/SyndiKit", from: "0.7.0")
  ],
  targets: [
      .target(
          name: "YourTarget",
          dependencies: ["SyndiKit", ...]),
      ...
  ]
)
```

If this is for an Xcode project simply import the repo at:

```
https://github.com/brightdigit/SyndiKit
```

## Usage

SyndiKit provides models and utilities for decoding RSS feeds of various formats and extensions.

### Decoding Your First Feed

You can get started decoding your feed by creating your first ``SynDecoder``. Once you've created you decoder you can decode using ``SynDecoder/decode(_:)``:

```swift
let decoder = SynDecoder()
let empowerAppsData = Data(contentsOf: "empowerapps-show.xml")!
let empowerAppsRSSFeed = try decoder.decode(empowerAppsData)
```

### Working with Abstractions

Rather than working directly with the various formats, **SyndiKit** abstracts many of the common properties of the various formats. This enables developers to be agnostic regarding the specific format.

```swift
let decoder = SynDecoder()

// decoding a RSS 2.0 feed
let empowerAppsData = Data(contentsOf: "empowerapps-show.xml")!
let empowerAppsRSSFeed = try decoder.decode(empowerAppsData)
print(empowerAppsRSSFeed.title) // Prints "Empower Apps"

// decoding a Atom feed from YouTube
let kiloLocoData = Data(contentsOf: "kilo.youtube.xml")!
let kiloLocoAtomFeed = try decoder.decode(kiloLocoData)
print(kiloLocoAtomFeed.title) // Prints "Kilo Loco"
```

### Specifying Formats

If you wish to access properties of specific formats, you can attempt to cast the objects to see if they match:

```swift
let empowerAppsRSSFeed = try decoder.decode(empowerAppsData)
if let rssFeed = empowerAppsRSSFeed as? RSSFeed {
  print(rssFeed.channel.title) // Prints "Empower Apps"
}

let kiloLocoAtomFeed = try decoder.decode(kiloLocoData)
if let atomFeed = kiloLocoAtomFeed as? AtomFeed {
  print(atomFeed.title) // Prints "Empower Apps"
}
```

### Accessing Extensions

In addition to supporting RSS, Atom, and JSONFeed, **SyndiKit** also supports various RSS extensions for specific media including: YouTube, iTunes, and WordPress.

You can access these properties via their specific feed formats or via the ``Entryable/media`` property on ``Entryable``.

```swift
let empowerAppsRSSFeed = try decoder.decode(empowerAppsData)
switch empowerAppsRSSFeed.children.last?.media {
  case .podcast(let podcast):
    print(podcast.title) // print "WWDC 2018 - What Does It Mean For Businesses?"
  default:
    print("Not a Podcast! 🤷‍♂️")
}

let kiloLocoAtomFeed = try decoder.decode(kiloLocoData)
switch kiloLocoAtomFeed.children.last?.media {
  case .video(.youtube(let youtube):
    print(youtube.videoID) // print "SBJFl-3wqx8"
    print(youtube.channelID) // print "UCv75sKQFFIenWHrprnrR9aA"
  default:
    print("Not a Youtube Video! 🤷‍♂️")
}
```

## Documentation

[The **DocC** is hosted at **Swift Package Index**.](https://swiftpackageindex.com/brightdigit/SyndiKit/documentation) This includes tutorials, articles, code documentation and more.

## Roadmap

## 1.0.0

- [x] OPML Support
- [ ] WordPress DocC Tutorial
- [ ] RSS Import Tutorial (i.e. [Celestra](https://celestr.app))

## License

This code is distributed under the MIT license. See the [LICENSE](LICENSE) file for more info.
