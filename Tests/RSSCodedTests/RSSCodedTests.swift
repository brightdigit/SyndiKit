import RSSCoded
import XCTest
import XMLCoder

final class RSSCodedTests: XCTestCase {
  static let itemCount = 20
  static var xmlFeeds: [String: Result<Feedable, Error>]!
  static var jsonFeeds: [String: Result<Feedable, Error>]!

  override class func setUp() {
    // swiftlint:disable force_try
    let xmlDataSet = try! FileManager.default.dataFromDirectory(at: Directories.XML)
    let jsonDataSet = try! FileManager.default.dataFromDirectory(at: Directories.JSON)
    // swiftlint:enable force_try

    let decoder = RSSDecoder()

    let rssDataSet = xmlDataSet.flatResultMapValue { data in
      try decoder.decode(data)
    }

    let jfDataSet = jsonDataSet.flatResultMapValue { data in
      try decoder.decode(data)
    }

    xmlFeeds = Dictionary(uniqueKeysWithValues: rssDataSet)
    jsonFeeds = Dictionary(uniqueKeysWithValues: jfDataSet)
  }

  func testCategories() {
    guard let feeds = try? RSSCodedTests.xmlFeeds["advancedswift"]?.get() else {
      XCTFail()
      return
    }

    for item in feeds.children {
      XCTAssert(item.categories.contains(where: { $0.term == "iOS" }))
    }
  }

  func testEntryable() {
    for (name, xmlResult) in RSSCodedTests.xmlFeeds {
      let feed: Feedable
      do {
        feed = try xmlResult.get()
      } catch {
        XCTAssertNil(error, "Failed to decode \(name)")
        continue
      }

      if let atomFeed = feed as? AtomFeed {
        XCTAssertEqual(feed.updated, atomFeed.pubDate ?? atomFeed.published)
        XCTAssertNil(feed.copyright)
        XCTAssertNil(feed.image)
        XCTAssertNil(feed.syndication)
        let items = zip(atomFeed.entries, feed.children)
        for (atomEntry, entryChild) in items {
          XCTAssertEqual(atomEntry.atomCategories.map { $0.term }, entryChild.categories.map { $0.term })
          XCTAssertEqual(atomEntry.link.href, entryChild.url)
          XCTAssertNil(entryChild.summary)
        }
      } else if let rssFeed = feed as? RSSFeed {
        XCTAssertEqual(feed.updated, rssFeed.channel.lastBuildDate)
        XCTAssertEqual(feed.copyright, rssFeed.channel.copyright)
        XCTAssertEqual(feed.image, rssFeed.channel.image?.link)
        XCTAssertEqual(feed.syndication, rssFeed.channel.syndication)

        let items = zip(rssFeed.channel.items, feed.children)
        for (rssItem, entryChild) in items {
          XCTAssertEqual(rssItem.categoryTerms.map { $0.term }, entryChild.categories.map { $0.term })
          XCTAssertEqual(rssItem.link, entryChild.url)
          XCTAssertEqual(rssItem.description.value, entryChild.summary)
          XCTAssertEqual(rssItem.guid, entryChild.id)
          XCTAssertEqual(rssItem.pubDate, entryChild.published)
          // XCTAssertNil(entryChild.summary)
        }
      } else {
        guard feed is JSONFeed else {
          XCTFail()
          continue
        }
      }
    }
  }

