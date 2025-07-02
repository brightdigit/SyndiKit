//
//  WordPressPost+ValidatedFields.swift
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
  /// A struct containing validated required fields for creating a WordPress post.
  public struct ValidatedFields: Sendable {
    /// The name of the post.
    public let name: CData

    /// The type of the post.
    public let type: CData

    /// The creator of the post.
    public let creator: String

    /// The body content of the post.
    public let body: CData

    /// The status of the post.
    public let status: CData

    /// The comment status of the post.
    public let commentStatus: CData

    /// The ping status of the post.
    public let pingStatus: CData

    /// The parent ID of the post.
    public let parentID: Int

    /// The menu order of the post.
    public let menuOrder: Int

    /// The ID of the post.
    public let id: Int

    /// Whether the post is sticky.
    public let isSticky: Int

    /// The post date.
    public let postDate: Date

    /// The modified date.
    public let modifiedDate: Date

    /// The link URL of the post.
    public let link: URL

    /// The title of the post.
    public let title: String

    /// Initializes a ValidatedFields instance with all required fields.
    public init(
      name: CData,
      type: CData,
      creator: String,
      body: CData,
      status: CData,
      commentStatus: CData,
      pingStatus: CData,
      parentID: Int,
      menuOrder: Int,
      id: Int,
      isSticky: Int,
      postDate: Date,
      modifiedDate: Date,
      link: URL,
      title: String
    ) {
      self.name = name
      self.type = type
      self.creator = creator
      self.body = body
      self.status = status
      self.commentStatus = commentStatus
      self.pingStatus = pingStatus
      self.parentID = parentID
      self.menuOrder = menuOrder
      self.id = id
      self.isSticky = isSticky
      self.postDate = postDate
      self.modifiedDate = modifiedDate
      self.link = link
      self.title = title
    }
  }
}
