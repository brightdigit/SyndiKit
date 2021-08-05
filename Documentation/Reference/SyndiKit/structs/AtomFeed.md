**STRUCT**

# `AtomFeed`

```swift
public struct AtomFeed
```

An XML-based Web content and metadata syndication format.

Based on the
[specifications here](https://datatracker.ietf.org/doc/html/rfc4287#section-4.1.2).

## Properties
### `id`

```swift
public let id: String
```

Identifies the feed using a universally unique and permanent URI.
If you have a long-term, renewable lease on your Internet domain name,
then you can feel free to use your website's address.

### `title`

```swift
public let title: String
```

Contains a human readable title for the feed.
Often the same as the title of the associated website.

### `description`

```swift
public let description: String?
```

Contains a human-readable description or subtitle for the feed

### `subtitle`

```swift
public let subtitle: String?
```

Contains a human-readable description or subtitle for the feed

### `published`

```swift
public let published: Date?
```

The publication date for the content in the channel.

### `pubDate`

```swift
public let pubDate: Date?
```

The publication date for the content in the channel.

### `links`

```swift
public let links: [Link]
```

a reference from an entry or feed to a Web resource.

### `entries`

```swift
public let entries: [AtomEntry]
```

An individual entry,
acting as a container for metadata and data associated with the entry

### `authors`

```swift
public let authors: [Author]
```

The author of the feed.

### `youtubeChannelID`

```swift
public let youtubeChannelID: String?
```

YouTube channel ID, if from a YouTube channel.
