import Foundation

/// A struct representing the location of a podcast.
public struct PodcastLocation: Codable, Equatable {
  /// The geographic coordinates of the location.
  internal enum CodingKeys: String, CodingKey {
    case geo
    case osmQuery = "osm"

    case name = ""
  }

  /// The geographic coordinates of the location.
  public let geo: GeoURI?

  /// The OpenStreetMap query for the location.
  public let osmQuery: OsmQuery?

  /// The name of the location.
  public let name: String
}
