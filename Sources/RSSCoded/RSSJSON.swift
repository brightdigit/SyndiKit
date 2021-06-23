import Foundation
struct RSSJSON: Codable {
  let version: URL
  let title: String
  let homePageUrl: URL
  let description: String?
  let author: RSSAuthor?
  let items: [RSSJSONItem]
}
