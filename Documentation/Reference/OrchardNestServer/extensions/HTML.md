**EXTENSION**

# `HTML`
```swift
extension HTML: ResponseEncodable
```

## Methods
### `encodeResponse(for:)`

```swift
public func encodeResponse(for request: Request) -> EventLoopFuture<Response>
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| for | The `HTTPRequest` associated with this `HTTPResponse`. |