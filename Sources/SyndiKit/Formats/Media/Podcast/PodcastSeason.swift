import Foundation

/// <podcast:season>5</podcast:season>
/// <podcast:season name="Race for the Whitehouse 2020">3</podcast:season>
public struct PodcastSeason: Codable {
  public let name: String?
  public let number: Int

  enum CodingKeys: String, CodingKey {
    case name
    case number = ""
  }
}
