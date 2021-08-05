**ENUM**

# `EntryID`

```swift
public enum EntryID: Codable, Equatable, LosslessStringConvertible
```

Entry identifier based on the RSS guid.
## Topics

### Enumeration Cases

- ``url(_:)``
- ``uuid(_:)``
- ``path(_:separatedBy:)``
- ``string(_:)``

### String Conversion

- ``init(string:)``
- ``description``
- ``init(_:)``

 ### Codable Overrides

- ``init(from:)``
- ``encode(to:)``

## Cases
### `url(_:)`

```swift
case url(URL)
```

URL format.

### `uuid(_:)`

```swift
case uuid(UUID)
```

UUID format.

### `path(_:separatedBy:)`

```swift
case path([String], separatedBy: String)
```

String path separated by a character string.

This is generally used by YouTube's RSS feed. in the format of:
```
yt:video:(YouTube Video ID)
```

### `string(_:)`

```swift
case string(String)
```

Plain un-parsable String.

## Properties
### `description`

```swift
public var description: String
```

## Methods
### `init(_:)`

```swift
public init?(_ description: String)
```

Implementation of ``LosslessStringConvertible`` initializer.
This will never return a nil instance.
Therefore you should use ``init(string:)``to  avoid the `Optional` result.

### `init(string:)`

```swift
public init(string: String)
```

Parses the String into a ``EntryID``
- Parameter string: The String to parse.
You should use this rather than ``init(_:)``  to avoid the `Optional` result.

#### Parameters

| Name | Description |
| ---- | ----------- |
| string | The String to parse. You should use this rather than `init(_:)`  to avoid the `Optional` result. |

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