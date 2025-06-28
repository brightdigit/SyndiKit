import Foundation

extension PodcastLocation {
  /// A ``struct`` representing a geographic URI for a podcast location.
  public struct GeoURI: Codable, Equatable, LosslessStringConvertible, Sendable {
    /// The latitude coordinate.
    public let latitude: Double

    /// The longitude coordinate.
    public let longitude: Double

    /// The altitude coordinate, if available.
    public let altitude: Double?

    /// The accuracy of the coordinates, if available.
    public let accuracy: Double?

    /// A string representation of the geographic URI.
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

    /// Initializes a ``GeoURI`` instance with the specified coordinates.
    ///
    /// - Parameters:
    ///   - latitude: The latitude coordinate.
    ///   - longitude: The longitude coordinate.
    ///   - altitude: The altitude coordinate, if available.
    ///   - accuracy: The accuracy of the coordinates, if available.
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

    /// Initializes a ``GeoURI`` instance from a string representation.
    ///
    /// - Parameter description: The string representation of the geographic URI.
    public init?(_ description: String) {
      try? self.init(singleValue: description)
    }

    // swiftlint:disable function_body_length
    /// Initializes a ``GeoURI`` instance from a single value string.
    ///
    /// - Parameter singleValue: The single value string representing the geographic URI.
    /// - Throws: A ``DecodingError`` if the single value string is invalid.
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

    // swiftlint:enable function_body_length

    /// Initializes a ``GeoURI`` instance from a decoder.
    ///
    /// - Parameter decoder: The decoder to read data from.
    /// - Throws: A ``DecodingError`` if the decoding process fails.
    public init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()
      let singleValue = try container.decode(String.self)

      try self.init(singleValue: singleValue)
    }

    private static func pathComponents(from string: String) throws -> [Substring] {
      let components = string.split(separator: ":")

      guard
        components[safe: 0] == "geo"
      else {
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

    /// Encodes the ``GeoURI`` instance into the given encoder.
    ///
    /// - Parameter encoder: The encoder to write data to.
    /// - Throws: An error if the encoding process fails.
    public func encode(to encoder: Encoder) throws {
      var container = encoder.singleValueContainer()
      try container.encode(description)
    }
  }
}
