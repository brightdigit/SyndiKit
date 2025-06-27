import Foundation

extension PodcastChapters {
  /// A private enum representing known MIME types for podcast chapters.
  private enum KnownMimeType: String, Codable, Sendable {
    case json = "application/json+chapters"

    /// Initializes a ``KnownMimeType`` from a case-insensitive string.
    init?(caseInsensitive: String) {
      self.init(rawValue: caseInsensitive)
    }

    /// Initializes a ``KnownMimeType`` from a ``MimeType``.
    init?(mimeType: MimeType) {
      switch mimeType {
      case .json:
        self = .json

      case .unknown:
        return nil
      }
    }
  }

  /// An enum representing the MIME type of podcast chapters.
  public enum MimeType: Codable, Equatable, RawRepresentable, Sendable {
    case json
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
          "Type attribute of <podcast:chapters> with value: \(self) should either be ``KnownMimeType``, or unknown!"
        )
      }
    }

    /// Initializes a ``MimeType`` from a raw value.
    public init?(rawValue: String) {
      self.init(caseInsensitive: rawValue)
    }

    /// Initializes a ``MimeType`` from a case-insensitive string.
    public init(caseInsensitive: String) {
      if let knownMimeType = KnownMimeType(caseInsensitive: caseInsensitive) {
        self = .init(knownMimeType: knownMimeType)
      } else {
        self = .unknown(caseInsensitive)
      }
    }

    /// Initializes a ``MimeType`` from a ``KnownMimeType``.
    private init(knownMimeType: KnownMimeType) {
      switch knownMimeType {
      case .json:
        self = .json
      }
    }
  }
}
