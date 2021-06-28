@testable import RSSCoded
import XCTest
import XMLCoder

extension String {
  func trimAndNilIfEmpty() -> String? {
    let text = trimmingCharacters(in: .whitespacesAndNewlines)
    return text.isEmpty ? nil : text
  }
}

internal extension JSONFeed {
  var homePageURLHttp: URL? {
    var components = URLComponents(url: homePageUrl, resolvingAgainstBaseURL: false)
    components?.scheme = "http"
    return components?.url
  }
}

extension Sequence {
  func mapPairResult<Success>(_ transform: @escaping (Element) throws -> Success) -> [(Element, Result<Success, Error>)] {
    map { element in
      (element, Result { try transform(element) })
    }
  }

  func mapResult<Success>(_ transform: @escaping (Element) throws -> Success) -> [Result<Success, Error>] {
    map { element in
      Result { try transform(element) }
    }
  }

  func flatResultMapValue<SuccessKey, SuccessValue, NewSuccess>(_ transform: @escaping (SuccessValue) throws -> NewSuccess) -> [(SuccessKey, Result<NewSuccess, Error>)] where Element == (SuccessKey, Result<SuccessValue, Error>) {
    map {
      let value = $0.1.flatMap { value in
        Result { try transform(value) }
      }
      return ($0.0, value)
    }
  }

  func flatResultMap<Success, NewSuccess>(_ transform: @escaping (Success) throws -> NewSuccess) -> [Result<NewSuccess, Error>] where Element == Result<Success, Error> {
    map {
      $0.flatMap { success in
        Result {
          try transform(success)
        }
      }
    }
  }
}

final class RSSCodedTests: XCTestCase {
  static func parseJSON(fromDirectoryURL sourceURL: URL? = nil) throws -> [String: Result<JSONFeed, Error>] {
    let sourceURL = sourceURL ?? Self.jsonDirectoryURL

    let decoder = JSONDecoder()
    LegacyFeed.decoder(decoder)
    let decoding = Decoding(for: JSONFeed.self, using: decoder)

    let pairs = try dataFromDirectoryURL(sourceURL).flatResultMapValue { try decoding.decode(data: $0) }

    return Dictionary(uniqueKeysWithValues: pairs)
  }

  static func dataFromDirectoryURL(_ sourceURL: URL) throws -> [(String, Result<Data, Error>)] {
    let urls = try FileManager.default.contentsOfDirectory(at: sourceURL, includingPropertiesForKeys: nil, options: [])

    return urls.mapPairResult {
      try Data(contentsOf: $0)
    }.map {
      ($0.0.deletingPathExtension().lastPathComponent, $0.1)
    }
  }

  static func parseXML(fromDirectoryURL sourceURL: URL? = nil) throws -> [String: Result<LegacyFeed, Error>] {
    let sourceURL = sourceURL ?? Self.xmlDirectoryURL
    let datas: [(String, Result<Data, Error>)]
    datas = try dataFromDirectoryURL(sourceURL)

    let decoder = XMLDecoder()
    LegacyFeed.decoder(decoder)

    let rssDecoding = Decoding(for: RSSFeed.self, using: decoder)
    let feedDecoding = Decoding(for: AtomFeed.self, using: decoder)
    let pairs = datas.flatResultMapValue { data throws -> LegacyFeed in
      do {
        return LegacyFeed.atom(try feedDecoding.decode(data: data))
      } catch {
        return LegacyFeed.rss(try rssDecoding.decode(data: data))
      }
    }

    return Dictionary(uniqueKeysWithValues: pairs)
  }

  static var xmlFeeds: [String: Result<LegacyFeed, Error>]!
  static var jsonFeeds: [String: Result<LegacyFeed, Error>]!

  override class func setUp() {
    // swiftlint:disable force_try
    let xmlDataSet = try! dataFromDirectoryURL(Self.xmlDirectoryURL)
    let jsonDataSet = try! dataFromDirectoryURL(Self.jsonDirectoryURL)
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

  func testJSONXMLEquality() throws {
    for (name, xmlResult) in RSSCodedTests.xmlFeeds {
      guard let jsonResult = RSSCodedTests.jsonFeeds[name] else {
        continue
      }

      let json: LegacyFeed
      let rss: LegacyFeed

      do {
        json = try jsonResult.get()
        rss = try xmlResult.get()
      } catch {
        XCTAssertNil(error)
        continue
      }

      XCTAssertEqual(json.title.trimmingCharacters(in: .whitespacesAndNewlines), rss.title.trimmingCharacters(in: .whitespacesAndNewlines))
      XCTAssertEqual(json.homePageUrl?.remainingPath.trimAndNilIfEmpty(), rss.homePageUrl?.remainingPath.trimAndNilIfEmpty())
      if let description = rss.description {
        XCTAssertEqual(json.description?.trimAndNilIfEmpty() ?? "", description.trimmingCharacters(in: .whitespacesAndNewlines), "Description does not match for \(name)")

      } else {
        XCTAssertEqual(json.description?.count ?? 0, 0)
      }

      let items = zip(json.items.sorted(by: {
        $0.title < $1.title
      }), rss.entries.sorted(by: {
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

  static let itemCount = 20
  static let xmlDirectoryURL = URL(string: #file)!.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("Data").appendingPathComponent("XML")

  static let jsonDirectoryURL = URL(string: #file)!.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("Data").appendingPathComponent("JSON")
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
        XCTFail("Missing Podcast")
        continue
      }

      guard case let .rss(rss) = feed else {
        XCTFail("Wrong Type")
        continue
      }

      var episodeNumbers = episodeNumbers
      let actualEps = rss.channel.item.compactMap { $0.itunesEpisode?.value }

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

      guard case let .rss(rss) = feed else {
        XCTFail("Wrong Type")
        continue
      }

      XCTAssertEqual(rss.channel.syndication, update)
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

      guard case let .rss(rss) = feed else {
        XCTFail("Wrong Type")
        continue
      }

      let actuals = rss.channel.item.compactMap { $0.itunesDuration?.value }

      let times = zip(actuals, expecteds)

      for (index, (actual, expected)) in times.enumerated() {
        XCTAssertEqual(actual, expected, "no equal at \(index)")
      }
    }
  }
}

extension URL {
  var remainingPath: String {
    let path = self.path

    return path == "/" ? "" : path
  }
}
