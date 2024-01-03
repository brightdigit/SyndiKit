import Foundation

public struct PodcastLocked: Codable, Equatable {
  public enum CodingKeys: String, CodingKey {
    case owner
    case isLocked = ""
  }

  public let owner: String?
  public let isLocked: Bool

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    owner = try container.decodeIfPresent(String.self, forKey: .owner)
    isLocked = try container.decode(String.self, forKey: .isLocked).lowercased() == "yes"
  }
}
