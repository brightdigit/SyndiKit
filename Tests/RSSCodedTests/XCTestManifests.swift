#if !canImport(ObjectiveC)
  import XCTest

  extension BlogTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__BlogTests = [
      ("testBlogs", testBlogs)
    ]
  }

  extension RSSCodedTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__RSSCodedTests = [
      ("testCategories", testCategories),
      ("testDurations", testDurations),
      ("testEntryable", testEntryable),
      ("testJSONXMLEquality", testJSONXMLEquality),
      ("testPodcastEpisodes", testPodcastEpisodes),
      ("testSyndication", testSyndication),
      ("testYoutubeVideos", testYoutubeVideos)
    ]
  }

  extension RSSGUIDTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__RSSGUIDTests = [
      ("testGUIDURL", testGUIDURL),
      ("testGUIDUUID", testGUIDUUID),
      ("testGUIDYouTube", testGUIDYouTube)
    ]
  }

  public func __allTests() -> [XCTestCaseEntry] {
    return [
      testCase(BlogTests.__allTests__BlogTests),
      testCase(RSSCodedTests.__allTests__RSSCodedTests),
      testCase(RSSGUIDTests.__allTests__RSSGUIDTests)
    ]
  }
#endif
