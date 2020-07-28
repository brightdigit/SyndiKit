import Foundation

public struct Item: Codable {
  public let siteUrl: URL
  public let id: String
  public let title: String
  public let summary: String
  public let content: String?
  public let url: URL
  public let image: URL?
  public let ytId: String?
  public let audio: URL?
  public let published: Date
}
