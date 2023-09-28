import Foundation

extension PodcastPerson {
  private enum KnownRole: String {
    case guest
    case host
    case editor
    case writer
    case designer
    case composer
    case producer

    init?(caseInsensitive: String) {
      self.init(rawValue: caseInsensitive.lowercased())
    }

    init?(role: Role) {
      switch role {
      case .guest: self = .guest
      case .host: self = .host
      case .editor: self = .editor
      case .writer: self = .writer
      case .designer: self = .designer
      case .composer: self = .composer
      case .producer: self = .producer
      case .unknown: return nil
      }
    }
  }

  public enum Role: Codable, Equatable, RawRepresentable {
    case guest
    case host
    case editor
    case writer
    case designer
    case composer
    case producer
    case unknown(String)

    public var rawValue: String {
      if let knownRole = KnownRole(role: self) {
        return knownRole.rawValue
      } else if case let .unknown(string) = self {
        return string
      } else {
        fatalError(
          // swiftlint:disable:next line_length
          "Role attribute of <podcast:person> with value: \(self) should either be a `KnownRole`, or unknown!"
        )
      }
    }

    public init?(rawValue: String) {
      self.init(caseInsensitive: rawValue)
    }

    public init(caseInsensitive: String) {
      if let knownRole = KnownRole(caseInsensitive: caseInsensitive) {
        self = .init(knownRole: knownRole)
      } else {
        self = .unknown(caseInsensitive)
      }
    }

    private init(knownRole: KnownRole) {
      switch knownRole {
      case .guest: self = .guest
      case .host: self = .host
      case .editor: self = .editor
      case .writer: self = .writer
      case .designer: self = .designer
      case .composer: self = .composer
      case .producer: self = .producer
      }
    }
  }
}
