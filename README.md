
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
[![DocC](https://img.shields.io/badge/DocC-read-success?logo=data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+Cjxzdmcgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDMyNCAzMjYiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSIgeG1sbnM6c2VyaWY9Imh0dHA6Ly93d3cuc2VyaWYuY29tLyIgc3R5bGU9ImZpbGwtcnVsZTpldmVub2RkO2NsaXAtcnVsZTpldmVub2RkO3N0cm9rZS1saW5lam9pbjpyb3VuZDtzdHJva2UtbWl0ZXJsaW1pdDoyOyI+CiAgICA8cmVjdCBpZD0iQXJ0Ym9hcmQxIiB4PSIwIiB5PSIwIiB3aWR0aD0iMzIzLjg4MSIgaGVpZ2h0PSIzMjUuMzY1IiBzdHlsZT0iZmlsbDpub25lOyIvPgogICAgPGNsaXBQYXRoIGlkPSJfY2xpcDEiPgogICAgICAgIDxyZWN0IHg9IjAiIHk9IjAiIHdpZHRoPSIzMjMuODgxIiBoZWlnaHQ9IjMyNS4zNjUiLz4KICAgIDwvY2xpcFBhdGg+CiAgICA8ZyBjbGlwLXBhdGg9InVybCgjX2NsaXAxKSI+CiAgICAgICAgPHBhdGggZD0iTTMwNi41MywyMzEuNDIxQzMyNi40NzIsMjE4Ljg5IDMyMi40MzYsMjA1LjU3NSAzMjIuNDM2LDIwNS41NzVMMzIyLjg1OSwxMTkuNTUyQzMyMi44NTksMTE5LjU1MiAzMjAuNjE1LDExMS4xNjkgMzA3Ljc4LDk4LjA0MkwxOTYuNjcxLDEyLjg1QzE3Ny4yODIsLTYuNTM5IDE0My41NzcsLTEuOTg2IDEyNC4xODgsMTcuNDA0TDIyLjc0Niw5My42MzZDMTYuNjMxLDk1LjI2NyAxLjQzMiwxMTkuOTIgMS40MzIsMTE5LjkyTDIuOTI2LDIwOS42NDJDMi45MjYsMjA5LjY0MiA1LjQ2LDIxOS4yNTMgMTUuMDIyLDIyOC44MTVMMTI4LjUyNiwzMTQuNDM0QzE0Ny45MTUsMzMzLjgyNCAxODIuODgxLDMyOC4xNjcgMjAyLjI3MSwzMDguNzc4TDMwNi41MywyMzEuNDIxWiIgc3R5bGU9ImZpbGw6dXJsKCNfTGluZWFyMik7Ii8+CiAgICAgICAgPHBhdGggZD0iTTMwNy40ODcsMTQ2LjcyMUMzMjYuODc2LDEyNy4zMzIgMzI4LjM3MSwxMTQuNjYzIDMwOC45ODIsOTUuMjc0TDE5OC41MjIsMTIuNTI5QzE3OS4xMzMsLTYuODYgMTQzLjcyOSwtMy41MjQgMTI0LjM0LDE1Ljg2NUwxNS43MzksOTYuMzA5Qy0zLjY1MSwxMTUuNjk5IC0zLjQxMSwxMjQuNzI2IDE1Ljk3OCwxNDQuMTE1TDEyOS40ODIsMjI5LjczNUMxNDguODcyLDI0OS4xMjQgMTgzLjgzOCwyNDMuNDY3IDIwMy4yMjcsMjI0LjA3OEwzMDcuNDg3LDE0Ni43MjFaIiBzdHlsZT0iZmlsbDpyZ2IoMCwxOTQsMjU1KTsiLz4KICAgICAgICA8ZyBvcGFjaXR5PSIwLjI1Ij4KICAgICAgICAgICAgPHBhdGggZD0iTTY4LjUxNiwxNTEuODc3QzQ5LjE1NSwxNDkuNTE3IDQ1LjI2MSwxNDAuMDMzIDU4LjE1NywxMjIuODE4TDg1LjE5Myw3My41NDFDODcuODk0LDY0LjI3OCA5NS4wMjksNTkuNTY1IDEwNy45MTEsNjAuNzUyTDIxMi43NzcsNzkuODMxQzIyNi4yNDksODIuNjc5IDIzMC43MzUsODkuMzQ4IDIyNS40NjcsMTAwLjE2NUwxOTMuNzg0LDE2MS41NzFDMTg2LjAyNiwxNzEuOTk1IDE3NS43MTYsMTc2LjQwMiAxNjIuNzMyLDE3NC41MDJMNjguNTE2LDE1MS44NzdaIiBzdHlsZT0iZmlsbDp3aGl0ZTsiLz4KICAgICAgICA8L2c+CiAgICAgICAgPGcgb3BhY2l0eT0iMC41Ij4KICAgICAgICAgICAgPHBhdGggZD0iTTc0Ljk1OSwxMzIuMjUxQzU2LjQyNywxMjYuMTcgNTQuNDUyLDExNi4xMTEgNzAuNDQ5LDEwMS43MzJMMTA2LjU1Myw1OC42NTVDMTExLjAwNCw1MC4wOTMgMTE4LjkxOSw0Ni44NTggMTMxLjMyNCw1MC41MjhMMjMwLjQ3Nyw4OS42MzdDMjQzLjEzOCw5NS4wNSAyNDYuMjQyLDEwMi40NjUgMjM4Ljk3LDExMi4wNTFMMTk1Ljk1LDE2Ni4xMjJDMTg2LjMxMywxNzQuODM5IDE3NS4zNDIsMTc3LjE1NiAxNjIuOTc2LDE3Mi43NjhMNzQuOTU5LDEzMi4yNTFaIiBzdHlsZT0iZmlsbDp3aGl0ZTsiLz4KICAgICAgICA8L2c+CiAgICAgICAgPHBhdGggZD0iTTg3LjAwNiwxMTMuMDU1QzcwLjU5LDEwMi41MjMgNzEuMTk5LDkyLjI5IDkwLjI5MSw4Mi4zODFMMTM2LjAzOSw0OS43MjhDMTQyLjQ5NCw0Mi41NTUgMTUwLjk2Nyw0MS40MDggMTYyLjA1Nyw0OC4wN0wyNDguMjQxLDExMC43ODRDMjU5LjE0MSwxMTkuMTk4IDI2MC4yODcsMTI3LjE1NCAyNTAuODQ1LDEzNC42MTFMMTk1LjY0NCwxNzYuMTczQzE4NC4xMywxODIuMTk1IDE3Mi45MjksMTgxLjY4OSAxNjIuMDU3LDE3NC4zNDFMODcuMDA2LDExMy4wNTVaIiBzdHlsZT0iZmlsbDp3aGl0ZTsiLz4KICAgICAgICA8cGF0aCBkPSJNMTMyLjQwMSwxMDYuOTcxTDEyNC4yNDksODguNjg5TDEyNC4zNTMsODguNTlMMTQyLjA1MSw5Ny43ODlMMTMyLjQwMSwxMDYuOTcxWk0xMTEuNDQ1LDgzLjM4TDEzMi43OTgsMTM0LjAyM0wxNDEuMDM5LDEyNi4xODJMMTM2LjA2OSwxMTUuMTA5TDE0OS45OTYsMTAxLjg1N0wxNjAuNzA0LDEwNy40NzFMMTY5LjIwNiw5OS4zODFMMTE5Ljg0Myw3NS4zODlMMTExLjQ0NSw4My4zOFoiIHN0eWxlPSJmaWxsOnJnYigwLDE4MiwyNTUpO2ZpbGwtcnVsZTpub256ZXJvOyIvPgogICAgICAgIDxwYXRoIGQ9Ik0yMTEuMDQ3LDk4LjIyN0MyMDkuOTkyLDk2LjkxIDIwOC4wNjcsOTYuNjk2IDIwNi43NDksOTcuNzVMMTUyLjM4MSwxNDEuMjY0QzE1MS4wNjQsMTQyLjMxOCAxNTAuODUxLDE0NC4yNDQgMTUxLjkwNSwxNDUuNTYxTDE1NS43MjYsMTUwLjMzNUMxNTYuNzgsMTUxLjY1MyAxNTguNzA2LDE1MS44NjYgMTYwLjAyMywxNTAuODEyTDIxNC4zOTEsMTA3LjI5OEMyMTUuNzA5LDEwNi4yNDQgMjE1LjkyMiwxMDQuMzE4IDIxNC44NjgsMTAzLjAwMUwyMTEuMDQ3LDk4LjIyN1oiIHN0eWxlPSJmaWxsOnJnYigxMzIsMjExLDI1NCk7Ii8+CiAgICAgICAgPHBhdGggZD0iTTIzMS)](https://syndikit.dev/)

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
