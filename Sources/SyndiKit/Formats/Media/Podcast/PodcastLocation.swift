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
    self.name = try container.decode(String.self, forKey: .name)


    let geoStr = try container.decode(String.self, forKey: .geo)

    guard 
      let geoScheme = geoStr.split(separator: ":")[safe: 0],
      geoScheme == "geo" else {
      throw DecodingError.dataCorruptedError(
        forKey: .geo,
        in: container,
        debugDescription: "Invalid prefix for geo attribute: \(geoStr)"
      )
    }
    guard let geoPath = geoStr.split(separator: ":")[safe: 1] else {
      throw DecodingError.dataCorruptedError(
        forKey: .geo,
        in: container,
        debugDescription: "Invalid path for geo attribute: \(geoStr)"
      )
    }
    guard 
      let geoCoords = geoPath.split(separator: ";")[safe: 0],
      let latitude = geoCoords.split(separator: ",")[safe: 0]?.asDouble(),
      let longitude = geoCoords.split(separator: ",")[safe: 1]?.asDouble()
    else {
      throw DecodingError.dataCorruptedError(
        forKey: .geo,
        in: container,
        debugDescription: "Invalid coordinates for geo attribute: \(geoStr)"
      )
    }
    let height = geoCoords.split(separator: ",")[safe: 2]?.asExactInt()
    let accuracy = geoPath.split(separator: ";")[safe: 1]?
      .split(separator: "=")[safe: 1]?
      .asDouble()
    self.geo = .init(latitude: latitude, longitude: longitude, height: height, accuracy: accuracy)

    
    var osmStr = try container.decode(String.self, forKey: .osm)

    guard let osmType = osmStr.removeFirst().asOsmType() else {
      throw DecodingError.dataCorruptedError(
        forKey: .osm,
        in: container,
        debugDescription: "Invalid type for osm attribute: \(osmStr)"
      )
    }
    guard let osmID = osmStr.split(separator: "#")[safe: 0]?.asExactInt() else {
      throw DecodingError.dataCorruptedError(
        forKey: .osm,
        in: container,
        debugDescription: "Invalid id of type Int for osm attribute: \(osmStr)"
      )
    }
    let osmRevision = osmStr.split(separator: "#")[safe: 1]?.asInt()
    self.osm = .init(id: osmID, type: osmType, revision: osmRevision)
  }
}
