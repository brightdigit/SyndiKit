import Foundation
import XMLCoder

enum Feed {
  case rss(RSSFeed)
  case atom(AtomFeed)
  case json(JSONFeed)
}

extension Feed {
  static func decoder(_ decoder: JSONDecoder) {
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .custom(DateFormatterDecoder.RSS.decoder.decode(from:))
  }

  static func decoder(_ decoder: XMLDecoder) {
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .custom(DateFormatterDecoder.RSS.decoder.decode(from:))
    decoder.trimValueWhitespaces = false
  }
}

extension Feed {
  var title: String {
    switch self {
    case let .atom(feed):
      return feed.title
    case let .rss(rss):
      return rss.channel.title
    case let .json(json):
      return json.title
    }
  }

  var homePageUrl: URL? {
    switch self {
    case let .atom(feed):
      return feed.link.first { $0.rel == "alternate" }?.href
    case let .rss(rss):
      return rss.channel.link
    case let .json(json):
      return json.homePageUrl
    }
  }

  var description: String? {
    switch self {
    case let .atom(feed):
      return feed.description ?? feed.subtitle
    case let .rss(rss):
      return rss.channel.description
    case let .json(json):
      return json.description
    }
  }

  var items: [Entryable] {
    switch self {
    case let .atom(feed):
      return feed.entry
    case let .rss(rss):
      return rss.channel.item
    case let .json(json):
      return json.items
    }
  }

  var entries: [AnyEntry] {
    return items.map(AnyEntry.init(from:))
  }
}
