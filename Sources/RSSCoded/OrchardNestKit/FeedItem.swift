import Foundation

public struct FeedItem: Codable {
  public let siteUrl: URL
  public let id: String
  public let title: String
  public let summary: String
  public let content: String?
  public let url: URL
  public let image: URL?
  public let ytId: String?
  public let audio: URL?
  public let duration: TimeInterval?
  public let published: Date
}
