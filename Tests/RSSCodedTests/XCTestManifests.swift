#if !canImport(ObjectiveC)
  import XCTest

  extension RSSCodedTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__RSSCodedTests = [
      ("testDurations", testDurations),
      ("testJSONXMLEquality", testJSONXMLEquality),
      ("testPodcastEpisodes", testPodcastEpisodes),
      ("testSyndication", testSyndication)
    ]
  }

  public func __allTests() -> [XCTestCaseEntry] {
    return [
      testCase(RSSCodedTests.__allTests__RSSCodedTests)
    ]
  }
#endif
