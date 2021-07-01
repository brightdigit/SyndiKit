**STRUCT**

# `SyndicationUpdate`

```swift
public struct SyndicationUpdate: Codable, Equatable
```

## Properties
### `period`

```swift
public let period: SyndicationUpdatePeriod
```

### `frequency`

```swift
public let frequency: Int
```

### `base`

```swift
public let base: Date?
```

## Methods
### `init(period:frequency:base:)`

```swift
public init?(
  period: SyndicationUpdatePeriod? = nil,
  frequency: Int? = nil,
  base: Date? = nil
)
```
