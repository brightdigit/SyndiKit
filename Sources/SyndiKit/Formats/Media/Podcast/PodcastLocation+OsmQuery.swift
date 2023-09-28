import Foundation

public extension PodcastLocation {
  struct OsmQuery: Codable, Equatable {
    enum OsmType: String, Codable, CaseIterable {
      case node = "N"
      case way = "W"
      case relation = "R"

      static func isValid(_ rawValue: String) -> Bool {
        OsmType(rawValue: rawValue) != nil
      }
    }

    let id: Int
    let type: OsmType
    let revision: Int?

    public init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()

      var osmStr = try container.decode(String.self)

      guard let osmType = osmStr.removeFirst().asOsmType() else {
        throw DecodingError.dataCorrupted(
          .init(
            codingPath: [PodcastLocation.CodingKeys.osmQuery],
            debugDescription: "Invalid type for osm attribute: \(osmStr)"
          )
        )
      }
      guard let osmID = osmStr.split(separator: "#")[safe: 0]?.asExactInt() else {
        throw DecodingError.dataCorrupted(
          .init(
            codingPath: [PodcastLocation.CodingKeys.osmQuery],
            debugDescription: "Invalid id of type Int for osm attribute: \(osmStr)"
          )
        )
      }
      let osmRevision = osmStr.split(separator: "#")[safe: 1]?.asInt()

      id = osmID
      type = osmType
      revision = osmRevision
    }
  }
}
