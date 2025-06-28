//
//  PodcastLocation+OsmQuery.swift
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

import Foundation

extension PodcastLocation {
  /// Represents a query for OpenStreetMap (OSM) data.
  public struct OsmQuery: Codable, Equatable, Sendable {
    // swiftlint:disable nesting
    /// The type of OSM element.
    public enum OsmType: String, Codable, CaseIterable, Sendable {
      case node = "N"
      case way = "W"
      case relation = "R"
    }

    // swiftlint:enable nesting

    /// The ID of the OSM element.
    public let id: Int

    /// The type of the OSM element.
    public let type: OsmType

    /// The revision number of the OSM element.
    public let revision: Int?

    /// Initializes an ``OsmQuery`` instance from a decoder.
    ///
    /// - Parameter decoder: The decoder to read data from.
    /// - Throws: `DecodingError.dataCorrupted` if the data is invalid.
    public init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()
      let osmStr = try container.decode(String.self)

      let osmType = try Self.parseOsmType(from: osmStr)
      let osmID = try Self.parseOsmID(from: osmStr)
      let osmRevision = Self.parseOsmRevision(from: osmStr)

      id = osmID
      type = osmType
      revision = osmRevision
    }

    private static func parseOsmType(from osmStr: String) throws -> OsmType {
      var mutableStr = osmStr
      guard let osmType = mutableStr.removeFirst().asOsmType() else {
        throw DecodingError.dataCorrupted(
          codingKey: PodcastLocation.CodingKeys.osmQuery,
          debugDescription: "Invalid type for osm attribute: \(osmStr)"
        )
      }
      return osmType
    }

    private static func parseOsmID(from osmStr: String) throws -> Int {
      guard let osmID = osmStr.split(separator: "#")[safe: 0]?.asExactInt() else {
        throw DecodingError.dataCorrupted(
          codingKey: PodcastLocation.CodingKeys.osmQuery,
          debugDescription: "Invalid id of type Int for osm attribute: \(osmStr)"
        )
      }
      return osmID
    }

    private static func parseOsmRevision(from osmStr: String) -> Int? {
      osmStr.split(separator: "#")[safe: 1]?.asInt()
    }
  }
}
