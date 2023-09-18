import Foundation

public struct OPML: Equatable {
  let head: Head
  let body: Body

  enum CodingKeys: String, CodingKey {
    case head
    case body
  }
}
