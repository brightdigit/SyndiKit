import Foundation

extension Character {
  internal func asOsmType() -> PodcastLocation.OsmQuery.OsmType? {
    .init(rawValue: String(self))
  }
}
