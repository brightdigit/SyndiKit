**STRUCT**

# `BlogCollection`

```swift
public struct BlogCollection
```

## Methods
### `languages()`

```swift
public func languages() -> Dictionary<LanguageType, Language>.Values
```

### `categories()`

```swift
public func categories() -> Dictionary<CategoryType, Category>.Values
```

### `sites(withLanguage:withCategory:)`

```swift
public func sites(
  withLanguage language: LanguageType? = nil,
  withCategory category: CategoryType? = nil
) -> [BlogSite]
```

### `init(blogs:)`

```swift
public init(blogs: BlogArray)
```
