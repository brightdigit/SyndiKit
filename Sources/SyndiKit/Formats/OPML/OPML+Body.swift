import Foundation

extension OPML {
  public struct Body: Codable, Equatable, Sendable {
    // swiftlint:disable:next nesting
    internal enum CodingKeys: String, CodingKey {
      case outlines = "outline"
    }

    public let outlines: [Outline]
  }
}
