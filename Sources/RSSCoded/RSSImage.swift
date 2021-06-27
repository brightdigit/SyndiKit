import Foundation

struct RSSImage: Codable {
  let url: URL
  let title: String
  let link: URL
  let width: Int?
  let height: Int?
}
