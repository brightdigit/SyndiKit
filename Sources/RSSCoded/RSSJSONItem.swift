import Foundation

public struct RSSJSONItem: Codable, Equatable {
  public let guid: RSSGUID
  public let url: URL
  public let title: String
  public let contentHtml: String?
  public let summary: String?
  public let datePublished: Date?
  public let author: RSSAuthor?
}
