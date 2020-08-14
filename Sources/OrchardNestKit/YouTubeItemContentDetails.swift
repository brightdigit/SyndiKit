import Foundation

public struct YouTubeItemContentDetails: Decodable {
  public let duration: TimeInterval

  enum CodingKeys: String, CodingKey {
    case duration
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let durationString = try container.decode(String.self, forKey: .duration)
    duration = try TimeInterval(iso8601: durationString)
  }
}
