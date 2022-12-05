// swiftlint:disable:next type_name
public struct iTunesOwner: Codable {
  public let name: String
  public let email: String?

  enum CodingKeys: String, CodingKey {
    case name = "itunes:name"
    case email = "itunes:email"
  }
}
