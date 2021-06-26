import Foundation
enum RSSFeed {
  case rss(RSS)
  case feed(Feed)
}

protocol RSSFeedItem {
  var guid: RSSGUID { get }
  var url: URL { get }
  var title: String { get }
  var contentHtml: String? { get }
  var summary: String? { get }
  var datePublished: Date? { get }
  var rssAuthor: RSSAuthor? { get }
}

extension RSSFeed {
  var title: String {
    switch self {
    case let .feed(feed):
      return feed.title
    case let .rss(rss):
      return rss.channel.title
    }
  }

  var homePageUrl: URL? {
    switch self {
    case let .feed(feed):
      return feed.link.first { $0.rel == "alternate" }?.href
    case let .rss(rss):
      return rss.channel.link
    }
  }

  var description: String? {
    switch self {
    case let .feed(feed):
      return feed.description ?? feed.subtitle
    case let .rss(rss):
      return rss.channel.description
    }
  }

  var items: [RSSFeedItem] {
    switch self {
    case let .feed(feed):
      return feed.entry
    case let .rss(rss):
      return rss.channel.item
    }
  }

  var rssJSONItems: [RSSJSONItem] {
    return items.map(RSSJSONItem.init(from:))
  }
}
