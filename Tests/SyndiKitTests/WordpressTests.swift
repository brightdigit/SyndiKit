import Foundation
import XCTest

@testable import SyndiKit

final class WordpressTests: XCTestCase {
  static let baseSiteURLs: [String: URL] = [
    "articles": URL(string: "https://brightdigit.com/")!,
    "tutorials": URL(string: "https://brightdigit.com/")!,
  ]

  static let baseBlogURLs: [String: URL] = [
    "articles": URL(string: "https://brightdigit.com")!,
    "tutorials": URL(string: "https://learningswift.brightdigit.com")!,
  ]

  func testDateDecoder() {
    let dateDecoder = DateFormatterDecoder.RSS.decoder
    let result = dateDecoder.decodeString("Fri, 06 Oct 2017 17:21:35 +0000")
    XCTAssertNotNil(result)

    let another = dateDecoder.decodeString("2017-10-06 16:59:50")
    XCTAssertNotNil(another)
  }

  // swiftlint:disable:next function_body_length
  @available(macOS 13.0, *)
  func testWordpressPosts() {
    let decoder = SynDecoder()

    let exports = Dictionary(
      uniqueKeysWithValues: Content.wordpressDataSet
    ).mapValues { result in
      result.flatMap { data in
        Result { try decoder.decode(data) }
      }
    }

    for (name, result) in exports {
      let feedable: Feedable
      do {
        feedable = try result.get()
      } catch {
        XCTAssertNil(error, name)

        continue
      }

      guard let feed = feedable as? RSSFeed else {
        XCTFail()
        continue
      }

      XCTAssertNotNil(feed.channel.wpBaseSiteURL)
      XCTAssertNotNil(feed.channel.wpBaseBlogURL)
      XCTAssertEqual(feed.channel.wpBaseSiteURL, Self.baseSiteURLs[name])
      XCTAssertEqual(feed.channel.wpBaseBlogURL, Self.baseBlogURLs[name])
      XCTAssertGreaterThan(feed.channel.wpTags.count, 0)
      XCTAssertGreaterThan(feed.channel.wpCategories.count, 0)
      let notPostIndex = feed.channel.items.firstIndex(where: {
        $0.wpPostID == nil
      })

      XCTAssertNil(notPostIndex)

      if let index = notPostIndex {
        dump(feed.channel.items[index])
      }
    }
  }

  func testInitMissingName() {
    let urlString = "https://developer.apple.com/news/?id=jxky8h89"
    let url = URL(strict: urlString)!
    let itemMissingName = RSSItem(
      title: UUID().uuidString,
      link: url,
      description: UUID().uuidString,
      guid: .url(url)
    )
    var caughtError: WordPressError?
    XCTAssertThrowsError(try WordPressPost(item: itemMissingName)) {
      caughtError = $0 as? WordPressError
    }
    XCTAssertEqual(caughtError, .missingField(.name))
  }

  // swiftlint:disable:next function_body_length
  func testInitAllFields() {
    let urlString = "https://developer.apple.com/news/?id=jxky8h89"
    let url = URL(strict: urlString)!
    let title = UUID().uuidString
    let description = UUID().uuidString

    let contentEncoded = UUID().uuidString
    let creator = UUID().uuidString
    let wpCommentStatus = UUID().uuidString
    let wpPingStatus = UUID().uuidString
    let wpStatus = UUID().uuidString
    let wpPostName = UUID().uuidString
    let wpPostType = UUID().uuidString

    let wpPostParent: Int = .random(in: 0...100_000)
    let wpMenuOrder: Int = .random(in: 0...100_000)
    let wpIsSticky: Int = .random(in: 0...100_000)
    let wpPostID: Int = .random(in: 0...100_000)

    let wpPostDate = Date(timeIntervalSinceNow: .random(in: 0...100_000))
    let wpModifiedDate = Date(timeIntervalSinceNow: .random(in: 0...100_000))

    let item = RSSItem(
      title: title,
      link: url,
      description: description,
      guid: .url(url),
      contentEncoded: contentEncoded,
      creators: [creator],
      wpCommentStatus: wpCommentStatus,
      wpPingStatus: wpPingStatus,
      wpStatus: wpStatus,
      wpPostParent: wpPostParent,
      wpMenuOrder: wpMenuOrder,
      wpIsSticky: wpIsSticky,
      wpPostID: wpPostID,
      wpPostDate: wpPostDate,
      wpModifiedDate: wpModifiedDate,
      wpPostName: wpPostName,
      wpPostType: wpPostType
    )

    let post: WordPressPost
    do {
      post = try WordPressPost(item: item)
    } catch {
      XCTAssertNil(error)
      return
    }

    XCTAssertEqual(post.title, title)
    XCTAssertEqual(post.link, url)
    XCTAssertEqual(post.body, contentEncoded)
    XCTAssertEqual(post.creator, creator)
    XCTAssertEqual(post.commentStatus, wpCommentStatus)
    XCTAssertEqual(post.pingStatus, wpPingStatus)
    XCTAssertEqual(post.status, wpStatus)
    XCTAssertEqual(post.parentID, wpPostParent)
    XCTAssertEqual(post.menuOrder, wpMenuOrder)
    XCTAssertEqual(post.isSticky, wpIsSticky != 0)
    XCTAssertEqual(post.id, wpPostID)
    XCTAssertEqual(post.postDate, wpPostDate)
    XCTAssertEqual(post.modifiedDate, wpModifiedDate)
    XCTAssertEqual(post.name, wpPostName)
    XCTAssertEqual(post.type, wpPostType)
  }

