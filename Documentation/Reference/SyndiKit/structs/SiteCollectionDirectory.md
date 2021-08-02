**STRUCT**

# `SiteCollectionDirectory`

```swift
public struct SiteCollectionDirectory: SiteDirectory
```

## Properties
### `languages`

```swift
public var languages: Dictionary<
  SiteLanguageType, SiteLanguage
>.Values
```

### `categories`

```swift
public var categories: Dictionary<
  SiteCategoryType, SiteCategory
>.Values
```

## Methods
### `sites(withLanguage:withCategory:)`

```swift
public func sites(
  withLanguage language: SiteLanguageType?,
  withCategory category: SiteCategoryType?
) -> [Site]
```
