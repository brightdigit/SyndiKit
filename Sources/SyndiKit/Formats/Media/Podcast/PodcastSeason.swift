import Foundation

public struct PodcastSeason: Codable {
  public let name: String?

  public let value: Int

  enum CodingKeys: String, CodingKey {
    case name

    case value = ""
  }
}
