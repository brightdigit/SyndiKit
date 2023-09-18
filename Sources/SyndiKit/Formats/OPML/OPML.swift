import Foundation

public struct OPMLSubscription: Equatable {
  let head: Head
  let body: Body

  enum CodingKeys: String, CodingKey {
    case head
    case body
  }
}
