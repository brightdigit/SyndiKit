import Foundation
enum RSSFeed {
  case rss(RSS)
  case feed(Feed)
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
}
