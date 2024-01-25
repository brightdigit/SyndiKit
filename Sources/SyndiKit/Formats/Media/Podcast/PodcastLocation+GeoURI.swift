import Foundation

extension PodcastLocation {
  public struct GeoURI: Codable, Equatable, LosslessStringConvertible {
    public let latitude: Double
    public let longitude: Double
    public let altitude: Double?
    public let accuracy: Double?

    public var description: String {
      var description = "geo:\(latitude),\(longitude)"

      if let altitude = altitude {
        description += ",\(altitude)"
      }

      if let accuracy = accuracy {
        description += ";u=\(accuracy)"
      }

      return description
    }

    public init(
      latitude: Double,
      longitude: Double,
      altitude: Double? = nil,
      accuracy: Double? = nil
    ) {
      self.latitude = latitude
      self.longitude = longitude
      self.altitude = altitude
      self.accuracy = accuracy
    }

    public init?(_ description: String) {
      try? self.init(singleValue: description)
    }

    // swiftlint:disable:next function_body_length
    public init(singleValue: String) throws {
      let pathComponents = try Self.pathComponents(from: singleValue)

      guard
        let geoCoords = pathComponents[safe: 0]?.split(separator: ","),
        let latitude = geoCoords[safe: 0]?.asDouble(),
        let longitude = geoCoords[safe: 1]?.asDouble()
      else {
        throw DecodingError.dataCorrupted(
          codingKey: PodcastLocation.CodingKeys.geo,
          debugDescription: "Invalid coordinates for geo attribute: \(singleValue)"
        )
      }

      let altitude = geoCoords[safe: 2]?.asDouble()

      let accuracy = pathComponents[safe: 1]?
        .split(separator: "=")[safe: 1]?
        .asDouble()

      self.init(
        latitude: latitude,
        longitude: longitude,
        altitude: altitude,
        accuracy: accuracy
      )
    }

    public init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()
      let singleValue = try container.decode(String.self)

      try self.init(singleValue: singleValue)
    }

    private static func pathComponents(from string: String) throws -> [Substring] {
      let components = string.split(separator: ":")

      guard
        components[safe: 0] == "geo" else {
        throw DecodingError.dataCorrupted(
          codingKey: PodcastLocation.CodingKeys.geo,
          debugDescription: "Invalid prefix for geo attribute: \(string)"
        )
      }
      guard let geoPath = components[safe: 1] else {
        throw DecodingError.dataCorrupted(
          codingKey: PodcastLocation.CodingKeys.geo,
          debugDescription: "Invalid path for geo attribute: \(string)"
        )
      }

      return geoPath.split(separator: ";")
    }

    public func encode(to encoder: Encoder) throws {
      var container = encoder.singleValueContainer()
      try container.encode(description)
    }
  }
}
