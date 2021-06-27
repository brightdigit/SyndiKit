import DeveloperToolsSupport
import Foundation
import XMLCoder

struct iTunesDuration: Codable, LosslessStringConvertible {
  static func timeInterval(_ timeString: String) -> TimeInterval? {
    let timeStrings = timeString.components(separatedBy: ":").prefix(3)
    let doubles = timeStrings.compactMap(Double.init)
    guard doubles.count == timeStrings.count else {
      return nil
    }
    return doubles.reduce(0) { partialResult, value in
      partialResult * 60.0 + value
    }
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let stringValue = try container.decode(String.self)
    guard let value = Self.timeInterval(stringValue) else {
      throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Invalid time value", underlyingError: nil))
    }
    self.value = value
  }

  init?(_ description: String) {
    guard let value = Self.timeInterval(description) else {
      return nil
    }
    self.value = value
  }

  var description: String {
    return .init(value)
  }

  let value: TimeInterval
}

typealias iTunesEpisode = IntegerCodable
struct IntegerCodable: Codable, ExpressibleByIntegerLiteral {
  let value: Int

  init(integerLiteral value: Int) {
    self.value = value
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let stringValue = try container.decode(String.self).trimmingCharacters(in: .whitespacesAndNewlines)
    guard let value = Int(stringValue) else {
      throw DecodingError.typeMismatch(Int.self, .init(codingPath: decoder.codingPath, debugDescription: "Not Able to Parse String", underlyingError: nil))
    }
    self.value = value
  }
}

struct RSSItem: Codable {
  let title: String
  let link: URL
  let description: CData
  let guid: RSSGUID
  let pubDate: Date?
  let contentEncoded: CData?
  let category: [CData]
  let content: String?
  let itunesTitle: String?
  let itunesEpisode: iTunesEpisode?
  let itunesAuthor: String?
  let itunesSubtitle: String?
  let itunesSummary: String?
  let itunesExplicit: String?
  let itunesDuration: iTunesDuration?
  let itunesImage: iTunesImage?

  enum CodingKeys: String, CodingKey {
    case title
    case link
    case description
    case guid
    case pubDate
    case category
    case contentEncoded = "content:encoded"
    case content
    case itunesTitle = "itunes:title"
    case itunesEpisode = "itunes:episode"
    case itunesAuthor = "itunes:author"
    case itunesSubtitle = "itunes:subtitle"
    case itunesSummary = "itunes:summary"
    case itunesExplicit = "itunes:explicit"
    case itunesDuration = "itunes:duration"
    case itunesImage = "itunes:image"
  }
}

extension String {
  func trimAndNilIfEmpty() -> String? {
    let text = trimmingCharacters(in: .whitespacesAndNewlines)
    return text.isEmpty ? nil : text
  }
}

extension RSSItem: Entryable {
  var url: URL {
    return link
  }

  var contentHtml: String? {
    return contentEncoded?.value.trimAndNilIfEmpty() ?? content?.trimAndNilIfEmpty() ?? description.value.trimAndNilIfEmpty()
  }

  var summary: String? {
    return description.value
  }

  var datePublished: Date? {
    return pubDate
  }

  var author: RSSAuthor? {
    return nil
  }

  var id: RSSGUID {
    return guid
  }

  var published: Date? {
    return pubDate
  }

  var categories: [String] {
    return []
  }
}
