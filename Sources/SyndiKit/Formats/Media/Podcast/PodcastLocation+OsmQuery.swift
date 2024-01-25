import Foundation

extension PodcastLocation {
  /// Represents a query for OpenStreetMap (OSM) data.
  public struct OsmQuery: Codable, Equatable {
    /// The type of OSM element.
    public enum OsmType: String, Codable, CaseIterable {
      case node = "N"
      case way = "W"
      case relation = "R"
    }

    /// The ID of the OSM element.
    public let id: Int

    /// The type of the OSM element.
    public let type: OsmType

    /// The revision number of the OSM element.
    public let revision: Int?

    /// Initializes an `OsmQuery` instance from a decoder.
    ///
    /// - Parameter decoder: The decoder to read data from.
    /// - Throws: `DecodingError.dataCorrupted` if the data is invalid.
    public init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()

      var osmStr = try container.decode(String.self)

      guard let osmType = osmStr.removeFirst().asOsmType() else {
        throw DecodingError.dataCorrupted(
          codingKey: PodcastLocation.CodingKeys.osmQuery,
          debugDescription: "Invalid type for osm attribute: \(osmStr)"
        )
      }
      guard let osmID = osmStr.split(separator: "#")[safe: 0]?.asExactInt() else {
        throw DecodingError.dataCorrupted(
          codingKey: PodcastLocation.CodingKeys.osmQuery,
          debugDescription: "Invalid id of type Int for osm attribute: \(osmStr)"
        )
      }
      let osmRevision = osmStr.split(separator: "#")[safe: 1]?.asInt()

      id = osmID
      type = osmType
      revision = osmRevision
    }
  }
}
