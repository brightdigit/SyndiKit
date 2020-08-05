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

### `category`

```swift
public let category: EntryCategory
```

## Methods
### `init(id:channel:category:feedId:title:summary:url:imageURL:publishedAt:)`

```swift
public init(id: UUID,
            channel: EntryChannel,
            category: EntryCategory,
            feedId: String,
            title: String,
            summary: String,
            url: URL,
            imageURL: URL?,
            publishedAt: Date)
```