  // swiftlint:disable:next function_body_length
  func testInitAllFieldsMeta() {
    let urlString = "https://developer.apple.com/news/?id=jxky8h89"
    let url = URL(strict: urlString)!
    let title = UUID().uuidString
    let description = UUID().uuidString

    let contentEncoded = UUID().uuidString
    let creator = UUID().uuidString
    let wpCommentStatus = UUID().uuidString
    let wpPingStatus = UUID().uuidString
    let wpStatus = UUID().uuidString
    let wpPostName = UUID().uuidString
    let wpPostType = UUID().uuidString

    let wpPostParent: Int = .random(in: 0...100_000)
    let wpMenuOrder: Int = .random(in: 0...100_000)
    let wpIsSticky: Int = .random(in: 0...100_000)
    let wpPostID: Int = .random(in: 0...100_000)

    let wpPostDate = Date(timeIntervalSinceNow: .random(in: 0...100_000))
    let wpModifiedDate = Date(timeIntervalSinceNow: .random(in: 0...100_000))

    let postMetaKeys = (1...Int.random(in: 3...5)).map { _ in
      UUID().uuidString
    }
    let postMetaValues = postMetaKeys.map { _ in
      UUID().uuidString
    }
    let postMetaDictionary = Dictionary(
      uniqueKeysWithValues: zip(postMetaKeys, postMetaValues)
    )
    let postMetaActual = postMetaDictionary.map(WordPressElements.PostMeta.init)
    let postMetaNoise = (1...Int.random(in: 3...5)).compactMap { _ in
      postMetaKeys.randomElement().map {
        WordPressElements.PostMeta(key: $0, value: UUID().uuidString)
      }
    }
    let postMetaArray = postMetaNoise + postMetaActual

    let item = RSSItem(
      title: title,
      link: url,
      description: description,
      guid: .url(url),
      contentEncoded: contentEncoded,
      creators: [creator],
      wpCommentStatus: wpCommentStatus,
      wpPingStatus: wpPingStatus,
      wpStatus: wpStatus,
      wpPostParent: wpPostParent,
      wpMenuOrder: wpMenuOrder,
      wpIsSticky: wpIsSticky,
      wpPostID: wpPostID,
      wpPostDate: wpPostDate,
      wpModifiedDate: wpModifiedDate,
      wpPostName: wpPostName,
      wpPostType: wpPostType,
      wpPostMeta: postMetaArray
    )

    let post: WordPressPost
    do {
      post = try WordPressPost(item: item)
    } catch {
      XCTAssertNil(error)
      return
    }

    XCTAssertEqual(post.title, title)
    XCTAssertEqual(post.link, url)
    XCTAssertEqual(post.body, contentEncoded)
    XCTAssertEqual(post.creator, creator)
    XCTAssertEqual(post.commentStatus, wpCommentStatus)
    XCTAssertEqual(post.pingStatus, wpPingStatus)
    XCTAssertEqual(post.status, wpStatus)
    XCTAssertEqual(post.parentID, wpPostParent)
    XCTAssertEqual(post.menuOrder, wpMenuOrder)
    XCTAssertEqual(post.isSticky, wpIsSticky != 0)
    XCTAssertEqual(post.id, wpPostID)
    XCTAssertEqual(post.postDate, wpPostDate)
    XCTAssertEqual(post.modifiedDate, wpModifiedDate)
    XCTAssertEqual(post.name, wpPostName)
    XCTAssertEqual(post.type, wpPostType)
    XCTAssertEqual(post.meta, postMetaDictionary)
  }

