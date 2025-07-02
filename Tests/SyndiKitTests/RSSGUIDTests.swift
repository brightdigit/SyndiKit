#if swift(<6.1)
  import Foundation
#else
  internal import Foundation
#endif

import SyndiKit
import XCTest

final class RSSGUIDTests: XCTestCase {
  func testGUIDURL() {
    let urlString = "https://developer.apple.com/news/?id=jxky8h89"

    let urlGUID = EntryID(string: urlString)

    guard case let .url(url) = urlGUID else {
      XCTFail()
      return
    }
    XCTAssertEqual(url, URL(string: urlString))
  }

  func testGUIDUUID() {
    let expectedUUID = UUID()

    let expectedUUIDString = expectedUUID.uuidString
    let uuidGUID = EntryID(string: expectedUUIDString)

    guard case let .uuid(actualUUID) = uuidGUID else {
      XCTFail()
      return
    }
    XCTAssertEqual(actualUUID, expectedUUID)
  }

  func testGUIDYouTube() {
    let expectedPath = ["yt", "video", "3hccNoPE59U"]

    let pathGUID = EntryID(string: expectedPath.joined(separator: ":"))

    guard case let .path(actualPath, ":") = pathGUID else {
      XCTFail()
      return
    }
    XCTAssertEqual(actualPath, expectedPath)
  }
}
