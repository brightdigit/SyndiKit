import Foundation

public struct PodcastLocked: Codable {
  public let owner: String?

  public let value: String

  enum CodingKeys: String, CodingKey {
    case owner
    
    case value = ""
  }
}
