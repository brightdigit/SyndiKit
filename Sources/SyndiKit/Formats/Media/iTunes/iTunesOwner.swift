// swiftlint:disable:next type_name
public struct iTunesOwner: Codable {
  internal enum CodingKeys: String, CodingKey {
    case name = "itunes:name"
    case email = "itunes:email"
  }

  public let name: String
  public let email: String?
}
