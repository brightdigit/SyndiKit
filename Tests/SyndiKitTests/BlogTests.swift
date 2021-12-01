@testable import SyndiKit
import XCTest
import XMLCoder

public final class BlogTests: XCTestCase {
  func testBlogs() throws {
    let blogs = Content.blogs
    let sites = SiteCollectionDirectory(blogs: blogs)

    for languageContent in blogs {
      for category in languageContent.categories {
        let expectedCount = sites.sites(
          withLanguage: languageContent.language,
          withCategory: category.slug
        )
        .count
        XCTAssertEqual(
          category.sites.count,
          expectedCount,
          "mismatch count for \(languageContent.language):\(category.slug)"
        )
      }
    }
  }
}
