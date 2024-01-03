import Foundation

public struct PodcastLocation: Codable, Equatable {
  internal enum CodingKeys: String, CodingKey {
    case geo
    case osmQuery = "osm"

    case name = ""
  }

  public let geo: GeoURI?
  public let osmQuery: OsmQuery?

  public let name: String
}
