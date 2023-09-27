import Foundation

extension PodcastLocation {
  /// Examples:
  ///   - `geo:37.786971,-122.399677`, a simple latlon description.
  ///   - `geo:37.786971,-122.399677,250`, a latlon including a height of 250 meters above ground level.
  ///   - `geo:37.786971,-122.399677;u=350`, a latlon with an accuracy ('uncertainty') of 350 meters.
  public struct GeoURI: Codable, Equatable {
    let latitude: Double
    let longitude: Double
    let height: Int?
    let accuracy: Double?

    public init(latitude: Double, longitude: Double, height: Int? = nil, accuracy: Double? = nil) {
      self.latitude = latitude
      self.longitude = longitude
      self.height = height
      self.accuracy = accuracy
    }

    public init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()
      let geoStr = try container.decode(String.self)

      guard
        let geoScheme = geoStr.split(separator: ":")[safe: 0],
        geoScheme == "geo" else {
        throw DecodingError.dataCorrupted(
          .init(
            codingPath: [PodcastLocation.CodingKeys.geo],
            debugDescription: "Invalid prefix for geo attribute: \(geoStr)"
          )
        )
      }
      guard let geoPath = geoStr.split(separator: ":")[safe: 1] else {
        throw DecodingError.dataCorrupted(
          .init(
            codingPath: [PodcastLocation.CodingKeys.geo],
            debugDescription: "Invalid path for geo attribute: \(geoStr)"
          )
        )
      }
      guard
        let geoCoords = geoPath.split(separator: ";")[safe: 0],
        let latitude = geoCoords.split(separator: ",")[safe: 0]?.asDouble(),
        let longitude = geoCoords.split(separator: ",")[safe: 1]?.asDouble()
      else {
        throw DecodingError.dataCorrupted(
          .init(
            codingPath: [PodcastLocation.CodingKeys.geo],
            debugDescription: "Invalid coordinates for geo attribute: \(geoStr)"
          )
        )
      }
      let height = geoCoords.split(separator: ",")[safe: 2]?.asExactInt()
      let accuracy = geoPath.split(separator: ";")[safe: 1]?
        .split(separator: "=")[safe: 1]?
        .asDouble()

      self.latitude = latitude
      self.longitude = longitude
      self.height = height
      self.accuracy = accuracy
    }
  }
}
