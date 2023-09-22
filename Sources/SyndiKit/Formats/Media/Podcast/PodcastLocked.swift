import Foundation

/// <podcast:locked owner="leogdion@brightdigit.com">no</podcast:locked>
public struct PodcastLocked: Codable {
  public let owner: String?
  public let value: String

  enum CodingKeys: String, CodingKey {
    case owner
    case value = ""
  }
}
