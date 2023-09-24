import Foundation

/// <podcast:location geo="geo:30.2672,97.7431" osm="R113314">Austin, TX</podcast:location>
public struct PodcastLocation: Codable {
  public let geo: String
  public let osm: String

  public let name: String

  enum CodingKeys: String, CodingKey {
    case geo
    case osm

    case name = ""
  }
}
