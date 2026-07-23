import Testing

@testable import SyndiKit
@testable import SyndiKitTestSupport

@Suite("RSS Item Category Tests")
internal struct RSSItemCategoryTests {
  @Test("Two equal categories are equal")
  internal func twoEqualCategories() {
    let category1 = RSSItemCategory(
      value: "Top Menu",
      domain: "nav_menu",
      nicename: "top-menu"
    )

    let category2 = RSSItemCategory(
      value: "Top Menu",
      domain: "nav_menu",
      nicename: "top-menu"
    )

    #expect(category1 == category2)
  }

  @Test("Two unequal categories are not equal")
  internal func twoUnequalCategories() {
    let category1 = RSSItemCategory(
      value: "Uncategorized",
      domain: "category",
      nicename: "uncategorized"
    )

    let category2 = RSSItemCategory(
      value: "Top Menu",
      domain: "nav_menu",
      nicename: "top-menu"
    )

    #expect(category1 != category2)
  }
}
