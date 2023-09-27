import Foundation

public struct PodcastLocation: Codable, Equatable {
  public let geo: GeoURI?
  public let osmQuery: OsmQuery?

  public let name: String

  enum CodingKeys: String, CodingKey {
    case geo
    case osmQuery = "osm"

    case name = ""
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.geo = try container.decodeIfPresent(GeoURI.self, forKey: .geo)
    self.osmQuery = try container.decodeIfPresent(OsmQuery.self, forKey: .osmQuery)
    self.name = try container.decode(String.self, forKey: .name)
  }
}
