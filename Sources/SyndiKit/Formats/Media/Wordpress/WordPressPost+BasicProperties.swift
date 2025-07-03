//
//  WordPressPost+BasicProperties.swift
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

extension WordPressPost {
  /// A struct containing basic properties for creating a WordPress post.
  public struct BasicProperties: Sendable {
    /// The name of the post.
    public let name: String

    /// The title of the post.
    public let title: String

    /// The type of the post.
    public let type: String

    /// The link URL of the post.
    public let link: URL

    /// The publication date of the post.
    public let pubDate: Date?

    /// The creator of the post.
    public let creator: String

    /// The body content of the post.
    public let body: String

    /// The status of the post.
    public let status: String

    /// The comment status of the post.
    public let commentStatus: String

    /// The ping status of the post.
    public let pingStatus: String

    /// The parent ID of the post.
    public let parentID: Int

    /// The menu order of the post.
    public let menuOrder: Int

    /// The ID of the post.
    public let id: Int

    /// Whether the post is sticky.
    public let isSticky: Bool

    /// The attachment URL of the post.
    public let attachmentURL: URL?

    /// Initializes a BasicProperties instance with all basic properties.
    public init(
      name: String,
      title: String,
      type: String,
      link: URL,
      pubDate: Date?,
      creator: String,
      body: String,
      status: String,
      commentStatus: String,
      pingStatus: String,
      parentID: Int,
      menuOrder: Int,
      id: Int,
      isSticky: Bool,
      attachmentURL: URL?
    ) {
      self.name = name
      self.title = title
      self.type = type
      self.link = link
      self.pubDate = pubDate
      self.creator = creator
      self.body = body
      self.status = status
      self.commentStatus = commentStatus
      self.pingStatus = pingStatus
      self.parentID = parentID
      self.menuOrder = menuOrder
      self.id = id
      self.isSticky = isSticky
      self.attachmentURL = attachmentURL
    }
  }
}
