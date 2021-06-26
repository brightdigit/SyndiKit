import Foundation
enum Feed {
  case rss(RSS)
  case atom(AtomFeed)
}

protocol Entryable {
  var guid: RSSGUID { get }
  var url: URL { get }
  var title: String { get }
  var contentHtml: String? { get }
  var summary: String? { get }
  var datePublished: Date? { get }
  var rssAuthor: RSSAuthor? { get }
}

extension Feed {
  var title: String {
    switch self {
    case let .atom(feed):
      return feed.title
    case let .rss(rss):
      return rss.channel.title
    }
  }

  var homePageUrl: URL? {
    switch self {
    case let .atom(feed):
      return feed.link.first { $0.rel == "alternate" }?.href
    case let .rss(rss):
      return rss.channel.link
    }
  }

  var description: String? {
    switch self {
    case let .atom(feed):
      return feed.description ?? feed.subtitle
    case let .rss(rss):
      return rss.channel.description
    }
  }

  var items: [Entryable] {
    switch self {
    case let .atom(feed):
      return feed.entry
    case let .rss(rss):
      return rss.channel.item
    }
  }

  var entries: [AnyEntry] {
    return items.map(AnyEntry.init(from:))
  }
}
