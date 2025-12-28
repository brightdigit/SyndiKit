import Testing
import XMLCoder

@testable import SyndiKit
@testable import SyndiKitTestSupport

@Suite("Blog Tests")
internal struct BlogTests {
  @Test("Site category count validation")
  func blogs() throws {
    let blogs = Content.blogs
    let sites = SiteCollectionDirectory(blogs: blogs)

    for languageContent in blogs {
      for category in languageContent.categories {
        let expectedCount = sites.sites(
          withLanguage: languageContent.language,
          withCategory: category.slug
        )
        .count
        #expect(
          category.sites.count == expectedCount,
          "mismatch count for \(languageContent.language):\(category.slug)"
        )
      }
    }
  }
}
