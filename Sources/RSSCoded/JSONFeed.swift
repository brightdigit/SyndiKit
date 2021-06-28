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
  var url: URL? {
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
