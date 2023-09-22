import Foundation

/// <podcast:person
/// group="writing"
/// role="guest"
/// href="https://www.wikipedia/alicebrown"
/// img="http://example.com/images/alicebrown.jpg"
/// >Alice Brown</podcast:person>
public struct PodcastPerson: Codable {
  public enum PersonRole: String, Codable {
    case guest
    case host
    case editor
    case writer
    case designer
    case composer
    case producer
  }

  public let role: PersonRole?
  public let group: String?
  public let href: URL?
  public let img: URL?

  public let fullname: String

  enum CodingKeys: String, CodingKey {
    case role
    case group
    case href
    case img
    case fullname = ""
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.role = try container.decodeIfPresent(PersonRole.self, forKey: .role)
    self.group = try container.decodeIfPresent(String.self, forKey: .group)
    self.fullname = try container.decode(String.self, forKey: .fullname)

    let hrefUrl = try container.decodeIfPresent(String.self, forKey: .href) ?? ""
    self.href = hrefUrl.isEmpty ? nil : URL(string: hrefUrl)

    let imgUrl = try container.decodeIfPresent(String.self, forKey: .img) ?? ""
    self.img = imgUrl.isEmpty ? nil : URL(string: imgUrl)
  }
}
