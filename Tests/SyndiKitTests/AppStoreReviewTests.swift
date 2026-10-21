//
//  AppStoreReviewTests.swift
//  SyndiKit
//

import Testing

@testable import SyndiKit
@testable import SyndiKitTestSupport

#if swift(<6.0)
  import Foundation
#else
  internal import Foundation
#endif

/// Decodes App Store customer-review pages (`Data/XML/app-store-reviews.xml`).
///
/// The fixture is a recorded page with reviewer names scrubbed, led by an
/// app-metadata entry taken from an archived page (Apple no longer sends one).
@Suite("App Store Review Tests")
internal struct AppStoreReviewTests {
  private static func entry(content: String) -> String {
    """
    <?xml version="1.0" encoding="utf-8"?>
    <feed xmlns="http://www.w3.org/2005/Atom">
      <title>Feed</title>
      <id>https://example.com/feed</id>
      <updated>2026-01-01T00:00:00+00:00</updated>
      <entry>
        <title>Entry</title>
        <id>https://example.com/entry</id>
        <updated>2026-01-01T00:00:00+00:00</updated>
        \(content)
      </entry>
    </feed>
    """
  }

  private static func decodeEntry(_ xml: String) throws -> AtomEntry {
    let feed = try SynDecoder().decode(Data(xml.utf8))
    let atomFeed = try #require(feed as? AtomFeed)
    return try #require(atomFeed.entries.first)
  }

  #if !os(WASI)
    private static func reviewPage() throws -> AtomFeed {
      let feed = try #require(try Content.xmlFeeds["app-store-reviews"]?.get())
      return try #require(feed as? AtomFeed)
    }

    @Test("Every review entry has a rating and a version")
    internal func reviewEntriesHaveRatings() throws {
      let reviews = try Self.reviewPage().entries.dropFirst()
      #expect(reviews.count == 5)
      for entry in reviews {
        let review = try #require(iTunesReviewProperties(entry: entry))
        #expect((1...5).contains(review.rating))
        #expect(review.version?.isEmpty == false)
        #expect(review.voteSum != nil)
        #expect(review.voteCount != nil)
      }
    }

    @Test("The app-metadata entry decodes without review properties")
    internal func metadataEntryHasNoReviewProperties() throws {
      let metadata = try #require(try Self.reviewPage().entries.first)
      #expect(metadata.itunesRating == nil)
      #expect(metadata.itunesVersion == nil)
      #expect(iTunesReviewProperties(entry: metadata) == nil)
    }

    @Test("A page without reviews decodes, skipping its empty links")
    internal func emptyPageDecodes() throws {
      let feed = try #require(try Content.xmlFeeds["app-store-reviews-empty"]?.get())
      let atomFeed = try #require(feed as? AtomFeed)
      #expect(atomFeed.entries.isEmpty)
      #expect(atomFeed.links.map(\.rel) == ["alternate", "self"])
    }

    @Test("The text body comes from content type=\"text\"")
    internal func reviewContentPrefersText() throws {
      for entry in try Self.reviewPage().entries.dropFirst() {
        #expect(entry.contents.count == 2)
        let text = try #require(entry.contents.first { $0.type == "text" })
        #expect(entry.content == text.value)
        #expect(entry.contentHtml?.hasPrefix("<table") == true)
      }
    }
  #endif

  @Test("Text is preferred even when html comes first")
  internal func textPreferredRegardlessOfOrder() throws {
    let entry = try Self.decodeEntry(
      Self.entry(
        content: """
          <content type="html">&lt;b&gt;HTML&lt;/b&gt;</content>
          <content type="text">TEXT</content>
          """
      )
    )
    #expect(entry.content == "TEXT")
    #expect(entry.contentHtml == "<b>HTML</b>")
  }

  @Test("A single content element is both content and contentHtml")
  internal func singleContentUnchanged() throws {
    let entry = try Self.decodeEntry(
      Self.entry(content: #"<content type="html">&lt;p&gt;Hi&lt;/p&gt;</content>"#)
    )
    #expect(entry.contents.count == 1)
    #expect(entry.content == "<p>Hi</p>")
    #expect(entry.contentHtml == "<p>Hi</p>")
  }

  @Test("An entry without content has none")
  internal func noContent() throws {
    let entry = try Self.decodeEntry(Self.entry(content: ""))
    #expect(entry.contents.isEmpty)
    #expect(entry.content == nil)
  }
}
