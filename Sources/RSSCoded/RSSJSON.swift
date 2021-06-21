import Foundation

struct RSSJSON: Codable {
  let version: URL
  let title: String
  let homePageUrl: URL
  let description: String?
  let author: Author?

  struct Author: Codable {
    let name: String
  }
}
