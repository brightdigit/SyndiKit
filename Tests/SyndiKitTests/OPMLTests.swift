@testable import SyndiKit
import XCTest

internal final class OPMLTests: XCTestCase {
  internal func testSubscriptionList() throws {
    guard let opml = try? Content.opml["subscriptionList"]?.get() else {
      XCTFail("No decoded")
      return
    }

    XCTAssertEqual(opml.head.title, "mySubscriptions.opml")
    XCTAssertEqual(opml.head.ownerEmail, "dave@scripting.com")
    XCTAssertEqual(opml.body.outlines.count, 13)

    let firstOutline = opml.body.outlines.first

    XCTAssertEqual(firstOutline?.text, "CNET News.com")
    XCTAssertEqual(firstOutline?.description, "Tech news and business reports by CNET News.com. Focused on information technology, core topics include computers, hardware, software, networking, and Internet media.")
    XCTAssertEqual(firstOutline?.htmlUrl, "http://news.com.com/")
    XCTAssertEqual(firstOutline?.language, "unknown")
    XCTAssertEqual(firstOutline?.title, "CNET News.com")
    XCTAssertEqual(firstOutline?.type, "rss")
    XCTAssertEqual(firstOutline?.version, "RSS2")
    XCTAssertEqual(firstOutline?.xmlUrl, "http://news.com.com/2547-1_3-0-5.xml")
  }

  internal func testStates() throws {
    guard let opml = try? Content.opml["states"]?.get() else {
      XCTFail("No decoded")
      return
    }

    XCTAssertEqual(opml.head.title, "states.opml")
    XCTAssertEqual(opml.head.ownerEmail, "dave@scripting.com")
    XCTAssertEqual(opml.body.outlines.count, 1)

    let usOutline = opml.body.outlines.first

    XCTAssertEqual(usOutline?.text, "United States")
    
    XCTAssertEqual(usOutline?.outlines?.count, 8)
    
    let farWestOutline = usOutline?.outlines?.first

    XCTAssertEqual(farWestOutline?.text, "Far West")
    XCTAssertEqual(farWestOutline?.outlines?.count, 6)
    
    let nevadaOutline = farWestOutline?.outlines?[3]
    XCTAssertEqual(nevadaOutline?.outlines?.count, 4)
  }

  internal func testCategory() throws {
    guard let opml = try? Content.opml["category"]?.get() else {
      XCTFail("No decoded")
      return
    }

    XCTAssertEqual(opml.head.title, "Illustrating the category attribute")
    XCTAssertEqual(opml.body.outlines.count, 1)

    let outline = opml.body.outlines.first

    XCTAssertEqual(outline?.text, "The Mets are the best team in baseball.")
    XCTAssertEqual(outline?.categories?.count, 2)
    XCTAssertEqual(outline?.categories?[0], "/Philosophy/Baseball/Mets")
    XCTAssertEqual(outline?.categories?[1], "/Tourism/New York")
  }

  internal func testPlacesLived() throws {
    guard let opml = try? Content.opml["placesLived"]?.get() else {
      XCTFail("No decoded")
      return
    }

    XCTAssertEqual(opml.head.title, "placesLived.opml")
    XCTAssertEqual(opml.head.ownerId, "http://www.opml.org/profiles/sendMail?usernum=1")
    XCTAssertEqual(opml.head.expansionStates?.count, 6)
    XCTAssertEqual(opml.head.expansionStates?[0], 1)
    XCTAssertEqual(opml.head.expansionStates?[3], 10)
  }
}
