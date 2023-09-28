import Foundation

public struct PodcastSeason: Codable, Equatable {
  public let name: String?
  public let number: Int

  enum CodingKeys: String, CodingKey {
    case name
    case number = ""
  }
}
