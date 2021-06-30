**ENUM**

# `RSSGUID`

```swift
public enum RSSGUID: Codable, Equatable
```

## Cases
### `url(_:)`

```swift
case url(URL)
```

### `uuid(_:)`

```swift
case uuid(UUID)
```

### `path(_:separatedBy:)`

```swift
case path([String], separatedBy: String)
```

### `string(_:)`

```swift
case string(String)
```

## Methods
### `init(from:)`

```swift
public init(from string: String)
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