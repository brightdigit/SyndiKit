**STRUCT**

# `RSSImage`

```swift
public struct RSSImage: Codable
```

Specifies a GIF, JPEG or PNG image.

## Properties
### `url`

```swift
public let url: URL
```

The URL of a GIF, JPEG or PNG image

### `title`

```swift
public let title: String
```

Describes the image.

It's used in the ALT attribute of the HTML <img> tag
when the channel is rendered in HTML.

### `link`

```swift
public let link: URL
```

The URL of the site, when the channel is rendered,
the image is a link to the site.

In practice the image <title> and <link> should have
the same value as the channel's <title> and <link>

### `width`

```swift
public let width: Int?
```

The width of the image in pixels.

### `height`

```swift
public let height: Int?
```

The height of the image in pixels.

### `description`

```swift
public let description: String?
```

This contains text that is included in the TITLE attribute
of the link formed around the image in the HTML rendering.
