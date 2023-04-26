import Foundation

public struct UTF8EncodedURL : Codable {
  let value : URL
  let string : String?
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    do {
      value = try container.decode(URL.self)
      string = nil
    } catch let error as DecodingError {
      let string = try container.decode(String.self)
       
      let encodedURLString = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
      let encodedURL = encodedURLString.flatMap(URL.init(string:))
      guard let encodedURL = encodedURL else {
        throw error
      }
      value = encodedURL
      self.string = string
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    if let string = string {
      try container.encode(string)
    } else {
      try container.encode(value)
    }
  }
}

public struct Enclosure: Codable {
  public let url: URL
  public let type: String
  public let length: Int?

  enum CodingKeys: String, CodingKey {
    case url
    case type
    case length
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Self.CodingKeys)
    self.url = try container.decode(UTF8EncodedURL.self, forKey: .url).value
    type = try container.decode(String.self, forKey: .type)
    if container.contains(.length) {
      do {
        length = try container.decode(Int.self, forKey: .length)
      } catch {
        let lengthString = try container.decode(String.self, forKey: .length)
        if lengthString.isEmpty {
          length = nil
        } else if let length = Int(lengthString) {
          self.length = length
        } else {
          throw error
        }
      }
    } else {
      length = nil
    }
  }
}
