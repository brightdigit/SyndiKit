import Foundation

extension PodcastLocation {
  public struct GeoURI: Codable, Equatable {
    let latitude: Double
    let longitude: Double
    let altitude: Double?
    let accuracy: Double?

    public init(latitude: Double, longitude: Double, altitude: Double? = nil, accuracy: Double? = nil) {
      self.latitude = latitude
      self.longitude = longitude
      self.altitude = altitude
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
      let altitude = geoCoords.split(separator: ",")[safe: 2]?.asDouble()
      let accuracy = geoPath.split(separator: ";")[safe: 1]?
        .split(separator: "=")[safe: 1]?
        .asDouble()

      self.latitude = latitude
      self.longitude = longitude
      self.altitude = altitude
      self.accuracy = accuracy
    }
  }
}
