// swiftlint:disable:next type_name
struct iTunesOwner: Codable {
  let name: String
  let email: String

  enum CodingKeys: String, CodingKey {
    case name = "itunes:name"
    case email = "itunes:email"
  }
}