  func testJSONXMLEquality() throws {
    for (name, xmlResult) in RSSCodedTests.xmlFeeds {
      guard let jsonResult = RSSCodedTests.jsonFeeds[name] else {
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

      XCTAssertEqual(json.title.trimmingCharacters(in: .whitespacesAndNewlines), rss.title.trimmingCharacters(in: .whitespacesAndNewlines))
      XCTAssertEqual(json.siteURL?.remainingPath.trimAndNilIfEmpty(), rss.siteURL?.remainingPath.trimAndNilIfEmpty())
      if let summary = rss.summary {
        XCTAssertEqual(json.summary?.trimAndNilIfEmpty() ?? "", summary.trimmingCharacters(in: .whitespacesAndNewlines), "Description does not match for \(name)")

      } else {
        XCTAssertEqual(json.summary?.count ?? 0, 0, "\(json.summary)")
      }

      let items = zip(json.children.sorted(by: {
        $0.title < $1.title
      }), rss.children.sorted(by: {
        $0.title < $1.title
      }))
      var count = 0
      for (jsonItem, rssItem) in items {
        XCTAssertEqual(jsonItem.title.trimAndNilIfEmpty(), rssItem.title.trimAndNilIfEmpty())
        if count < RSSCodedTests.itemCount {
          XCTAssertEqual(jsonItem.contentHtml?.trimAndNilIfEmpty(), rssItem.contentHtml?.trimAndNilIfEmpty(), jsonItem.title)
          count += 1
        }
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
      guard let feed = try? Self.xmlFeeds[name]?.get() else {
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
      guard let feed = try? Self.xmlFeeds[name]?.get() else {
        XCTFail("Missing Podcast: \(name), \(Self.xmlFeeds[name])")
        continue
      }

      guard let rss = feed as? RSSFeed else {
        XCTFail("Wrong Type")
        continue
      }

      XCTAssertEqual(rss.channel.syndication, update)
    }
  }

  func testYoutubeVideos() {
    for (name, xmlResult) in RSSCodedTests.xmlFeeds {
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
        let youtube = item.media.flatMap { media -> YouTubeIDProtocol? in
          guard case let .video(video) = media else {
            return nil
          }
          guard case let .youtube(youtube) = video else {
            return nil
          }
          return youtube
        }
        XCTAssertNotNil(youtube)
        XCTAssertEqual(entry.youtubeVideoID, youtube?.videoID)
      }
    }
  }

  func testDurations() {
    let durationSets: [String: [TimeInterval]] = [
      "empowerapps-show": [
        2746,
        3500,
        5145,
        2589,
        1796,
        2401,
        2052,
        2323,
        2631,
        1971,
        1877,
        2080,
        2240,
        2656,
        1843,
        2237,
        3421,
        2788,
        3041,
        2138,
        1460,
        2768,
        2372,
        2309,
        1804,
        1916,
        3022,
        2541,
        2729,
        3386,
        2281,
        2962,
        3307,
        2648,
        2667,
        2783,
        2693,
        2290,
        1741,
        3341,
        1607,
        889,
        2535,
        1762,
        2799,
        2956,
        2976,
        5011,
        2140,
        2535,
        2497,
        3405,
        1210,
        2405,
        2991,
        3540,
        1868,
        2248,
        4199,
        1289,
        3155,
        2787,
        2222,
        2555,
        479,
        2607,
        1985,
        2565,
        2761,
        2026,
        2452,
        3163,
        1127,
        3195,
        3890,
        1358,
        2489,
        2465,
        2083,
        2824,
        2137,
        2452,
        2242,
        1622,
        1081,
        1979,
        2080,
        1225,
        2204,
        1703,
        2495,
        922,
        1433,
        1776
      ],
      "raywenderlich": [
        96.0,
        2893.0,
        2735.0,
        2653.0,
        2497.0,
        2592.0,
        2542.0,
        2577.0,
        2455.0,
        1935.0,
        2689.0,
        2819.0,
        2871.0,
        653.0,
        2454.0,
        2696.0,
        2849.0,
        2778.0,
        2742.0,
        2705.0,
        2750.0,
        2734.0,
        2684.0,
        2676.0,
        2698.0,
        2696.0,
        2698.0,
        600.0,
        2549.0,
        2398.0,
        2344.0,
        2401.0,
        2419.0,
        2391.0,
        3576.0,
        2402.0,
        2422.0,
        2385.0,
        2374.0,
        2378.0,
        2494.0,
        698.0,
        2798.0,
        2456.0,
        2402.0,
        2417.0,
        2407.0,
        3597.0,
        2481.0,
        2481.0,
        3725.0,
        2395.0,
        2380.0,
        2398.0,
        316.0,
        1949.0,
        2572.0,
        2472.0,
        2412.0,
        2415.0,
        2378.0,
        2361.0,
        2423.0,
        2389.0,
        917.0,
        2578.0,
        2622.0,
        2585.0,
        2462.0,
        1087.0,
        2697.0,
        2584.0,
        3005.0,
        2431.0,
        2547.0,
        2547.0,
        2510.0,
        2471.0,
        2476.0,
        2424.0,
        2516.0,
        2408.0,
        2281.0,
        2502.0,
        2483.0,
        2521.0,
        2436.0,
        2456.0,
        2364.0,
        2550.0,
        2411.0,
        2419.0,
        2556.0,
        2282.0,
        2312.0,
        2243.0,
        2376.0,
        2373.0,
        2153.0,
        2305.0
      ]
    ]
    for (name, expecteds) in durationSets {
      guard let feed = try? Self.xmlFeeds[name]?.get() else {
        XCTFail("Missing Podcast: \(name), \(Self.xmlFeeds[name])")
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
      }
    }
  }
}
