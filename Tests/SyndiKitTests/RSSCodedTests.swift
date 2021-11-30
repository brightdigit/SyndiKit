@testable import SyndiKit
import XCTest
import XMLCoder

public final class SyndiKitTests: XCTestCase {
  static let itemCount = 20

  // swiftlint:disable implicitly_unwrapped_optional
  // static var xmlFeeds: [String: Result<Feedable, Error>]!
  // static var jsonFeeds: [String: Result<Feedable, Error>]!
  // swiftlint:enable implicitly_unwrapped_optional

//  override public class func setUp() {
//    // swiftlint:disable force_try
//    let xmlDataSet = try! FileManager.default.dataFromDirectory(at: Directories.XML)
//    let jsonDataSet = try! FileManager.default.dataFromDirectory(at: Directories.JSON)
//    // swiftlint:enable force_try
//
//    let decoder = SynDecoder()
//
//    let rssDataSet = xmlDataSet.flatResultMapValue { data in
//      try decoder.decode(data)
//    }
//
//    let jfDataSet = jsonDataSet.flatResultMapValue { data in
//      try decoder.decode(data)
//    }
//
//    xmlFeeds = Dictionary(uniqueKeysWithValues: rssDataSet)
//    jsonFeeds = Dictionary(uniqueKeysWithValues: jfDataSet)
//  }

  func testCategories() {
    guard let feeds = try? Content.xmlFeeds["advancedswift"]?.get() else {
      XCTFail("No Feeds")
      return
    }

    for item in feeds.children {
      XCTAssert(item.categories.contains(where: { $0.term == "iOS" }))
    }
  }

  fileprivate func assertAtomEntry(_ atomEntry: AtomEntry, _ entryChild: Entryable) {
    XCTAssertEqual(
      atomEntry.atomCategories.map { $0.term },
      entryChild.categories.map { $0.term }
    )
    XCTAssertEqual(atomEntry.links.first?.href, entryChild.url)
    XCTAssertNil(entryChild.summary)
  }

  fileprivate func assertFeed(_ feed: Feedable, atomFeed: AtomFeed) {
    XCTAssertEqual(feed.updated, atomFeed.pubDate ?? atomFeed.published)
    XCTAssertNil(feed.copyright)
    XCTAssertNil(feed.image)
    XCTAssertNil(feed.syndication)
    let items = zip(atomFeed.entries, feed.children)
    for (atomEntry, entryChild) in items {
      assertAtomEntry(atomEntry, entryChild)
    }
  }

  fileprivate func assertRSSItem(_ rssItem: RSSItem, child: Entryable) {
    XCTAssertEqual(
      rssItem.categoryTerms.map { $0.term },
      child.categories.map { $0.term }
    )
    XCTAssertEqual(rssItem.link, child.url)
    XCTAssertEqual(rssItem.description.value, child.summary)
    XCTAssertEqual(rssItem.guid, child.id)
    XCTAssertEqual(rssItem.pubDate, child.published)
    XCTAssert(
      rssItem.creators.first == child.authors.first?.name ||
        rssItem.itunesAuthor == child.authors.first?.name
    )
  }

  fileprivate func assertJSONItem(_ jsonItem: JSONItem, child: Entryable) {
    XCTAssertNil(jsonItem.creators.first)
    XCTAssertNil(jsonItem.media)
    XCTAssertEqual(jsonItem.categories.count, 0)

    XCTAssertEqual(jsonItem.datePublished, child.published)
    XCTAssertEqual(jsonItem.guid, child.id)
  }

  fileprivate func assertFeed(_ feed: Feedable, rssFeed: RSSFeed) {
    XCTAssertNil(feed.youtubeChannelID)
    XCTAssertEqual(feed.authors.first, rssFeed.channel.author)
    XCTAssertEqual(feed.updated, rssFeed.channel.lastBuildDate)
    XCTAssertEqual(feed.copyright, rssFeed.channel.copyright)
    XCTAssertEqual(feed.image, rssFeed.channel.image?.link)
    XCTAssertEqual(feed.syndication, rssFeed.channel.syndication)

    let items = zip(rssFeed.channel.items, feed.children)
    for (rssItem, entryChild) in items {
      assertRSSItem(rssItem, child: entryChild)
      // XCTAssertNil(entryChild.summary)
    }
  }

