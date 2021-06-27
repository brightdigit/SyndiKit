import Foundation

enum SyndicationUpdatePeriod: String, Codable {
  case hourly, daily, weekly, monthly, yearly

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let stringValue = try container.decode(String.self).trimmingCharacters(in: .whitespacesAndNewlines)
    guard let value = Self(rawValue: stringValue) else {
      throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Invalid Enum", underlyingError: nil))
    }
    self = value
  }
}

typealias SyndicationUpdateFrequency = IntegerCodable

struct SyndicationUpdate: Codable, Equatable {
  let period: SyndicationUpdatePeriod
  let frequency: Int
  let base: Date?

  init?(period: SyndicationUpdatePeriod? = nil, frequency: Int? = nil, base: Date? = nil) {
    guard period != nil || frequency != nil else {
      return nil
    }
    self.period = period ?? .daily
    self.frequency = frequency ?? 1
    self.base = base
  }
}

struct RSSChannel: Codable {
  let title: String
  let link: URL
  let description: String?
  let lastBuildDate: Date?
  let syUpdatePeriod: SyndicationUpdatePeriod?
  let syUpdateFrequency: SyndicationUpdateFrequency?
  let item: [RSSItem]
  let itunesAuthor: String?
  let itunesImage: String?
  let itunesOwner: iTunesOwner?
  let copyright: String?
  let image: RSSImage?
  enum CodingKeys: String, CodingKey {
    case title
    case link
    case description
    case lastBuildDate
    case syUpdatePeriod = "sy:updatePeriod"
    case syUpdateFrequency = "sy:updateFrequency"
    case item
    case itunesAuthor = "itunes:author"
    case itunesImage = "itunes:image"
    case itunesOwner = "itunes:owner"
    case copyright
    case image
  }
}

extension RSSChannel {
  var syndication: SyndicationUpdate? {
    return SyndicationUpdate(period: syUpdatePeriod, frequency: syUpdateFrequency?.value)
  }
}
