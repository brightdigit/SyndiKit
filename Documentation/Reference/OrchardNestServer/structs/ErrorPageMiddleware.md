**STRUCT**

# `ErrorPageMiddleware`

```swift
public struct ErrorPageMiddleware: Middleware
```

## Methods
### `respond(to:chainingTo:)`

```swift
public func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response>
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| request | The incoming `Request`. |
| next | Next `Responder` in the chain, potentially another middleware or the main router. |