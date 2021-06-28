**EXTENSION**

# `Node`
```swift
public extension Node where Context == HTML.BodyContext
```

## Methods
### `playerForPodcast(withAppleId:)`

```swift
static func playerForPodcast(withAppleId appleId: Int) -> Self
```

### `filters()`

```swift
static func filters() -> Self
```

### `header()`

```swift
static func header() -> Self
```

### `head(withSubtitle:andDescription:)`

```swift
static func head(withSubtitle subtitle: String, andDescription description: String) -> Self
```

### `year(fromDate:)`

```swift
static func year(fromDate date: Date = Date()) -> Self
```

### `footer()`

```swift
static func footer() -> Self
```

### `li(forEntryItem:formatDateWith:)`

```swift
static func li(forEntryItem item: EntryItem, formatDateWith formatter: DateFormatter) -> Self
```
