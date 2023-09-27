import Foundation

extension Character {
  func asOsmType() -> PodcastLocation.OsmQuery.OsmType? {
    .init(rawValue: String(self))
  }
}
