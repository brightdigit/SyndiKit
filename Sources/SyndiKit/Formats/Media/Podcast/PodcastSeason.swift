import Foundation

public struct PodcastSeason: Codable, Equatable {
  public enum CodingKeys: String, CodingKey {
    case name
    case number = ""
  }

  public let name: String?
  public let number: Int
}
