import Foundation
enum Feed {
  case rss(RSS)
  case atom(AtomFeed)
  case json(JSONFeed)
}

protocol Entryable {
  var guid: RSSGUID { get }
  var url: URL { get }
  var title: String { get }
  var contentHtml: String? { get }
  var summary: String? { get }
  var datePublished: Date? { get }
  var author: RSSAuthor? { get }
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
