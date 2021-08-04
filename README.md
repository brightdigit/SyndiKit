
<p align="center">
    <img alt="SyndiKit" title="SyndiKit" src="Assets/logo.svg" height="200">
</p>
<h1 align="center"> <a href="https://syndikit.dev/">SyndiKit</a> </h1>

Swift Package for Decoding RSS Feeds. Check out the [DocC-Built Site!](https://syndikit.dev/)

[![SwiftPM](https://img.shields.io/badge/SPM-Linux%20%7C%20iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS-success?logo=swift)](https://swift.org)
[![Twitter](https://img.shields.io/badge/twitter-@brightdigit-blue.svg?style=flat)](http://twitter.com/brightdigit)
![GitHub](https://img.shields.io/github/license/brightdigit/SyndiKit)
![GitHub issues](https://img.shields.io/github/issues/brightdigit/SyndiKit)
[![SyndiKit](https://github.com/brightdigit/SyndiKit/actions/workflows/syndikit.yml/badge.svg)](https://github.com/brightdigit/SyndiKit/actions/workflows/syndikit.yml)
[![DocC](https://img.shields.io/badge/DocC-read-success?logo=apple)](https://syndikit.dev/)

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbrightdigit%2FSyndiKit%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/brightdigit/SyndiKit)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbrightdigit%2FSyndiKit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/brightdigit/SyndiKit)


[![Codecov](https://img.shields.io/codecov/c/github/brightdigit/SyndiKit)](https://codecov.io/gh/brightdigit/SyndiKit)
[![CodeFactor](https://www.codefactor.io/repository/github/brightdigit/syndikit/badge)](https://www.codefactor.io/repository/github/brightdigit/syndikit)
[![codebeat badge](https://codebeat.co/badges/4990904e-9513-451f-a842-fb52c7ae0971)](https://codebeat.co/projects/github-com-brightdigit-syndikit-main)
[![Code Climate maintainability](https://img.shields.io/codeclimate/maintainability/brightdigit/SyndiKit)](https://codeclimate.com/github/brightdigit/SyndiKit)
[![Code Climate technical debt](https://img.shields.io/codeclimate/tech-debt/brightdigit/SyndiKit?label=debt)](https://codeclimate.com/github/brightdigit/SyndiKit)
[![Code Climate issues](https://img.shields.io/codeclimate/issues/brightdigit/SyndiKit)](https://codeclimate.com/github/brightdigit/SyndiKit)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)

## Introduction

// TODO:

## Features

// TODO:

## Installation

// TODO:

## Getting Started

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

## Further Code Documentation

[Documentation Here](/Documentation/Reference/README.md)
