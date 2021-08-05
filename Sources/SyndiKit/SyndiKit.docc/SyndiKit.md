# ``SyndiKit``

Swift Package for Decoding RSS Feeds.

## Overview

![SyndiKit Logo](logo.png)

Built on top of [XMLCoder by Max Desiatov](https://github.com/MaxDesiatov/XMLCoder), **SyndiKit** provides models and utilities for decoding RSS feeds of various formats and extensions.

### Features

* Import of RSS 2.0, Atom, and JSONFeed formats
* Extensions for various formats such as:
  * iTunes-compatabile podcasts
  * YouTube channels
  * WordPress export data
* User-friendly errors 
* Abstractions for format-agnostic parsing 

### Installation

### Requirements 

**Apple Platforms**

- Xcode 12.3 or later
- Swift 5.3.2 or later
- iOS 9.0 / watchOS 2.0 / tvOS 9.0 / macOS 10.10 or later deployment targets

**Linux**

- Ubuntu 18.04 or later
- Swift 5.3.2 or later

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

If this is for an Xcode project simply import the [Github repository](https://github.com/brightdigit/SyndiKit) at:

```
https://github.com/brightdigit/SyndiKit
```

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

For a mapping of properties:

Feedable | RSS 2.0 ``RSSFeed/channel`` | Atom ``AtomFeed`` | JSONFeed ``JSONFeed`` 
--- | --- | --- | ---
``Feedable/title`` | ``RSSChannel/title`` | ``AtomFeed/title`` | ``JSONFeed/title``
``Feedable/siteURL`` | ``RSSChannel/link`` | ``AtomFeed/siteURL``| ``JSONFeed/title``
``Feedable/summary`` | ``RSSChannel/description`` | ``AtomFeed/summary`` | ``JSONFeed/homePageUrl``
``Feedable/updated`` | ``RSSChannel/lastBuildDate`` | ``AtomFeed/pubDate`` or ``AtomFeed/published`` | `nil`
``Feedable/author`` | ``RSSChannel/author`` | ``AtomFeed/author`` | ``JSONFeed/author``
``Feedable/copyright`` | ``RSSChannel/copyright`` | `nil` | `nil`
``Feedable/image`` | ``RSSImage/url`` | ``AtomFeed/links``.`first` | `nil`
``Feedable/children`` | ``RSSChannel/items`` | ``AtomFeed/entries``| ``JSONFeed/items``

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

``MediaContent`` | Actual Property
--- | ---
``PodcastEpisode/title`` | ``RSSItem/itunesTitle``
``PodcastEpisode/episode`` | ``RSSItem/itunesEpisode``
``PodcastEpisode/author`` | ``RSSItem/itunesAuthor``
``PodcastEpisode/subtitle`` | ``RSSItem/itunesSubtitle``
``PodcastEpisode/summary`` | ``RSSItem/itunesSummary``
``PodcastEpisode/explicit`` | ``RSSItem/itunesExplicit``
``PodcastEpisode/duration`` | ``RSSItem/itunesDuration``
``PodcastEpisode/image`` | ``RSSItem/itunesImage``
``YouTubeID/channelID`` | ``AtomEntry/youtubeChannelID``
``YouTubeID/videoID`` | ``AtomEntry/youtubeVideoID``


## Topics

### Decoding an RSS Feed

- ``SynDecoder``

### Basic Feeds

The basic types used by **SyndiKit** for traversing the feed in abstract manner without needing the specific properties from the various feed formats. 

- ``Feedable``
- ``Entryable``
- ``Author``
- ``EntryCategory``
- ``EntryID``

### Abstract Media Types

Abstract media types which can be pulled for the various ``Entryable`` objects.

- ``PodcastEpisode``
- ``MediaContent``
- ``Video``


### XML Primitive Types

In many cases, types are encoded in non-matching types but are intended to strong-typed for various formats. These primitives are setup to make XML decoding easier while retaining their intended strong-type.

- ``CData``
- ``XMLStringInt``

### Syndication Updates

Properties from the RDF Site Summary Syndication Module concerning how often it is updated a feed is updated. 

- ``SyndicationUpdate``
- ``SyndicationUpdatePeriod``
- ``SyndicationUpdateFrequency``

### Atom Feed Format

Specific properties related to the Atom format.

- ``AtomFeed``
- ``AtomEntry``
- ``AtomCategory``
- ``AtomMedia``
- ``Link``

### JSON Feed Format

Specific properties related to the JSON Feed format.

- ``JSONFeed``
- ``JSONItem``

### RSS Feed Format

Specific properties related to the RSS Feed format.

- ``RSSFeed``
- ``RSSChannel``
- ``RSSImage``
- ``RSSItem``
- ``RSSItemCategory``
- ``Enclosure``

### WordPress Extensions

Specific extension properties provided by WordPress.

- ``WordPressElements``
- ``WordPressPost``

### YouTube Extensions

Specific type abstracting the id properties a YouTube RSS Feed.

- ``YouTubeID``

### iTunes Extensions 

Specific extension properties provided by iTunes regarding mostly podcasts and their episodes.

- ``iTunesImage``
- ``iTunesOwner``
- ``iTunesEpisode``
- ``iTunesDuration``

### Site Directories

Types related to the format used by the [iOS Dev Directory](https://iosdevdirectory.com). 

- ``SiteDirectory``
- ``SiteCollectionDirectory``
- ``SiteDirectoryBuilder``
- ``CategoryDescriptor``
- ``CategoryLanguage``
- ``Site``
- ``SiteCategory``
- ``SiteCollectionDirectoryBuilder``
- ``SiteLanguage``
- ``SiteLanguageCategory``
- ``SiteLanguageContent``
- ``SiteCategoryType``
- ``SiteCollection``
- ``SiteLanguageType``
- ``SiteStub``
