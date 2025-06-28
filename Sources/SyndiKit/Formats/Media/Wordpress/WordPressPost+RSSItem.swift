//
//  WordPressPost+RSSItem.swift
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

import Foundation

extension WordPressPost {
  /// A struct representing an Atom category.
  ///   Initializes a ``WordPressPost`` instance from an ``RSSItem``.
  ///
  ///   - Parameter item: The ``RSSItem`` to initialize from.
  ///
  ///   - Throws: `WordPressError.missingField` if any required field is missing.
  ///
  ///   - Note: This initializer is marked as ``public`` to allow external usage.
  ///
  /// - SeeAlso: ``EntryCategory``
  public init(item: RSSItem) throws {
    guard let name = item.wpPostName else {
      throw WordPressError.missingField(.name)
    }
    guard let type = item.wpPostType else {
      throw WordPressError.missingField(.type)
    }
    guard let creator = item.creators.first else {
      throw WordPressError.missingField(.creator)
    }
    guard let body = item.contentEncoded else {
      throw WordPressError.missingField(.body)
    }
    guard let status = item.wpStatus else {
      throw WordPressError.missingField(.status)
    }
    guard let commentStatus = item.wpCommentStatus else {
      throw WordPressError.missingField(.commentStatus)
    }
    guard let pingStatus = item.wpPingStatus else {
      throw WordPressError.missingField(.pingStatus)
    }
    guard let parentID = item.wpPostParent else {
      throw WordPressError.missingField(.parentID)
    }
    guard let menuOrder = item.wpMenuOrder else {
      throw WordPressError.missingField(.menuOrder)
    }
    guard let id = item.wpPostID else {
      throw WordPressError.missingField(.id)
    }
    guard let isSticky = item.wpIsSticky else {
      throw WordPressError.missingField(.isSticky)
    }
    guard let postDate = item.wpPostDate else {
      throw WordPressError.missingField(.postDate)
    }
    guard let modifiedDate = item.wpModifiedDate else {
      throw WordPressError.missingField(.modifiedDate)
    }
    guard let link = item.link else {
      throw WordPressError.missingField(.link)
    }

    let title = item.title
    let categoryTerms = item.categoryTerms
    let meta = item.wpPostMeta
    let pubDate = item.pubDate

    let categoryDictionary = Dictionary(
      grouping: categoryTerms
    ) {
      $0.domain
    }

    modifiedDateGMT = item.wpModifiedDateGMT
    self.name = name.value
    self.title = title
    self.type = type.value
    self.link = link
    self.pubDate = pubDate
    self.creator = creator
    self.body = body.value
    tags = categoryDictionary["post_tag", default: []].map { $0.value }
    categories = categoryDictionary["category", default: []].map { $0.value }
    self.meta = Dictionary(grouping: meta) { $0.key.value }
      .compactMapValues { $0.last?.value.value }
    self.status = status.value
    self.commentStatus = commentStatus.value
    self.pingStatus = pingStatus.value
    self.parentID = parentID
    self.menuOrder = menuOrder
    self.id = id
    self.isSticky = (isSticky != 0)
    self.postDate = postDate
    postDateGMT = item.wpPostDateGMT
    self.modifiedDate = modifiedDate
    attachmentURL = item.wpAttachmentURL
  }
}
