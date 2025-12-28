import Testing

@testable import SyndiKit
@testable import SyndiKitTestSupport

@Suite("RSS Item Category Tests")
struct RSSItemCategoryTests {
  @Test("Two equal categories are equal")
  func twoEqualCategories() {
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

    #expect(c1 == c2)
  }

  @Test("Two unequal categories are not equal")
  func twoUnequalCategories() {
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

    #expect(c1 != c2)
  }
}
