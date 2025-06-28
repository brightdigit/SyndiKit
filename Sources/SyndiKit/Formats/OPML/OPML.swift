import Foundation

public struct OPML: Codable, Equatable, Sendable {
  internal enum CodingKeys: String, CodingKey {
    case version
    case head
    case body
  }

  public let version: String

  public let head: Head
  public let body: Body
}
