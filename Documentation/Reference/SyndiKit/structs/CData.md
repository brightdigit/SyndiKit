**STRUCT**

# `CData`

```swift
public struct CData: Codable, RSSCategory
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

## Methods
### `init(from:)`

```swift
public init(from decoder: Decoder) throws
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| decoder | The decoder to read data from. |