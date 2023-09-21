import Foundation

public struct PodcastLocation: Codable {
  public let geo: String
  public let osm: String

  public let value: String

  enum CodingKeys: String, CodingKey {
    case geo
    case osm

    case value = ""
  }
}
