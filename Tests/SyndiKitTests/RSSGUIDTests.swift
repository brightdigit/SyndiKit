import SyndiKit
import Testing

@testable import SyndiKitTestSupport

#if swift(<6.0)
  import Foundation
#else
  internal import Foundation
#endif

@Suite("RSS GUID Tests")
struct RSSGUIDTests {
  @Test("Entry ID parses URL format")
  func guidURL() {
    let urlString = "https://developer.apple.com/news/?id=jxky8h89"

    let urlGUID = EntryID(string: urlString)

    guard case let .url(url) = urlGUID else {
      Issue.record("Expected .url case")
      return
    }
    #expect(url == URL(string: urlString))
  }

  @Test("Entry ID parses UUID format")
  func guidUUID() {
    let expectedUUID = UUID()

    let expectedUUIDString = expectedUUID.uuidString
    let uuidGUID = EntryID(string: expectedUUIDString)

    guard case let .uuid(actualUUID) = uuidGUID else {
      Issue.record("Expected .uuid case")
      return
    }
    #expect(actualUUID == expectedUUID)
  }

  @Test("Entry ID parses YouTube path format")
  func guidYouTube() {
    let expectedPath = ["yt", "video", "3hccNoPE59U"]

    let pathGUID = EntryID(string: expectedPath.joined(separator: ":"))

    guard case let .path(actualPath, ":") = pathGUID else {
      Issue.record("Expected .path case")
      return
    }
    #expect(actualPath == expectedPath)
  }
}
