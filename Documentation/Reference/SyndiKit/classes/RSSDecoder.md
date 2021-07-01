**CLASS**

# `RSSDecoder`

```swift
public class RSSDecoder
```

## Methods
### `init(types:defaultJSONDecoderSetup:defaultXMLDecoderSetup:)`

```swift
public init(
  types: [DecodableFeed.Type]? = nil,
  defaultJSONDecoderSetup: ((JSONDecoder) -> Void)? = nil,
  defaultXMLDecoderSetup: ((XMLDecoder) -> Void)? = nil
)
```

### `decode(_:)`

```swift
public func decode(_ data: Data) throws -> Feedable
```
