**STRUCT**

# `RSSItem`

```swift
public struct RSSItem: Codable
```

## Properties
### `title`

```swift
public let title: String
```

### `link`

```swift
public let link: URL
```

### `description`

```swift
public let description: CData
```

### `guid`

```swift
public let guid: EntryID
```

### `pubDate`

```swift
public let pubDate: Date?
```

### `contentEncoded`

```swift
public let contentEncoded: CData?
```

### `categoryTerms`

```swift
public let categoryTerms: [RSSItemCategory]
```

### `content`

```swift
public let content: String?
```

### `itunesTitle`

```swift
public let itunesTitle: String?
```

### `itunesEpisode`

```swift
public let itunesEpisode: iTunesEpisode?
```

### `itunesAuthor`

```swift
public let itunesAuthor: String?
```

### `itunesSubtitle`

```swift
public let itunesSubtitle: String?
```

### `itunesSummary`

```swift
public let itunesSummary: String?
```

### `itunesExplicit`

```swift
public let itunesExplicit: String?
```

### `itunesDuration`

```swift
public let itunesDuration: iTunesDuration?
```

### `itunesImage`

```swift
public let itunesImage: iTunesImage?
```

### `enclosure`

```swift
public let enclosure: Enclosure?
```

### `creators`

```swift
public let creators: [String]
```

### `wpCommentStatus`

```swift
public let wpCommentStatus: CData?
```

### `wpPingStatus`

```swift
public let wpPingStatus: CData?
```

### `wpStatus`

```swift
public let wpStatus: CData?
```

### `wpPostParent`

```swift
public let wpPostParent: Int?
```

### `wpMenuOrder`

```swift
public let wpMenuOrder: Int?
```

### `wpIsSticky`

```swift
public let wpIsSticky: Int?
```

### `wpPostPassword`

```swift
public let wpPostPassword: CData?
```

### `wpPostID`

```swift
public let wpPostID: Int?
```

### `wpPostDate`

```swift
public let wpPostDate: Date?
```

### `wpPostDateGMT`

```swift
public let wpPostDateGMT: Date?
```

### `wpModifiedDate`

```swift
public let wpModifiedDate: Date?
```

### `wpModifiedDateGMT`

```swift
public let wpModifiedDateGMT: Date?
```

### `wpPostName`

```swift
public let wpPostName: CData?
```

### `wpPostType`

```swift
public let wpPostType: CData?
```

### `wpPostMeta`

```swift
public let wpPostMeta: [WordPressElements.PostMeta]?
```

### `mediaContent`

```swift
public let mediaContent: AtomMedia?
```

### `mediaThumbnail`

```swift
public let mediaThumbnail: AtomMedia?
```

## Methods
### `init(from:)`

```swift
public init(from decoder: Decoder) throws
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| decoder | The decoder to read data from. |