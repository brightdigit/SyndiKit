import Foundation

/// A struct representing a person associated with a podcast.
public struct PodcastPerson: Codable, Equatable, Sendable {
  /// The role of the person.
  public enum CodingKeys: String, CodingKey {
    case role
    case group
    case href
    case img
    case fullname = ""
  }

  /// The role of the person.
  public let role: Role?

  /// The group the person belongs to.
  public let group: String?

  /// The URL associated with the person.
  public let href: URL?

  /// The URL of the person's image.
  public let img: URL?

  /// The full name of the person.
  public let fullname: String

  /// Initializes a new instance of ``PodcastPerson``
  /// by decoding data from the given decoder.
  ///
  /// - Parameter decoder: The decoder to read data from.
  /// - Throws: An error if the decoding process fails.
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    role = try container.decodeIfPresent(Role.self, forKey: .role)
    group = try container.decodeIfPresent(String.self, forKey: .group)
    fullname = try container.decode(String.self, forKey: .fullname)

    let hrefUrl = try container.decodeIfPresent(String.self, forKey: .href) ?? ""
    href = hrefUrl.isEmpty ? nil : URL(string: hrefUrl)

    let imgUrl = try container.decodeIfPresent(String.self, forKey: .img) ?? ""
    img = imgUrl.isEmpty ? nil : URL(string: imgUrl)
  }
}
