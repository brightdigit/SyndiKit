#if swift(>=5.7)
  @preconcurrency import Foundation
#else
  import Foundation
#endif

internal struct UTF8EncodedURL: Codable, Sendable {
  internal let value: URL
  internal let string: String?

  internal init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    do {
      value = try container.decode(URL.self)
      string = nil
    } catch let error as DecodingError {
      let string = try container.decode(String.self)

      let encodedURLString = string.addingPercentEncoding(
        withAllowedCharacters: .urlQueryAllowed
      )
      let encodedURL = encodedURLString.flatMap(URL.init(string:))
      guard let encodedURL = encodedURL else {
        throw error
      }
      value = encodedURL
      self.string = string
    }
  }

  internal func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    if let string = string {
      try container.encode(string)
    } else {
      try container.encode(value)
    }
  }
}
