**CLASS**

# `SynDecoder`

```swift
public class SynDecoder
```

An object that decodes instances of Feedable from JSON or XML objects.
## Topics

### Creating a Decoder

- ``init()``

### Decoding

- ``decode(_:)``

## Methods
### `init()`

```swift
public convenience init()
```

Creates an instance of `RSSDecoder`

### `decode(_:)`

```swift
public func decode(_ data: Data) throws -> Feedable
```

Returns a `Feedable` object of the type you specify, decoded from a JSON object.
- Parameter data: The JSON or XML object to decode.
- Returns: A `Feedable` object

If the data is not valid RSS, this method throws the
`DecodingError.dataCorrupted(_:)` error.
If a value within the RSS fails to decode,
this method throws the corresponding error.

```swift
let data = Data(contentsOf: "empowerapps-show.xml")!
let decoder = SynDecoder()
let feed = try decoder.decode(data)

print(feed.title) // Prints "Empower Apps"
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| data | The JSON or XML object to decode. |