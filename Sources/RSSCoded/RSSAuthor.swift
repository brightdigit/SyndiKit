import Foundation

struct RSSAuthor: Codable, Equatable {
  let name: String
  let email: String?
  let uri: URL?
}
