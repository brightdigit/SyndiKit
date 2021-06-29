**STRUCT**

# `IntegerCodable`

```swift
public struct IntegerCodable: Codable, ExpressibleByIntegerLiteral
```

## Properties
### `value`

```swift
public let value: Int
```

## Methods
### `init(integerLiteral:)`

```swift
public init(integerLiteral value: Int)
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | The value to create. |

### `init(from:)`

```swift
public init(from decoder: Decoder) throws
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| decoder | The decoder to read data from. |