  fileprivate func assert(jsonFeed: JSONFeed, feed: Feedable) {
    XCTAssertNil(jsonFeed.updated)
    XCTAssertNil(jsonFeed.copyright)
    XCTAssertNil(jsonFeed.image)
    XCTAssertNil(jsonFeed.syndication)
    let items = zip(jsonFeed.items, feed.children)
    for (rssItem, entryChild) in items {
      assertJSONItem(rssItem, child: entryChild)
    }
  }

  func testEntryable() {
    let allFeeds = [
      Content.xmlFeeds.values, Content.jsonFeeds.values
    ].flatMap { $0 }

    for xmlResult in allFeeds {
      let feed: Feedable
      do {
        feed = try xmlResult.get()
      } catch {
        XCTAssertNil(error, "Failed to decode \(name)")
        continue
      }

      if let atomFeed = feed as? AtomFeed {
        assertFeed(feed, atomFeed: atomFeed)
      } else if let rssFeed = feed as? RSSFeed {
        assertFeed(feed, rssFeed: rssFeed)
      } else if let jsonFeed = feed as? JSONFeed {
        assert(jsonFeed: jsonFeed, feed: feed)
      } else {
        continue
      }
    }
  }

  fileprivate func assertFeedableEqual(
    _ json: Feedable,
    _ rss: Feedable,
    _ name: String
  ) {
    XCTAssertEqual(
      json.title.trimmingCharacters(in: .whitespacesAndNewlines),
      rss.title.trimmingCharacters(in: .whitespacesAndNewlines)
    )
    XCTAssertEqual(
      json.siteURL?.remainingPath.trimAndNilIfEmpty(),
      rss.siteURL?.remainingPath.trimAndNilIfEmpty()
    )
    if let summary = rss.summary {
      XCTAssertEqual(
        json.summary?.trimAndNilIfEmpty() ?? "",
        summary.trimmingCharacters(in: .whitespacesAndNewlines),
        "Description does not match for \(name)"
      )
    } else {
      XCTAssertEqual(json.summary?.count ?? 0, 0, "\(json.summary ?? "")")
    }
  }

  func testJSONXMLEquality() throws {
    for (name, xmlResult) in Content.xmlFeeds {
      guard let jsonResult = Content.jsonFeeds[name] else {
        continue
      }

      let json: Feedable
      let rss: Feedable

      do {
        json = try jsonResult.get()
        rss = try xmlResult.get()
      } catch {
        XCTAssertNil(error)
        continue
      }

      assertFeedableEqual(json, rss, name)

      let items = zip(json.children.sorted(by: {
        $0.title < $1.title
      }), rss.children.sorted(by: {
        $0.title < $1.title
      }))
      // var count = 0
      for (jsonItem, rssItem) in items {
        XCTAssertEqual(
          jsonItem.title.trimAndNilIfEmpty(),
          rssItem.title.trimAndNilIfEmpty()
        )
        // if count < SyndiKitTests.itemCount {
        XCTAssertEqual(
          jsonItem.contentHtml?.trimAndNilIfEmpty(),
          rssItem.contentHtml?.trimAndNilIfEmpty(),
          jsonItem.title
        )
        // count += 1
        // }
      }
    }
  }

