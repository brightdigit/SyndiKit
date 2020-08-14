**ENUM**

# `EntryCategory`

```swift
public enum EntryCategory: Codable
```

## Cases
### `companies`

```swift
case companies
```

### `design`

```swift
case design
```

### `development`

```swift
case development
```

### `marketing`

```swift
case marketing
```

### `newsletters`

```swift
case newsletters
```

### `podcasts(_:_:)`

```swift
case podcasts(URL, Int)
```

### `updates`

```swift
case updates
```

### `youtube(_:_:)`

```swift
case youtube(String, Int)
```

## Properties
### `type`

```swift
public var type: EntryCategoryType
```

## Methods
### `init(podcastEpisodeAtURL:withSeconds:)`

```swift
public init(podcastEpisodeAtURL url: URL, withSeconds seconds: Int)
```

### `init(youtubeVideoWithID:withSeconds:)`

```swift
public init(youtubeVideoWithID id: String, withSeconds seconds: Int)
```

### `init(type:)`

```swift
public init(type: EntryCategoryType) throws
```

### `init(from:)`

```swift
public init(from decoder: Decoder) throws
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| decoder | The decoder to read data from. |

### `encode(to:)`

```swift
public func encode(to encoder: Encoder) throws
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| encoder | The encoder to write data to. |