**STRUCT**

# `AtomEntry`

```swift
public struct AtomEntry: Codable
```

## Properties
### `id`

```swift
public let id: EntryID
```

A permanent, universally unique identifier for an entry.

### `title`

```swift
public let title: String
```

a Text construct that conveys a human-readable title

### `published`

```swift
public let published: Date?
```

The most recent instant in time when the entry was published

### `content`

```swift
public let content: String?
```

Content of the trny.

### `updated`

```swift
public let updated: Date
```

The most recent instant in time when the entry was modified in a way
the publisher considers significant.

### `atomCategories`

```swift
public let atomCategories: [AtomCategory]
```

Cateogires of the entry.

### `links`

```swift
public let links: [Link]
```

a reference to a Web resource.

### `authors`

```swift
public let authors: [Author]
```

The author of the entry.

### `youtubeChannelID`

```swift
public let youtubeChannelID: String?
```

YouTube channel ID, if from a YouTube channel.

### `youtubeVideoID`

```swift
public let youtubeVideoID: String?
```

YouTube video ID, if from a YouTube channel.

### `mediaDescriptions`

```swift
public let mediaDescriptions: [String]
```

Short description describing the media object typically a sentence in length.
It has one optional attribute.

### `creators`

```swift
public let creators: [String]
```

the person or entity who wrote an item

### `mediaContents`

```swift
public let mediaContents: [AtomMedia]
```

Syndicate media content of the entry.

### `mediaThumbnails`

```swift
public let mediaThumbnails: [AtomMedia]
```

Representative image for the media object.
