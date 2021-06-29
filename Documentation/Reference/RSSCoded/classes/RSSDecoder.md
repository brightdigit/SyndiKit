**CLASS**

# `RSSDecoder`

```swift
public class RSSDecoder
```

## Methods
### `init(jsonDecoderProvider:xmlDecoderProvider:)`

```swift
public init(jsonDecoderProvider: ((JSONDecoder) -> Void)? = nil, xmlDecoderProvider: ((XMLDecoder) -> Void)? = nil)
```

### `decode(_:)`

```swift
public func decode(_ data: Data) throws -> Feedable
```
