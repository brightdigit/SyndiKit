**STRUCT**

# `AtomMedia`

```swift
public struct AtomMedia: Codable
```

Media structure which enables
content publishers and bloggers to syndicate multimedia content
such as TV and video clips, movies, images and audio.

Fore more detils check out
[the Media RSS Specification](https://www.rssboard.org/media-rss).

## Properties
### `url`

```swift
public let url: URL
```

The type of object.

 While this attribute can at times seem redundant if type is supplied,
 it is included because it simplifies decision making on the reader side,
 as well as flushes out any ambiguities between MIME type and object type.
 It is an optional attribute.

### `medium`

```swift
public let medium: String?
```

The direct URL to the media object.
