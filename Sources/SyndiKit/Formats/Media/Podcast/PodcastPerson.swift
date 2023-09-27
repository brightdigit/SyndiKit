import Foundation

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
    self.group = try container.decodeIfPresent(String.self, forKey: .group)
    self.fullname = try container.decode(String.self, forKey: .fullname)

    if let roleStr = try container.decodeIfPresent(String.self, forKey: .role) {
      self.role = Role(caseInsensitive: roleStr)
    } else {
      self.role = nil
    }

    let hrefUrl = try container.decodeIfPresent(String.self, forKey: .href) ?? ""
    self.href = hrefUrl.isEmpty ? nil : URL(string: hrefUrl)

    let imgUrl = try container.decodeIfPresent(String.self, forKey: .img) ?? ""
    self.img = imgUrl.isEmpty ? nil : URL(string: imgUrl)
  }
}