  func testPodcastEpisodes() {
    let missingEpisodes = ["it-guy": [76, 56, 45]]
    let podcasts = [
      "empowerapps-show": 1 ... 94,
      "radar": 1 ... 219,
      "ideveloper": 276 ... 297,
      "it-guy": 1 ... 330
    ].mapValues {
      [Int]($0.map { $0 }.reversed())
    }

    for (name, episodeNumbers) in podcasts {
      guard let feed = try? Content.xmlFeeds[name]?.get() else {
        XCTFail("Missing Podcast \(name)")
        continue
      }

      guard let rss = feed as? RSSFeed else {
        XCTFail("Wrong Type \(name)")
        continue
      }

      var episodeNumbers = episodeNumbers
      let actualEps = rss.channel.items.compactMap { $0.itunesEpisode?.value }

      if let missingEpNumbers = missingEpisodes[name] {
        episodeNumbers.removeAll(where: missingEpNumbers.contains(_:))
      }

      if name == "it-guy" {
        let value = episodeNumbers.remove(at: 330 - 110)
        episodeNumbers.insert(value, at: 330 - 110 + 1)
      }

      let numbers = zip(episodeNumbers, actualEps)

      for (expected, actual) in numbers {
        XCTAssertEqual(expected, actual)
      }
    }
  }

  func testSyndication() {
    let updates = [
      "avanderlee": SyndicationUpdate(period: .hourly, frequency: 1),
      "donnywals": SyndicationUpdate(period: .hourly, frequency: 1),
      "mjtsai": SyndicationUpdate(period: .hourly, frequency: 1),
      "raywenderlich": SyndicationUpdate(period: .hourly, frequency: 1),
      "rhonabwy": SyndicationUpdate(period: .hourly, frequency: 1)
    ]

    for (name, update) in updates {
      guard let feed = try? Content.xmlFeeds[name]?.get() else {
        XCTFail("Missing Podcast: \(name), \(Content.xmlFeeds[name])")
        continue
      }

      guard let rss = feed as? RSSFeed else {
        XCTFail("Wrong Type")
        continue
      }

      XCTAssertEqual(rss.channel.syndication, update)
    }
  }

  // swiftlint:disable:next function_body_length
  func testYoutubeVideos() {
    for (name, xmlResult) in Content.xmlFeeds {
      guard name.hasSuffix("youtube") else {
        continue
      }

      let feed: Feedable
      do {
        feed = try xmlResult.get()
      } catch {
        XCTAssertNotNil(error)
        continue
      }

      guard let atom = feed as? AtomFeed else {
        XCTFail()
        continue
      }

      let items = zip(atom.entries, feed.children)

      for (entry, item) in items {
        let youtube = item.media.flatMap { media -> YouTubeID? in
          guard case let .video(video) = media else {
            return nil
          }
          guard case let .youtube(youtube) = video else {
            return nil
          }
          return youtube
        }
        guard let group = entry.mediaGroup else {
          XCTAssertNotNil(entry.mediaGroup)
          continue
        }
        XCTAssertNotNil(group.title)
        XCTAssertFalse(group.contents.isEmpty)
        XCTAssertFalse(group.thumbnails.isEmpty)
        XCTAssertFalse(group.descriptions.isEmpty)
        XCTAssertNotNil(youtube)
        XCTAssertEqual(entry.youtubeVideoID, youtube?.videoID)
      }
    }
  }

  func testDurations() {
    for (name, expecteds) in Self.durationSets {
      guard let feed = try? Content.xmlFeeds[name]?.get() else {
        XCTFail("Missing Podcast: \(name), \(Content.xmlFeeds[name])")
        continue
      }

      guard let rss = feed as? RSSFeed else {
        XCTFail("Wrong Type")
        continue
      }

      let actuals = rss.channel.items.compactMap { $0.itunesDuration?.value }
      let durations = feed.children.map {
        $0.media.flatMap { media -> TimeInterval? in
          if case let .podcast(episode) = media {
            return episode.duration
          } else {
            return nil
          }
        }
      }

      XCTAssertEqual(actuals, durations)
      let times = zip(actuals, expecteds)

      for (index, (actual, expected)) in times.enumerated() {
        XCTAssertEqual(actual, expected, "no equal at \(index)")
        XCTAssertEqual(iTunesDuration(String(actual))?.value, actual)
      }
    }
  }
}
