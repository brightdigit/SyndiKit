# ``SyndiKit``

Swift Package for Decoding RSS Feeds.

## Overview

![SyndiKit Logo](logo.png)

SyndiKit provides models and utilities for decoding RSS feeds of various formats and extensions.

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
- ``Media``

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

Properties from [the RDF Site Summary Syndication Module](https://web.resource.org/rss/1.0/modules/syndication/) concerning how often it is updated a feed is updated. 

- ``SyndicationUpdate``
- ``SyndicationUpdatePeriod``
- ``SyndicationUpdateFrequency``

### Atom Feed Format

Specific properties related to the Atom format.

- ``AtomFeed``
- ``AtomEntry``
- ``AtomCategory``
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

### Wordpress Extensions

Specific extension properties provided by Wordpress.

- ``WPTag``
- ``WPCategory``
- ``WPPostMeta``

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
