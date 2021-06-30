import SyndiKit
import XCTest
import XMLCoder

public final class BlogTests: XCTestCase {
  func testBlogs() throws {
    let sourceURL = Directories.data.appendingPathComponent("blogs.json")
    let data = try Data(contentsOf: sourceURL)
    let decoder = JSONDecoder()

    let blogs = try decoder.decode(BlogArray.self, from: data)
    let sites = BlogCollection(blogs: blogs)

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
