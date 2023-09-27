import Foundation

/// ```xml
/// <podcast:location 
///   geo="geo:30.2672,97.7431"
///   osm="R113314"
/// >
///   Austin, TX
///  </podcast:location>
/// ```
public struct PodcastLocation: Codable, Equatable {
  public let geo: GeoURI
  public let osm: OsmQuery

  public let name: String

  enum CodingKeys: String, CodingKey {
    case geo
    case osm

    case name = ""
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.geo = try container.decode(GeoURI.self, forKey: .geo)
    self.osm = try container.decode(OsmQuery.self, forKey: .osm)
    self.name = try container.decode(String.self, forKey: .name)
  }
}
