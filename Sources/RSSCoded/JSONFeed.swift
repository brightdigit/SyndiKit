import Foundation
struct JSONFeed: Codable {
  let version: URL
  let title: String
  let homePageUrl: URL
  let description: String?
  let author: RSSAuthor?
  let items: [JSONItem]
}

extension JSONFeed: Feedable {
  var youtubeChannelID: String? {
    return nil
  }

  var feedItems: [Entryable] {
    return items
  }

  var summary: String? {
    return description
  }

  var siteURL: URL? {
    return homePageUrl
  }

  var updated: Date? {
    return nil
  }

  var copyright: String? {
    return nil
  }

  var image: URL? {
    return nil
  }
}
