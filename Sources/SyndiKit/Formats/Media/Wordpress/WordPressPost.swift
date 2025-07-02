//
//  WordPressPost.swift
//  SyndiKit
//
//  Created by Leo Dion.
//  Copyright © 2025 BrightDigit.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the “Software”), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#if swift(<5.7)
  @preconcurrency import Foundation
#elseif swift(<6.1)
  import Foundation
#else
  public import Foundation
#endif

/// A struct representing a WordPress post.
public struct WordPressPost: Sendable {
  /// The type of the post.
  public typealias PostType = String

  /// The comment status of the post.
  public typealias CommentStatus = String

  /// The ping status of the post.
  public typealias PingStatus = String

  /// The status of the post.
  public typealias Status = String

  /// An enum representing the fields of a WordPress post.
  public enum Field: Equatable, Sendable {
    case name
    case title
    case type
    case link
    case pubDate
    case creator
    case body
    case tags
    case categories
    case meta
    case status
    case commentStatus
    case pingStatus
    case parentID
    case menuOrder
    case id
    case isSticky
    case postDate
    case postDateGMT
    case modifiedDate
    case modifiedDateGMT
  }

  /// The name of the post.
  public let name: String

  /// The title of the post.
  public let title: String

  /// The type of the post.
  public let type: PostType

  /// The link of the post.
  public let link: URL

  /// The publication date of the post.
  public let pubDate: Date?

  /// The creator of the post.
  public let creator: String

  /// The body of the post.
  public let body: String

  /// The tags of the post.
  public let tags: [String]

  /// The categories of the post.
  public let categories: [String]

  /// The meta data of the post.
  public let meta: [String: String]

  /// The status of the post.
  public let status: Status

  /// The comment status of the post.
  public let commentStatus: CommentStatus

  /// The ping status of the post.
  public let pingStatus: PingStatus

  /// The parent ID of the post.
  public let parentID: Int?

  /// The menu order of the post.
  public let menuOrder: Int?

  /// The ID of the post.
  public let id: Int

  /// A boolean indicating if the post is sticky.
  public let isSticky: Bool

  /// The post date of the post.
  public let postDate: Date

  /// The post date in GMT of the post.
  public let postDateGMT: Date?

  /// The modified date of the post.
  public let modifiedDate: Date

  /// The modified date in GMT of the post.
  public let modifiedDateGMT: Date?

  /// The attachment URL of the post.
  public let attachmentURL: URL?

  /// Initializes a WordPressPost instance from an RSSItem.
  ///
  /// - Parameter item: The RSSItem to initialize from.
  /// - Throws: `WordPressError.missingField` if any required field is missing.
  public init(item: RSSItem) throws {
    let validatedFields = try Validator.validateRequiredFields(item: item)
    let processedFields = Processor.processOptionalFields(item: item)

    self = Processor.createWordPressPost(
      validatedFields: validatedFields,
      processedFields: processedFields
    )
  }

  /// Initializes a WordPressPost instance with all properties.
  ///
  /// - Parameters:
  ///   - name: The name of the post.
  ///   - title: The title of the post.
  ///   - type: The type of the post.
  ///   - link: The link URL of the post.
  ///   - pubDate: The publication date of the post.
  ///   - creator: The creator of the post.
  ///   - body: The body content of the post.
  ///   - tags: The tags associated with the post.
  ///   - categories: The categories associated with the post.
  ///   - meta: The meta data dictionary.
  ///   - status: The status of the post.
  ///   - commentStatus: The comment status of the post.
  ///   - pingStatus: The ping status of the post.
  ///   - parentID: The parent ID of the post.
  ///   - menuOrder: The menu order of the post.
  ///   - id: The ID of the post.
  ///   - isSticky: Whether the post is sticky.
  ///   - postDate: The post date.
  ///   - postDateGMT: The post date in GMT.
  ///   - modifiedDate: The modified date.
  ///   - modifiedDateGMT: The modified date in GMT.
  ///   - attachmentURL: The attachment URL of the post.
  public init(
    name: String,
    title: String,
    type: PostType,
    link: URL,
    pubDate: Date?,
    creator: String,
    body: String,
    tags: [String],
    categories: [String],
    meta: [String: String],
    status: Status,
    commentStatus: CommentStatus,
    pingStatus: PingStatus,
    parentID: Int?,
    menuOrder: Int?,
    id: Int,
    isSticky: Bool,
    postDate: Date,
    postDateGMT: Date?,
    modifiedDate: Date,
    modifiedDateGMT: Date?,
    attachmentURL: URL?
  ) {
    self.name = name
    self.title = title
    self.type = type
    self.link = link
    self.pubDate = pubDate
    self.creator = creator
    self.body = body
    self.tags = tags
    self.categories = categories
    self.meta = meta
    self.status = status
    self.commentStatus = commentStatus
    self.pingStatus = pingStatus
    self.parentID = parentID
    self.menuOrder = menuOrder
    self.id = id
    self.isSticky = isSticky
    self.postDate = postDate
    self.postDateGMT = postDateGMT
    self.modifiedDate = modifiedDate
    self.modifiedDateGMT = modifiedDateGMT
    self.attachmentURL = attachmentURL
  }
}
