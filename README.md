<p align="center">
    <img alt="SyndiKit" title="SyndiKit" src="Assets/logo.svg" height="200">
</p>
<h1 align="center"> <a href="https://syndikit.dev/">SyndiKit</a> </h1>

Swift Package built on top of [XMLCoder](https://github.com/MaxDesiatov/XMLCoder) for Decoding RSS Feeds. Check out the [DocC-Built Site!](https://syndikit.dev/)

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbrightdigit%2FSyndiKit%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/brightdigit/SyndiKit)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbrightdigit%2FSyndiKit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/brightdigit/SyndiKit)
[![DocC](https://img.shields.io/badge/DocC-read-success?logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOBAMAAADtZjDiAAAEsmlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNS41LjAiPgogPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgeG1sbnM6ZXhpZj0iaHR0cDovL25zLmFkb2JlLmNvbS9leGlmLzEuMC8iCiAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyIKICAgIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIKICAgIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIKICAgIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIgogICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgZXhpZjpQaXhlbFhEaW1lbnNpb249IjE0IgogICBleGlmOlBpeGVsWURpbWVuc2lvbj0iMTQiCiAgIGV4aWY6Q29sb3JTcGFjZT0iMSIKICAgdGlmZjpJbWFnZVdpZHRoPSIxNCIKICAgdGlmZjpJbWFnZUxlbmd0aD0iMTQiCiAgIHRpZmY6UmVzb2x1dGlvblVuaXQ9IjIiCiAgIHRpZmY6WFJlc29sdXRpb249Ijk2LjAiCiAgIHRpZmY6WVJlc29sdXRpb249Ijk2LjAiCiAgIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiCiAgIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIKICAgeG1wOk1vZGlmeURhdGU9IjIwMjEtMDgtMDRUMTU6MzA6MjUtMDQ6MDAiCiAgIHhtcDpNZXRhZGF0YURhdGU9IjIwMjEtMDgtMDRUMTU6MzA6MjUtMDQ6MDAiPgogICA8eG1wTU06SGlzdG9yeT4KICAgIDxyZGY6U2VxPgogICAgIDxyZGY6bGkKICAgICAgc3RFdnQ6YWN0aW9uPSJwcm9kdWNlZCIKICAgICAgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWZmaW5pdHkgRGVzaWduZXIgMS45LjMiCiAgICAgIHN0RXZ0OndoZW49IjIwMjEtMDgtMDRUMTU6MzA6MjUtMDQ6MDAiLz4KICAgIDwvcmRmOlNlcT4KICAgPC94bXBNTTpIaXN0b3J5PgogIDwvcmRmOkRlc2NyaXB0aW9uPgogPC9yZGY6UkRGPgo8L3g6eG1wbWV0YT4KPD94cGFja2V0IGVuZD0iciI/PmJ/d+MAAAGCaUNDUHNSR0IgSUVDNjE5NjYtMi4xAAAokXWRzytEURTHP/NDJkaEhYXFpBmrIT9qYqPMpKEmTWOUwWbmmR9qfrzem0mTrbKdosTGrwV/AVtlrRSRkp2yJjboOc+okcy5nXs+93vvOd17LlijWSWn2wcgly9qkaDfNRebdzU+4sBOOx7ccUVXx8PhEHXt7QaLGa/6zFr1z/1rzUtJXQGLQ3hMUbWi8KRwaKWomrwp3Klk4kvCx8JeTS4ofG3qiSo/mZyu8ofJWjQSAGubsCv9ixO/WMloOWF5Oe5ctqT83Md8iTOZn52R2CPejU6EIH5cTDFBAB+DjMrso48h+mVFnfyB7/xpCpKryKxSRmOZNBmKeEUtSfWkxJToSRlZymb///ZVTw0PVas7/dDwYBgvHmjcgM+KYbzvG8bnAdju4Sxfyy/swcir6JWa5t6F1jU4Oa9piS04XYeuOzWuxb8lm7g1lYLnI2iJQcclNC1Ue/azz+EtRFflqy5gewd65Xzr4hdYDGff+AQ5OQAAADBQTFRFDGnVkeT/Arf8AAAADUa77vr/DZX9Y9X/A8P/Nc//0vH/DWfWBKj1C4zwnN3/JkXJIU7IDQAAABB0Uk5T////////////////////AOAjXRkAAAAJcEhZcwAADsQAAA7EAZUrDhsAAABkSURBVAiZY/gPAQz////o6AfTs9Z1gOj2cKnwjv8MP7rini8V6mf4MXFp6aqgHoZPnfOiVmmcZ/h2oqmuqNef4VuOhpISC5BOu9RxwMWf4f+3uxdY/EHm3L3AADbvL+9+MA0GABhFRINKb0NBAAAAAElFTkSuQmCC)](https://syndikit.dev/)


[![Twitter](https://img.shields.io/badge/twitter-@brightdigit-blue.svg?style=flat)](http://twitter.com/brightdigit)
![GitHub](https://img.shields.io/github/license/brightdigit/SyndiKit)
[![SyndiKit](https://github.com/brightdigit/SyndiKit/actions/workflows/syndikit.yml/badge.svg)](https://github.com/brightdigit/SyndiKit/actions/workflows/syndikit.yml)
![GitHub issues](https://img.shields.io/github/issues/brightdigit/SyndiKit)


[![Codecov](https://img.shields.io/codecov/c/github/brightdigit/SyndiKit)](https://codecov.io/gh/brightdigit/SyndiKit)
[![CodeFactor](https://www.codefactor.io/repository/github/brightdigit/syndikit/badge)](https://www.codefactor.io/repository/github/brightdigit/syndikit)
[![codebeat badge](https://codebeat.co/badges/4990904e-9513-451f-a842-fb52c7ae0971)](https://codebeat.co/projects/github-com-brightdigit-syndikit-main)
[![Code Climate maintainability](https://img.shields.io/codeclimate/maintainability/brightdigit/SyndiKit)](https://codeclimate.com/github/brightdigit/SyndiKit)
[![Code Climate technical debt](https://img.shields.io/codeclimate/tech-debt/brightdigit/SyndiKit?label=debt)](https://codeclimate.com/github/brightdigit/SyndiKit)
[![Code Climate issues](https://img.shields.io/codeclimate/issues/brightdigit/SyndiKit)](https://codeclimate.com/github/brightdigit/SyndiKit)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)

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
  * [DocC](https://syndikit.dev)
  * [GitHub SourceDocs](/Documentation/Reference/SyndiKit/README.md)
* [Roadmap](#roadmap)
* [License](#license)

## Introduction

Built on top of [XMLCoder by Max Desiatov](https://github.com/MaxDesiatov/XMLCoder), SyndiKit can be used to import and read site data whether from a WordPress site, RSS feeds, YouTube channel or podcast.

## Features

* Import of RSS 2.0, Atom, and JSONFeed formats
* Extensions for iTunes-compatabile podcasts, YouTube channels, as well as WordPress export data
* User-friendly errors 
* Abstractions for format-agnostic parsing 

## Installation

### Requirements 

**Apple Platforms**

- Xcode 11.4.1 or later
- Swift 5.2.4 or later
- iOS 9.0 / watchOS 2.0 / tvOS 9.0 / macOS 10.10 or later deployment targets

**Linux**

- Ubuntu 18.04 or later
- Swift 5.2.4 or later

### Swift Package Manager

Swift Package Manager is Apple's decentralized dependency manager to integrate libraries to your Swift projects. It is now fully integrated with Xcode 11.

To integrate **SyndiKit** into your project using SPM, specify it in your Package.swift file:

```swift    
let package = Package(
  ...
  dependencies: [
    .package(url: "https://github.com/brightdigit/SyndiKit", from: "0.1.0")
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

There are two formats for the source documentation:

### [DocC](https://syndikit.dev)

[The **DocC** official web site is at syndikit.dev.](https://syndikit.dev) This includes tutorials, articles, code documentation and more.  

### [GitHub SourceDocs](/Documentation/Reference/SyndiKit/README.md)

For just markdown formatted documentation on GitHub using [SourceDocs](https://github.com/eneko/SourceDocs), you can read see [the list of types here.](/Documentation/Reference/SyndiKit/README.md)

## Roadmap

## 1.0.0 

- [ ] OPML Support
- [ ] WordPress DocC Tutorial
- [ ] RSS Import Tutorial (i.e. [OrchardNest](https://orchardnest.com))

## License 

This code is distributed under the MIT license. See the [LICENSE](LICENSE) file for more info.
