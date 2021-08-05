**PROTOCOL**

# `Entryable`

```swift
public protocol Entryable
```

Basic Feed type with abstract properties.

## Properties
### `id`

```swift
var id: EntryID
```

Unique Identifier of the Item.

### `url`

```swift
var url: URL
```

The URL of the item.

### `title`

```swift
var title: String
```

The title of the item.

### `contentHtml`

```swift
var contentHtml: String?
```

HTML content of the item.

### `summary`

```swift
var summary: String?
```

The item synopsis.

### `published`

```swift
var published: Date?
```

Indicates when the item was published.

### `authors`

```swift
var authors: [Author]
```

The author of the item.

### `categories`

```swift
var categories: [EntryCategory]
```

Includes the item in one or more categories.

### `creators`

```swift
var creators: [String]
```

Creator of the item.

### `media`

```swift
var media: MediaContent?
```

Abstraction of Podcast episode or Youtube video info.

### `imageURL`

```swift
var imageURL: URL?
```

Image URL of the Item.
