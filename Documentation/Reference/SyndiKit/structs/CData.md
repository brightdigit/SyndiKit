**STRUCT**

# `CData`

```swift
public struct CData: Codable
```

#CDATA XML element.

## Properties
### `value`

```swift
public let value: String
```

String value of the #CDATA element.

## Methods
### `init(from:)`

```swift
public init(from decoder: Decoder) throws
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| decoder | The decoder to read data from. |