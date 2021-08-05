**STRUCT**

# `XMLStringInt`

```swift
public struct XMLStringInt: Codable
```

XML Element which contains a `String` parsable into a `Integer`.

## Properties
### `value`

```swift
public let value: Int
```

The underlying `Int` value.

## Methods
### `init(from:)`

```swift
public init(from decoder: Decoder) throws
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| decoder | The decoder to read data from. |