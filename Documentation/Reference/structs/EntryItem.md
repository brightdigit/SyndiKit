**STRUCT**

# `EntryItem`

```swift
public struct EntryItem: Codable
```

## Properties
### `id`

```swift
public let id: UUID
```

### `channel`

```swift
public let channel: EntryChannel
```

### `feedId`

```swift
public let feedId: String
```

### `title`

```swift
public let title: String
```

### `summary`

```swift
public let summary: String
```

### `url`

```swift
public let url: URL
```

### `imageURL`

```swift
public let imageURL: URL?
```

### `publishedAt`

```swift
public let publishedAt: Date
```

## Methods
### `init(id:channel:feedId:title:summary:url:imageURL:publishedAt:)`

```swift
public init(id: UUID,
            channel: EntryChannel,
            feedId: String,
            title: String,
            summary: String,
            url: URL,
            imageURL: URL?,
            publishedAt: Date)
```
