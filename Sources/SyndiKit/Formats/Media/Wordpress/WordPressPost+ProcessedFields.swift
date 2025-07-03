//
//  WordPressPost+ProcessedFields.swift
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
  /// A struct containing processed optional fields for creating a WordPress post.
  public struct ProcessedFields: Sendable {
    /// The category terms associated with the post.
    public let categoryTerms: [RSSItemCategory]

    /// The meta data associated with the post.
    public let meta: [WordPressElements.PostMeta]

    /// The publication date of the post.
    public let pubDate: Date?

    /// The modified date in GMT.
    public let modifiedDateGMT: Date?

    /// The post date in GMT.
    public let postDateGMT: Date?

    /// The attachment URL of the post.
    public let attachmentURL: URL?

    /// Initializes a ProcessedFields instance with optional fields.
    public init(
      categoryTerms: [RSSItemCategory],
      meta: [WordPressElements.PostMeta],
      pubDate: Date?,
      modifiedDateGMT: Date?,
      postDateGMT: Date?,
      attachmentURL: URL?
    ) {
      self.categoryTerms = categoryTerms
      self.meta = meta
      self.pubDate = pubDate
      self.modifiedDateGMT = modifiedDateGMT
      self.postDateGMT = postDateGMT
      self.attachmentURL = attachmentURL
    }

    internal func groupByDomain() -> [String: [RSSItemCategory]] {
      let domainTermTuple = self
        .categoryTerms
        .compactMap { term -> (String, RSSItemCategory)? in
          guard let domain = term.domain else {
            return nil
          }
          return (domain, term)
        }

      return Dictionary(
        grouping: domainTermTuple
      ) {
        $0.0
      }
      .mapValues {
        $0.map {
          $0.1
        }
      }
    }
  }
}
