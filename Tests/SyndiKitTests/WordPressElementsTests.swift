import Testing

@testable import SyndiKit
@testable import SyndiKitTestSupport

@Suite("WordPress Elements Tests")
struct WordPressElementsTests {
  @Test("WordPress categories with different IDs are not equal")
  func categoryEquatable() {
    let c1 = WordPressElements.Category(
      termID: 1,
      nicename: .init(stringLiteral: "uncategorized"),
      parent: .init(stringLiteral: ""),
      name: "Uncategorized"
    )

    let c2 = WordPressElements.Category(
      termID: 2,
      nicename: .init(stringLiteral: "podcasting"),
      parent: .init(stringLiteral: ""),
      name: "Podcasting"
    )

    #expect(c1 != c2)
  }

  @Test("WordPress tags with different IDs are not equal")
  func tagEquatable() {
    let t1 = WordPressElements.Tag(
      termID: 1,
      slug: .init(stringLiteral: "uncategorized"),
      name: .init(stringLiteral: "uncategorized")
    )

    let t2 = WordPressElements.Tag(
      termID: 2,
      slug: .init(stringLiteral: "podcasting"),
      name: .init(stringLiteral: "Podcasting")
    )

    #expect(t1 != t2)
  }

  @Test("WordPress post meta with different keys are not equal")
  func postMetaEquatable() {
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
