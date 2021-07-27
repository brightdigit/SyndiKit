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

  extension DecodingErrorTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__DecodingErrorTests = [
      ("testErrorsEmpty", testErrorsEmpty),
      ("testErrorsMany", testErrorsMany),
      ("testErrorsOne", testErrorsOne)
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

  extension SyndiKitTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SyndiKitTests = [
      ("testCategories", testCategories),
      ("testDurations", testDurations),
      ("testEntryable", testEntryable),
      ("testJSONXMLEquality", testJSONXMLEquality),
      ("testPodcastEpisodes", testPodcastEpisodes),
      ("testSyndication", testSyndication),
      ("testYoutubeVideos", testYoutubeVideos)
    ]
  }

  extension WordpressTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__WordpressTests = [
      ("testDateDecoder", testDateDecoder),
      ("testWordpressPosts", testWordpressPosts)
    ]
  }

  public func __allTests() -> [XCTestCaseEntry] {
    [
      testCase(BlogTests.__allTests__BlogTests),
      testCase(DecodingErrorTests.__allTests__DecodingErrorTests),
      testCase(RSSGUIDTests.__allTests__RSSGUIDTests),
      testCase(SyndiKitTests.__allTests__SyndiKitTests),
      testCase(WordpressTests.__allTests__WordpressTests)
    ]
  }
#endif
