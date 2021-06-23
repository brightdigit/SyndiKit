import Foundation

struct RSSJSONItem: Codable {
  let guid: RSSGUID
  let url: URL
  let title: String
  let contentHtml: String?
  let summary: String?
  let datePublished: Date?
  let author: RSSAuthor?
}
