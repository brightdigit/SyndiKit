**STRUCT**

# `Channel`

```swift
public struct Channel: Codable
```

## Properties
### `title`

```swift
public let title: String
```

### `summary`

```swift
public let summary: String?
```

### `author`

```swift
public let author: String
```

### `siteUrl`

```swift
public let siteUrl: URL
```

### `feedUrl`

```swift
public let feedUrl: URL
```

### `twitterHandle`

```swift
public let twitterHandle: String?
```

### `image`

```swift
public let image: URL?
```

### `updated`

```swift
public let updated: Date
```

### `ytId`

```swift
public let ytId: String?
```

### `language`

```swift
public let language: String
```

### `category`

```swift
public let category: String
```

### `items`

```swift
public let items: [Item]
```

### `itemCount`

```swift
public let itemCount: Int?
```

## Methods
### `imageURL(fromYoutubeId:)`

```swift
public static func imageURL(fromYoutubeId ytId: String) -> URL
```

### `init(language:category:site:)`

```swift
public init(language: String, category: String, site: Site) throws
```
