import Foundation

public struct RSSAuthor: Codable, Equatable {
  internal init(name: String) {
    self.name = name
    email = nil
    uri = nil
  }

  public let name: String
  public let email: String?
  public let uri: URL?
}
