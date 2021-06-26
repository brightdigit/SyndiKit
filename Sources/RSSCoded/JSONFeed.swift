import Foundation
struct JSONFeed: Codable {
  let version: URL
  let title: String
  let homePageUrl: URL
  let description: String?
  let author: RSSAuthor?
  let items: [JSONItem]
}
