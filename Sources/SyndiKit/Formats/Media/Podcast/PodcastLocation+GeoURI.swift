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
  }
}
