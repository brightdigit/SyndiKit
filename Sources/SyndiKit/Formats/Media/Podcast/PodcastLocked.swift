import Foundation

/// <podcast:locked owner="leogdion@brightdigit.com">no</podcast:locked>
public struct PodcastLocked: Codable {
  public let owner: String?
  public let value: Bool

  enum CodingKeys: String, CodingKey {
    case owner
    case value = ""
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.owner = try container.decodeIfPresent(String.self, forKey: .owner)
    self.value = try container.decode(String.self, forKey: .value) == "yes"
  }
}
