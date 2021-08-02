**STRUCT**

# `RSSItemCategory`

```swift
public struct RSSItemCategory: Codable, EntryCategory
```

## Properties
### `term`

```swift
public var term: String
```

### `value`

```swift
public let value: String
```

### `domain`

```swift
public let domain: String?
```

### `nicename`

```swift
public let nicename: String?
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