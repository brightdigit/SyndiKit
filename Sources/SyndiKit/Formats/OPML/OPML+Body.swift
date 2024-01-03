import Foundation

extension OPML {
  public struct Body: Codable, Equatable {
    internal enum CodingKeys: String, CodingKey {
      case outlines = "outline"
    }

    public let outlines: [Outline]
  }
}
