import Foundation

extension PodcastLocation {
  /// Examples:
  ///   - The United States of America: `R148838`
  ///   - The Eiffel Tower in Paris: `W5013364`
  ///   - Paris, but - optionally - the revision made on 8 Jan 2021: `R7444#188`
  public struct OsmQuery: Codable, Equatable {
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
}
