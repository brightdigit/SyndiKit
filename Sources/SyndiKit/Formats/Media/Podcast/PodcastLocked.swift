import Foundation

/// <podcast:locked owner="leogdion@brightdigit.com">no</podcast:locked>
public struct PodcastLocked: Codable {
  public let owner: String?
  public let isLocked: Bool

  enum CodingKeys: String, CodingKey {
    case owner
    case isLocked = ""
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    owner = try container.decodeIfPresent(String.self, forKey: .owner)
    isLocked = try container.decode(String.self, forKey: .isLocked).lowercased() == "yes"
  }
}
