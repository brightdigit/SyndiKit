**STRUCT**

# `RSSFeed`

```swift
public struct RSSFeed
```

RSS is a Web content syndication format.

Its name is an acronym for Really Simple Syndication.
RSS is dialect of XML.
All RSS files must conform to the XML 1.0 specification,
as published on the World Wide Web Consortium (W3C) website.
At the top level, a RSS document is a <rss> element,
with a mandatory attribute called version,
that specifies the version of RSS that the document conforms to.
If it conforms to this specification,
the version attribute must be 2.0.
For more details, check out the
[W3 sepcifications.](https://validator.w3.org/feed/docs/rss2.html)

## Properties
### `channel`

```swift
public let channel: RSSChannel
```
