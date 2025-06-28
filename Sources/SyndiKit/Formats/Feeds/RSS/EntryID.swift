#if swift(>=5.7)
  @preconcurrency import Foundation
#else
  import Foundation
#endif

/// An identifier for an entry based on the RSS guid.
///
/// - Note: This enum conforms to
/// ``Codable``, ``Equatable``, and ``LosslessStringConvertible``.
public enum EntryID: Codable, Equatable, LosslessStringConvertible, Sendable {
  /// An identifier in URL format.
  case url(URL)

  /// An identifier in UUID format.
  case uuid(UUID)

  /// An identifier in string path format.
  ///
  /// This format is commonly used by YouTube's RSS feed, in the format of:
  /// ```
  /// yt:video:(YouTube Video ID)
  /// ```
  case path([String], separatedBy: String)

  /// An identifier in plain un-parsable string format.
  case string(String)

  /// A string representation of the entry identifier.
  public var description: String {
    let string: String
    switch self {
    case let .url(url):
      string = url.absoluteString

    case let .uuid(uuid):
      string = uuid.uuidString.lowercased()

    case let .path(components, separatedBy: separator):
      string = components.joined(separator: separator)

    case let .string(value):
      string = value
    }
    return string
  }

  /// Initializes an ``EntryID`` from a string.
  ///
  /// - Parameter description: The string representation of the entry identifier.
  /// - Note: This initializer will never return a ``nil`` instance.
  /// To avoid the ``Optional`` result, use `init(string:)` instead.
  public init?(_ description: String) {
    self.init(string: description)
  }

  /// Initializes an ``EntryID`` from a string.
  ///
  /// - Parameter string: The string representation of the entry identifier.
  /// - Note: Use this initializer instead of `init(_:)` to avoid the ``Optional`` result.
  public init(string: String) {
    if let url = URL(strict: string) {
      self = .url(url)
    } else if let uuid = UUID(uuidString: string) {
      self = .uuid(uuid)
    } else {
      let components = string.components(separatedBy: ":")
      if components.count > 1 {
        self = .path(components, separatedBy: ":")
      } else {
        let components = string.components(separatedBy: "/")
        if components.count > 1 {
          self = .path(components, separatedBy: "/")
        } else {
          self = .string(string)
        }
      }
    }
  }

  /// Initializes an ``EntryID`` from a decoder.
  ///
  /// - Parameter decoder: The decoder to read data from.
  /// - Throws: An error if the decoding process fails.
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let string = try container.decode(String.self)
    self.init(string: string)
  }

  /// Encodes the ``EntryID`` into the given encoder.
  ///
  /// - Parameter encoder: The encoder to write data to.
  /// - Throws: An error if the encoding process fails.
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(description)
  }
}
