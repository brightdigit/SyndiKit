/// A struct representing an Atom category.
/// A struct representing the owner of an iTunes account.
///
/// - Note: This struct conforms to the `Codable` protocol.
///
/// - Warning: Do not modify the `CodingKeys` enum.
///
/// - SeeAlso: `CodingKeys`
///
/// - Remark: The `email` property is optional.
///
/// - Important: The `name` property is required.
///
/// - Version: 1.0
/// - SeeAlso: `EntryCategory`
public struct iTunesOwner: Codable {
  /// The coding keys used to encode and decode the struct.
  internal enum CodingKeys: String, CodingKey {
    case name = "itunes:name"
    case email = "itunes:email"
  }

  /// The name of the iTunes owner.
  public let name: String

  /// The email address of the iTunes owner.
  public let email: String?
}
