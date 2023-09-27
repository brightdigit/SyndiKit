import Foundation

extension PodcastChapters {
  private enum KnownMimeType: String, Codable {
    case json = "application/json+chapters"

    init?(caseInsensitive: String) {
      self.init(rawValue: caseInsensitive)
    }

    init?(mimeType: MimeType) {
      switch mimeType {
      case .json: self = .json
      case .unknown: return nil
      }
    }
  }

  public enum MimeType: Codable, Equatable, RawRepresentable {
    case json
    case unknown(String)

    public var rawValue: String {
      if let knownMimeType = KnownMimeType(mimeType: self) {
        return knownMimeType.rawValue
      } else if case let .unknown(string) = self {
        return string
      } else {
        fatalError("Type attribute of <podcast:chapters> should either be `KnownMimeType`, or unknown!")
      }
    }

    public init?(rawValue: String) {
      if let knownMimeType = KnownMimeType(rawValue: rawValue) {
        self = .init(knownMimeType: knownMimeType)
      } else {
        self = .unknown(rawValue)
      }
    }

    public init(caseInsensitive: String) {
      if let knownMimeType = KnownMimeType(caseInsensitive: caseInsensitive) {
        self = .init(knownMimeType: knownMimeType)
      } else {
        self = .unknown(caseInsensitive)
      }
    }

    private init(knownMimeType: KnownMimeType) {
      switch knownMimeType {
      case .json: self = .json
      }
    }
  }
}
