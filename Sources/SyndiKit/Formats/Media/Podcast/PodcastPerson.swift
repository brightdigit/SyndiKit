import Foundation

/// <podcast:person
/// group="writing"
/// role="guest"
/// href="https://www.wikipedia/alicebrown"
/// img="http://example.com/images/alicebrown.jpg"
/// >Alice Brown</podcast:person>
public struct PodcastPerson: Codable {
  public let role: String?
  public let group: String?
  public let href: String?
  public let img: URL?

  public let fullname: String

  enum CodingKeys: String, CodingKey {
    case role
    case group
    case href
    case img
    case fullname = ""
  }
}
