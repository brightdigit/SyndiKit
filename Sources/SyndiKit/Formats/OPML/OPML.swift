import Foundation

public struct OPML: Codable, Equatable {
  public let version: String

  public let head: Head
  public let body: Body

  enum CodingKeys: String, CodingKey {
    case version
    case head
    case body
  }
}
