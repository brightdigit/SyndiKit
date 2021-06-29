import Foundation

public struct RSSImage: Codable {
  public let url: URL
  public let title: String
  public let link: URL
  public let width: Int?
  public let height: Int?
}
