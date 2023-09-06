import XCTest
@testable import SyndiKit

final class WordPressElementsTests: XCTestCase {

  func testCategoryEquatable() {
    let c1 = WordPressElements.Category(
      termID: 1,
      niceName: .init(stringLiteral: "uncategorized"),
      parent: .init(stringLiteral: ""),
      name: "Uncategorized"
    )

    let c2 = WordPressElements.Category(
      termID: 2,
      niceName: .init(stringLiteral: "podcasting"),
      parent: .init(stringLiteral: ""),
      name: "Podcasting"
    )

    XCTAssertNotEqual(c1, c2)
  }

  func testTagEquatable() {
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

    XCTAssertNotEqual(t1, t2)
  }

  func testPostMetaEquatable() {
    let pm1 = WordPressElements.PostMeta(
      key: "_edit_last",
      value: "1"
    )

    let pm2 = WordPressElements.PostMeta(
      key: "_thumbnail_id",
      value: "57"
    )

    XCTAssertNotEqual(pm1, pm2)
  }

}
