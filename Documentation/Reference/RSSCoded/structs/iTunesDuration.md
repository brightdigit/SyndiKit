**STRUCT**

# `iTunesDuration`

```swift
public struct iTunesDuration: Codable, LosslessStringConvertible
```

## Properties
### `description`

```swift
public var description: String
```

### `value`

```swift
public let value: TimeInterval
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

### `init(_:)`

```swift
public init?(_ description: String)
```
