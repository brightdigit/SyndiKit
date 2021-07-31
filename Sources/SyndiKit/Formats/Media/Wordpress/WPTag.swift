import Foundation
public extension WordPressElements {
  struct Tag: Codable {
    let termID: Int
    let slug: CData
    let name: CData

    enum CodingKeys: String, CodingKey {
      case termID = "wp:termId"
      case slug = "wp:tagSlug"
      case name = "wp:tagName"
    }
  }
}
