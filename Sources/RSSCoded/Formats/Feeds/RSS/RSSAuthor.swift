import Foundation

public struct RSSAuthor: Codable, Equatable {
  public let name: String
  public let email: String?
  public let uri: URL?
}
