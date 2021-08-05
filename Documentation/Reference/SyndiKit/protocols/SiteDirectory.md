**PROTOCOL**

# `SiteDirectory`

```swift
public protocol SiteDirectory
```

## Properties
### `languages`

```swift
var languages: LanguageSequence
```

### `categories`

```swift
var categories: CategorySequence
```

## Methods
### `sites(withLanguage:withCategory:)`

```swift
func sites(
  withLanguage language: SiteLanguageType?,
  withCategory category: SiteCategoryType?
) -> SiteSequence
```
