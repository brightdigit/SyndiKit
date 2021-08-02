**PROTOCOL**

# `Feedable`

```swift
public protocol Feedable
```

Basic abstract Feed
## Topics

### Basic Properties

- ``title``
- ``siteURL``
- ``summary``
- ``updated``
- ``author``
- ``copyright``
- ``image``
- ``children``

### Special Properties

- ``youtubeChannelID``
- ``syndication``

## Properties
### `title`

```swift
var title: String
```

The name of the channel.

### `siteURL`

```swift
var siteURL: URL?
```

The URL to the website corresponding to the channel.

### `summary`

```swift
var summary: String?
```

Phrase or sentence describing the channel.

### `updated`

```swift
var updated: Date?
```

The last time the content of the channel changed.

### `authors`

```swift
var authors: [Author]
```

The author of the channel.

### `copyright`

```swift
var copyright: String?
```

Copyright notice for content in the channel.

### `image`

```swift
var image: URL?
```

Specifies a GIF, JPEG or PNG image that can be displayed with the channel.

### `children`

```swift
var children: [Entryable]
```

Items or stories attached to the feed.

### `youtubeChannelID`

```swift
var youtubeChannelID: String?
```

For YouTube channels, this will be the youtube channel ID.

### `syndication`

```swift
var syndication: SyndicationUpdate?
```

Provides syndication hints to aggregators and others
