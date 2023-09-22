@testable import SyndiKit
import XCTest
import XMLCoder

public final class SyndiKitTests: XCTestCase {
  static let itemCount = 20

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
    XCTAssertEqual(rssItem.description?.value, child.summary)
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
      Content.xmlFeeds, Content.jsonFeeds
    ].flatMap { $0 }

    for (name, xmlResult) in allFeeds {
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
        XCTAssertNil(error, "failed decoding \(name)")
        continue
      }

      assertFeedableEqual(json, rss, name)

      let items = zip(json.children.sorted(by: {
        $0.title < $1.title
      }), rss.children.sorted(by: {
        $0.title < $1.title
      }))

      for (jsonItem, rssItem) in items {
        XCTAssertEqual(
          jsonItem.title.trimAndNilIfEmpty(),
          rssItem.title.trimAndNilIfEmpty()
        )

        XCTAssertEqual(
          jsonItem.contentHtml?.trimAndNilIfEmpty(),
          rssItem.contentHtml?.trimAndNilIfEmpty(),
          jsonItem.title
        )
      }
    }
  }

  func testChannelPodcastElements() {
    guard let feed = try? Content.xmlFeeds["empowerapps-show-cdata_summary"]?.get() else {
      XCTFail("Missing Podcast \(name)")
      return
    }

    guard let rss = feed as? RSSFeed else {
      XCTFail("Wrong Type \(name)")
      return
    }

    XCTAssertEqual(rss.channel.podcastLocked?.owner, "leogdion@brightdigit.com")
    XCTAssertEqual(rss.channel.podcastLocked?.isLocked, false)

    XCTAssertEqual(rss.channel.podcastFundings.count, 1)

    let funding = rss.channel.podcastFundings[0]
    XCTAssertEqual(funding.description, "Support this podcast on Patreon")
    XCTAssertEqual(funding.url, URL(strict: "https://www.patreon.com/empowerappsshow"))

    XCTAssertEqual(rss.channel.podcastPeople.count, 1)

    let person = rss.channel.podcastPeople[0]
    XCTAssertEqual(person.fullname, "Leo Dion")
    XCTAssertEqual(person.role, .host)
    XCTAssertEqual(person.href, URL(strict: "https://brightdigit.com"))
    XCTAssertEqual(person.img, URL(strict: "https://images.transistor.fm/file/transistor/images/person/401f05b8-f63f-4b96-803f-c7ac9233b459/1664979700-image.jpg"))
  }

  func testPodcastEpisodes() {
    let missingEpisodes = ["it-guy": [76, 56, 45]]
    let podcasts = [
      "empowerapps-show": 1 ... 94,
      "empowerapps-show-cdata_summary": 1 ... 151,
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

  func testEpisodeStringSummary() {
    guard let feed = try? Content.xmlFeeds["empowerapps-show-cdata_summary"]?.get() else {
      XCTFail("Missing Podcast \(name)")
      return
    }

    guard let rss = feed as? RSSFeed else {
      XCTFail("Wrong Type \(name)")
      return
    }

    let items = rss.channel.items

    let title = "Platforms State of Union 2023 with Peter Witham"

    guard let episode = items.first(where: { $0.title == title }) else {
      XCTFail("Missing episode \(title)")
      return
    }

    XCTAssertNotNil(episode.summary)
  }

  func testEpisodesWithNoPersons() {
    guard let feed = try? Content.xmlFeeds["empowerapps-show-cdata_summary"]?.get() else {
      XCTFail("Missing Podcast \(name)")
      return
    }

    guard let rss = feed as? RSSFeed else {
      XCTFail("Wrong Type \(name)")
      return
    }

    let itemTitle = "My Taylor Deep Dish Swift Heroes World Tour"

    guard let item = rss.channel.items.first(where: { $0.title == itemTitle } ) else {
      XCTFail("Expected to find episode of title: \(itemTitle)")
      return
    }

    XCTAssertNil(item.podcastPeople)
  }

  func testEpisodesWithHostAndGuestPersons() {
    guard let feed = try? Content.xmlFeeds["empowerapps-show-cdata_summary"]?.get() else {
      XCTFail("Missing Podcast \(name)")
      return
    }

    guard let rss = feed as? RSSFeed else {
      XCTFail("Wrong Type \(name)")
      return
    }

    let item1Title = "WWDC Spectacular (Part 2) with Peter Witham"
    let item2Title = "How to WWDC with Peter Witham"

    let items = rss.channel.items.filter { $0.title == item1Title || $0.title == item2Title }

    XCTAssertFalse(items.isEmpty)

    for item in items {
      let host = item.podcastPeople?.first(where: { $0.role == .host })

      XCTAssertNotNil(host)
      XCTAssertEqual(host?.fullname, "Leo Dion")
      XCTAssertEqual(host?.href, URL(strict: "https://brightdigit.com"))
      XCTAssertEqual(
        host?.img,
        URL(string: "https://images.transistor.fm/file/transistor/images/person/401f05b8-f63f-4b96-803f-c7ac9233b459/1664979700-image.jpg")
      )

      // Both podcasts have the same guest
      let guest = item.podcastPeople?.first(where: { $0.role == .guest })

      XCTAssertNotNil(guest)
      XCTAssertEqual(guest?.fullname, "CompileSwift")
      XCTAssertEqual(guest?.href, URL(strict: "https://compileswift.com"))
      XCTAssertEqual(
        guest?.img,
        URL(string: "https://images.transistor.fm/file/transistor/images/person/e36ebf22-69fa-4e4f-a79b-1348c4d39267/1668262451-image.jpg")
      )
    }
  }

  func testEpisodeCDataSummary() {
    guard let feed = try? Content.xmlFeeds["empowerapps-show-cdata_summary"]?.get() else {
      XCTFail("Missing Podcast \(name)")
      return
    }

    guard let rss = feed as? RSSFeed else {
      XCTFail("Wrong Type \(name)")
      return
    }

    let items = rss.channel.items

    let title = "Dynamic Island with Steve Lipton"

    guard let episode = items.first(where: { $0.title == title }) else {
      XCTFail("Missing episode \(title)")
      return
    }

    XCTAssertNotNil(episode.summary)
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
        XCTFail("Missing Podcast: \(name), \(Content.xmlFeeds[name].debugDescription)")
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
        XCTFail("Missing Podcast: \(name), \(Content.xmlFeeds[name].debugDescription)")
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
