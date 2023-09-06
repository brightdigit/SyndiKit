import Foundation

public struct PodcastPerson: Codable {
  public let email: String?
  public let role: String
  public let href: String
  public let img: String?

  public let name: String

  enum CodingKeys: String, CodingKey {
    case email
    case role
    case href
    case img
    case name = ""
  }
}
