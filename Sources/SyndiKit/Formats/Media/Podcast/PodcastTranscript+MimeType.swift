import Foundation

extension PodcastTranscript {
  /// A private enum representing known MIME types for the transcript.
  private enum KnownMimeType: String, Codable {
    case plain = "text/plain"
    case html = "text/html"
    case srt = "text/srt"
    case vtt = "text/vtt"
    case json = "application/json"
    case subrip = "application/x-subrip"

    /// Initializes a ``KnownMimeType`` with a case-insensitive string.
    init?(caseInsensitive: String) {
      self.init(rawValue: caseInsensitive)
    }

    // swiftlint:disable cyclomatic_complexity
    /// Initializes a ``KnownMimeType`` with a ``MimeType``.
    init?(mimeType: MimeType) {
      switch mimeType {
      case .plain:
        self = .plain

      case .html:
        self = .html

      case .srt:
        self = .srt

      case .vtt:
        self = .vtt

      case .json:
        self = .json

      case .subrip:
        self = .subrip

      case .unknown:
        return nil
      }
    }

    // swiftlint:enable cyclomatic_complexity
  }

  /// An enum representing the MIME type of the transcript.
  public enum MimeType: Codable, Equatable, RawRepresentable {
    case plain
    case html
    case srt
    case vtt
    case json
    case subrip
    case unknown(String)

    /// The raw value of the MIME type.
    public var rawValue: String {
      if let knownMimeType = KnownMimeType(mimeType: self) {
        return knownMimeType.rawValue
      } else if case let .unknown(string) = self {
        return string
      } else {
        fatalError(
          // swiftlint:disable:next line_length
          "Type attribute of <podcast:transcript> with value: \(self) should either be a ``KnownMimeType``, or unknown!"
        )
      }
    }

    /// Initializes a ``MimeType`` with a raw value.
    public init?(rawValue: String) {
      self.init(caseInsensitive: rawValue)
    }

    /// Initializes a ``MimeType`` with a case-insensitive string.
    public init(caseInsensitive: String) {
      if let knownMimeType = KnownMimeType(caseInsensitive: caseInsensitive) {
        self = .init(knownMimeType: knownMimeType)
      } else {
        self = .unknown(caseInsensitive)
      }
    }

    /// Initializes a ``MimeType`` with a ``KnownMimeType``.
    private init(knownMimeType: KnownMimeType) {
      switch knownMimeType {
      case .plain:
        self = .plain

      case .html:
        self = .html

      case .srt:
        self = .srt

      case .vtt:
        self = .vtt

      case .json:
        self = .json

      case .subrip:
        self = .subrip
      }
    }
  }
}
