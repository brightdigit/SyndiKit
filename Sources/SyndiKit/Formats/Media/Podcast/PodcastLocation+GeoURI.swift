//
//  PodcastLocation+GeoURI.swift
//  SyndiKit
//
//  Created by Leo Dion.
//  Copyright © 2025 BrightDigit.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the “Software”), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#if swift(<6.1)
  import Foundation
#else
  internal import Foundation
#endif

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

    /// Initializes a ``GeoURI`` instance from a single value string.
    ///
    /// - Parameter singleValue: The single value string representing the geographic URI.
    /// - Throws: A ``DecodingError`` if the single value string is invalid.
    public init(singleValue: String) throws {
      let pathComponents = try Self.pathComponents(from: singleValue)
      let coordinates = try Self.parseCoordinates(
        from: pathComponents,
        singleValue: singleValue
      )
      let altitude = Self.parseAltitude(from: pathComponents)
      let accuracy = Self.parseAccuracy(from: pathComponents)

      self.init(
        latitude: coordinates.latitude,
        longitude: coordinates.longitude,
        altitude: altitude,
        accuracy: accuracy
      )
    }

    private static func parseCoordinates(
      from pathComponents: [Substring],
      singleValue: String
    ) throws -> (latitude: Double, longitude: Double) {
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
      return (latitude: latitude, longitude: longitude)
    }

    private static func parseAltitude(from pathComponents: [Substring]) -> Double? {
      pathComponents[safe: 0]?.split(separator: ",")[safe: 2]?.asDouble()
    }

    private static func parseAccuracy(from pathComponents: [Substring]) -> Double? {
      pathComponents[safe: 1]?.split(separator: "=")[safe: 1]?.asDouble()
    }

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

      guard components.first == "geo" else {
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
