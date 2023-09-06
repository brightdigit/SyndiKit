import XCTest
@testable import SyndiKit

final class RSSItemCategoryTests: XCTestCase {

  func testTwoEqualCategories() {
    let c1 = RSSItemCategory(
      value: "Top Menu",
      domain: "nav_menu",
      nicename: "top-menu"
    )

    let c2 = RSSItemCategory(
      value: "Top Menu",
      domain: "nav_menu",
      nicename: "top-menu"
    )

    XCTAssertEqual(c1, c2)
  }

  func testTwoUnequalCategories() {
    let c1 = RSSItemCategory(
      value: "Uncategorized",
      domain: "category",
      nicename: "uncategorized"
    )

    let c2 = RSSItemCategory(
      value: "Top Menu",
      domain: "nav_menu",
      nicename: "top-menu"
    )

    XCTAssertNotEqual(c1, c2)
  }
}
