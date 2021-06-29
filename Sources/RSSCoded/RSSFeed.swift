import Foundation
struct RSSFeed: Codable {
  let channel: RSSChannel
}

extension RSSFeed: Feedable {
  var youtubeChannelID: String? {
    return nil
  }

  var author: RSSAuthor? {
    return channel.author
  }

  var feedItems: [Entryable] {
    return channel.item
  }

  var title: String {
    return channel.title
  }

  var siteURL: URL? {
    return channel.link
  }

  var summary: String? {
    return channel.description
  }

  var updated: Date? {
    return channel.lastBuildDate
  }

  var copyright: String? {
    return channel.copyright
  }

  var image: URL? {
    return channel.image?.link
  }

  var syndication: SyndicationUpdate? {
    return channel.syndication
  }
}
