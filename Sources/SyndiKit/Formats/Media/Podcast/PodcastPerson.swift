import Foundation

/// <podcast:person
/// group="writing"
/// role="guest"
/// href="https://www.wikipedia/alicebrown"
/// img="http://example.com/images/alicebrown.jpg"
/// >Alice Brown</podcast:person>
public struct PodcastPerson: Codable {
  public enum PersonRole: Codable, Equatable {
    case guest
    case host
    case editor
    case writer
    case designer
    case composer
    case producer

    case unknown(String)

    public var rawValue: String {
      switch self {
      case .guest: return "guest"
      case .host: return "host"
      case .editor: return "editor"
      case .writer: return "writer"
      case .designer: return "designer"
      case .composer: return "composer"
      case .producer: return "producer"
      case .unknown(let string): return "\(string)"
      }
    }

    public init(value: String) {
      guard let role = PersonRole(rawValue: value.lowercased()) else {
        self = Self.unknown(value)
        return
      }

      self = role
    }

    public init?(rawValue: String) {
      switch rawValue {
      case Self.guest.rawValue:
        self = .guest
      case Self.host.rawValue:
        self = .host
      case Self.editor.rawValue:
        self = .editor
      case Self.writer.rawValue:
        self = .writer
      case Self.designer.rawValue:
        self = .designer
      case Self.composer.rawValue:
        self = .composer
      case Self.producer.rawValue:
        self = .producer
      default:
        return nil
      }
    }
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
    self.group = try container.decodeIfPresent(String.self, forKey: .group)
    self.fullname = try container.decode(String.self, forKey: .fullname)

    if let roleStr = try container.decodeIfPresent(String.self, forKey: .role) {
      self.role = PersonRole(value: roleStr)
    } else {
      self.role = nil
    }


    let hrefUrl = try container.decodeIfPresent(String.self, forKey: .href) ?? ""
    self.href = hrefUrl.isEmpty ? nil : URL(string: hrefUrl)

    let imgUrl = try container.decodeIfPresent(String.self, forKey: .img) ?? ""
    self.img = imgUrl.isEmpty ? nil : URL(string: imgUrl)
  }
}
