import Foundation

/// ```xml
/// <podcast:location 
///   geo="geo:30.2672,97.7431"
///   osm="R113314"
/// >
///   Austin, TX
///  </podcast:location>
/// ```
public struct PodcastLocation: Codable {
  /// Examples:
  ///   - `geo:37.786971,-122.399677`, a simple latlon description.
  ///   - `geo:37.786971,-122.399677,250`, a latlon including a height of 250 meters above ground level.
  ///   - `geo:37.786971,-122.399677;u=350`, a latlon with an accuracy ('uncertainty') of 350 meters.
  public struct GeoURI: Codable {
    let latitude: Double
    let longitude: Double
    let altitude: Double?
    let height: Int?
    let accuracy: Double?

    public init(latitude: Double, longitude: Double, altitude: Double? = nil, height: Int? = nil, accuracy: Double? = nil) {
      self.latitude = latitude
      self.longitude = longitude
      self.altitude = altitude
      self.height = height
      self.accuracy = accuracy
    }
  }

  /// Examples:
  ///   - The United States of America: `R148838`
  ///   - The Eiffel Tower in Paris: `W5013364`
  ///   - Paris, but - optionally - the revision made on 8 Jan 2021: `R7444#188`
  public struct OsmQuery: Codable {
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
  }

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
    let altitude = geoCoords.split(separator: ",")[safe: 2]?.asDouble()
    let height = geoCoords.split(separator: ",")[safe: 2]?.asExactInt()
    let accuracy = geoPath.split(separator: ";")[safe: 1]?
      .split(separator: "=")[safe: 1]?
      .asDouble()
    self.geo = .init(latitude: latitude, longitude: longitude, altitude: altitude, height: height, accuracy: accuracy)

    
    var osmStr = try container.decode(String.self, forKey: .osm)

    guard let osmType = osmStr.removeFirst().asOsmType() else {
      throw DecodingError.dataCorruptedError(
        forKey: .osm,
        in: container,
        debugDescription: "Invalid type for osm attribute: \(osmStr)"
      )
    }
    guard let osmID = osmStr.split(separator: "#")[safe: 0]?.asInt() else {
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
