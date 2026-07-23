import Testing

@testable import SyndiKit
@testable import SyndiKitTestSupport

@Suite("WordPress Elements Tests")
internal struct WordPressElementsTests {
  @Test("WordPress categories with different IDs are not equal")
  internal func categoryEquatable() {
    let category1 = WordPressElements.Category(
      termID: 1,
      nicename: .init(stringLiteral: "uncategorized"),
      parent: .init(stringLiteral: ""),
      name: "Uncategorized"
    )

    let category2 = WordPressElements.Category(
      termID: 2,
      nicename: .init(stringLiteral: "podcasting"),
      parent: .init(stringLiteral: ""),
      name: "Podcasting"
    )

    #expect(category1 != category2)
  }

  @Test("WordPress tags with different IDs are not equal")
  internal func tagEquatable() {
    let tag1 = WordPressElements.Tag(
      termID: 1,
      slug: .init(stringLiteral: "uncategorized"),
      name: .init(stringLiteral: "uncategorized")
    )

    let tag2 = WordPressElements.Tag(
      termID: 2,
      slug: .init(stringLiteral: "podcasting"),
      name: .init(stringLiteral: "Podcasting")
    )

    #expect(tag1 != tag2)
  }

  @Test("WordPress post meta with different keys are not equal")
  internal func postMetaEquatable() {
    let pm1 = WordPressElements.PostMeta(
      key: "_edit_last",
      value: "1"
    )

    let pm2 = WordPressElements.PostMeta(
      key: "_thumbnail_id",
      value: "57"
    )

    #expect(pm1 != pm2)
  }
}
