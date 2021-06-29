**EXTENSION**

# `SiteMap`
```swift
extension SiteMap: ResponseEncodable
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