  // swiftlint:disable:next function_body_length
  func testInitAllFieldsWMeta() {
    let urlString = "https://developer.apple.com/news/?id=jxky8h89"
    let url = URL(strict: urlString)!
    let title = UUID().uuidString
    let description = UUID().uuidString

    let contentEncoded = UUID().uuidString
    let creator = UUID().uuidString
    let wpCommentStatus = UUID().uuidString
    let wpPingStatus = UUID().uuidString
    let wpStatus = UUID().uuidString
    let wpPostName = UUID().uuidString
    let wpPostType = UUID().uuidString

    let wpPostParent: Int = .random(in: 0...100_000)
    let wpMenuOrder: Int = .random(in: 0...100_000)
    let wpIsSticky: Int = .random(in: 0...100_000)
    let wpPostID: Int = .random(in: 0...100_000)

    let wpPostDate = Date(timeIntervalSinceNow: .random(in: 0...100_000))
    let wpModifiedDate = Date(timeIntervalSinceNow: .random(in: 0...100_000))
    let postTags = (5...10).map { _ in UUID().uuidString }
    let categories = (5...10).map { _ in UUID().uuidString }
    let categoryTermsNoise: [RSSItemCategory] = (5...10).map { _ in
      RSSItemCategory(value: UUID().uuidString, domain: UUID().uuidString)
    }

    let categoryTerms =
      postTags.map {
        RSSItemCategory(value: $0, domain: "post_tag")
      }
      + categories.map {
        RSSItemCategory(value: $0, domain: "category")
      } + categoryTermsNoise

    let item = RSSItem(
      title: title,
      link: url,
      description: description,
      guid: .url(url),
      contentEncoded: contentEncoded,
      categoryTerms: categoryTerms,
      creators: [creator],
      wpCommentStatus: wpCommentStatus,
      wpPingStatus: wpPingStatus,
      wpStatus: wpStatus,
      wpPostParent: wpPostParent,
      wpMenuOrder: wpMenuOrder,
      wpIsSticky: wpIsSticky,
      wpPostID: wpPostID,
      wpPostDate: wpPostDate,
      wpModifiedDate: wpModifiedDate,
      wpPostName: wpPostName,
      wpPostType: wpPostType
    )

    let post: WordPressPost
    do {
      post = try WordPressPost(item: item)
    } catch {
      XCTAssertNil(error)
      return
    }

    XCTAssertEqual(post.title, title)
    XCTAssertEqual(post.link, url)
    XCTAssertEqual(post.body, contentEncoded)
    XCTAssertEqual(post.creator, creator)
    XCTAssertEqual(post.commentStatus, wpCommentStatus)
    XCTAssertEqual(post.pingStatus, wpPingStatus)
    XCTAssertEqual(post.status, wpStatus)
    XCTAssertEqual(post.parentID, wpPostParent)
    XCTAssertEqual(post.menuOrder, wpMenuOrder)
    XCTAssertEqual(post.isSticky, wpIsSticky != 0)
    XCTAssertEqual(post.id, wpPostID)
    XCTAssertEqual(post.postDate, wpPostDate)
    XCTAssertEqual(post.modifiedDate, wpModifiedDate)
    XCTAssertEqual(post.name, wpPostName)
    XCTAssertEqual(post.type, wpPostType)

    XCTAssertEqual(post.categories, categories)
    XCTAssertEqual(post.tags, postTags)
  }

  // swiftlint:disable:next function_body_length
  @available(macOS 13.0, *)
  func testWpAttachmentURL() {
    let decoder = SynDecoder()

    let exports = Dictionary(
      uniqueKeysWithValues: Content.wordpressDataSet
    ).mapValues { result in
      result.flatMap { data in
        Result { try decoder.decode(data) }
      }
    }

    for (name, result) in exports {
      let feedable: Feedable
      do {
        feedable = try result.get()
      } catch {
        XCTAssertNil(error, name)

        continue
      }

      guard let feed = feedable as? RSSFeed else {
        XCTFail()
        continue
      }

      let items = feed.channel.items.compactMap { item in
        (try? WordPressPost(item: item)).map { (item, $0) }
      }.filter {
        $0.1.type == "attachment"
      }

      for (item, post) in items {
        XCTAssertNotNil(item.wpAttachmentURL)
        XCTAssertEqual(item.wpAttachmentURL, post.attachmentURL)
      }
    }
  }
}
