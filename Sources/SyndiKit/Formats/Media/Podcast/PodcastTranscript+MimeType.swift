import Foundation

extension PodcastTranscript {
  private enum KnownMimeType: String, Codable {
    case plain = "text/plain"
    case html = "text/html"
    case srt = "text/srt"
    case vtt = "text/vtt"
    case json = "application/json"
    case subrip = "application/x-subrip"

    init?(caseInsensitive: String) {
      self.init(rawValue: caseInsensitive)
    }

    init?(mimeType: MimeType) {
      switch mimeType {
      case .plain:   self = .plain
      case .html:   self = .html
      case .srt:    self = .srt
      case .vtt:    self = .vtt
      case .json:   self = .json
      case .subrip: self = .subrip
      case .unknown: return nil
      }
    }
  }

  public enum MimeType: Codable, Equatable, RawRepresentable {
    case plain
    case html
    case srt
    case vtt
    case json
    case subrip
    case unknown(String)

    public var rawValue: String {
      if let knownMimeType = KnownMimeType(mimeType: self) {
        return knownMimeType.rawValue
      } else if case let .unknown(string) = self {
        return string
      } else {
        fatalError("This should never happen!")
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
      case .plain: self = .plain
      case .html: self = .html
      case .srt: self = .srt
      case .vtt: self = .vtt
      case .json: self = .json
      case .subrip: self = .subrip
      }
    }
  }
}
