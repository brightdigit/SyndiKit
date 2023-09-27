import Foundation

/// ```xml
/// <podcast:person
///   group="writing"
///   role="guest"
///   href="https://www.wikipedia/alicebrown"
///   img="http://example.com/images/alicebrown.jpg"
/// >
///   Alice Brown
/// </podcast:person>
public struct PodcastPerson: Codable, Equatable {
  public let role: Role?
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
    group = try container.decodeIfPresent(String.self, forKey: .group)
    fullname = try container.decode(String.self, forKey: .fullname)

    if let roleStr = try container.decodeIfPresent(String.self, forKey: .role) {
      role = Role(caseInsensitive: roleStr)
    } else {
      role = nil
    }

    let hrefUrl = try container.decodeIfPresent(String.self, forKey: .href) ?? ""
    href = hrefUrl.isEmpty ? nil : URL(string: hrefUrl)

    let imgUrl = try container.decodeIfPresent(String.self, forKey: .img) ?? ""
    img = imgUrl.isEmpty ? nil : URL(string: imgUrl)
  }
}
