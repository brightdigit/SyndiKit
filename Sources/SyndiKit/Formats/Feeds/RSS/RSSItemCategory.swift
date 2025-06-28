/// A struct representing an Atom category.
/// A struct representing a category for an RSS item.
///
/// This struct conforms to the ``Codable`` and ``EntryCategory`` protocols.
///
/// - Note: The ``CodingKeys`` enum is used to specify the coding keys for the struct.
///
/// - SeeAlso: ``EntryCategory``
///
/// - Remark: This struct is ``public`` to allow access from other modules.
///
/// - Warning: Do not modify the ``CodingKeys`` enum.
///
/// - Version: 1.0
/// - SeeAlso: ``EntryCategory``
public struct RSSItemCategory: Codable, EntryCategory, Sendable {
  /// The coding keys for the struct.
  internal enum CodingKeys: String, CodingKey {
    case value = "#CDATA"
    case domain
    case nicename
  }

  /// The term of the category.
  public var term: String {
    value
  }

  /// The value of the category.
  public let value: String

  /// The domain of the category.
  public let domain: String?

  /// The nicename of the category.
  public let nicename: String?

  /// A struct representing an Atom category.
  ///   Initializes a new instance of ``RSSItemCategory``.
  ///
  ///   - Parameters:
  ///     - value: The value of the category.
  ///     - domain: The domain of the category. Default value is ``nil``.
  ///     - nicename: The nicename of the category. Default value is ``nil``.
  ///
  ///   - Returns: A new instance of ``RSSItemCategory``.
  /// - SeeAlso: ``EntryCategory``
  public init(value: String, domain: String? = nil, nicename: String? = nil) {
    self.value = value
    self.domain = domain
    self.nicename = nicename
  }

  /// A struct representing an Atom category.
  ///   Initializes a new instance of ``RSSItemCategory`` from a decoder.
  ///
  ///   - Parameter decoder: The decoder to use for decoding.
  ///
  ///   - Throws: An error if the decoding fails.
  ///
  ///   - Returns: A new instance of ``RSSItemCategory``.
  /// - SeeAlso: ``EntryCategory``
  public init(from decoder: Decoder) throws {
    let value: String
    let container: KeyedDecodingContainer<CodingKeys>?
    do {
      let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
      value = try keyedContainer.decode(String.self, forKey: .value)
      container = keyedContainer
    } catch {
      let singleValueContainer = try decoder.singleValueContainer()
      value = try singleValueContainer.decode(String.self)
      container = nil
    }
    self.value = value
    domain = try container?.decodeIfPresent(String.self, forKey: .domain)
    nicename = try container?.decodeIfPresent(String.self, forKey: .nicename)
  }
}

extension RSSItemCategory: Equatable {
  /// A struct representing an Atom category.
  ///   Checks if two ``RSSItemCategory`` instances are equal.
  ///
  ///   - Parameters:
  ///     - lhs: The left-hand side ``RSSItemCategory`` instance.
  ///     - rhs: The right-hand side ``RSSItemCategory`` instance.
  ///
  ///   - Returns: ``true`` if the instances are equal, otherwise ``false``.
  /// - SeeAlso: ``EntryCategory``
  public static func == (lhs: RSSItemCategory, rhs: RSSItemCategory) -> Bool {
    lhs.value == rhs.value
      && lhs.domain == rhs.domain
      && lhs.nicename == rhs.nicename
  }
}
