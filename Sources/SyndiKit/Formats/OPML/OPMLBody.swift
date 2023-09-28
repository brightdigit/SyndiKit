import Foundation

public extension OPML {
  struct Body: Codable, Equatable {
    public let outlines: [Outline]

    enum CodingKeys: String, CodingKey {
      case outlines = "outline"
    }
  }
}
