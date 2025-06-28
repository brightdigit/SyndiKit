//
//  BasicProperties.swift
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

internal struct BasicProperties {
  internal let title: String
  internal let link: URL?
  internal let description: CData?
  internal let guid: EntryID
  internal let pubDate: Date?
  internal let contentEncoded: CData?
  internal let categoryTerms: [RSSItemCategory]
  internal let content: String?
  internal let enclosure: Enclosure?
  internal let creators: [String]

  internal init(
    title: String,
    link: URL? = nil,
    description: CData? = nil,
    guid: EntryID,
    pubDate: Date? = nil,
    contentEncoded: CData? = nil,
    categoryTerms: [RSSItemCategory],
    content: String? = nil,
    enclosure: Enclosure? = nil,
    creators: [String]
  ) {
    self.title = title
    self.link = link
    self.description = description
    self.guid = guid
    self.pubDate = pubDate
    self.contentEncoded = contentEncoded
    self.categoryTerms = categoryTerms
    self.content = content
    self.enclosure = enclosure
    self.creators = creators
  }

  internal init(from container: KeyedDecodingContainer<RSSItem.CodingKeys>) throws {
    self.init(
      title: try container.decode(String.self, forKey: .title),
      link: try container.decodeIfPresent(URL.self, forKey: .link),
      description: try container.decodeIfPresent(CData.self, forKey: .description),
      guid: try container.decode(EntryID.self, forKey: .guid),
      pubDate: try container.decodeDateIfPresentAndValid(forKey: .pubDate),
      contentEncoded: try container.decodeIfPresent(CData.self, forKey: .contentEncoded),
      categoryTerms: try container.decode([RSSItemCategory].self, forKey: .categoryTerms),
      content: try container.decodeIfPresent(String.self, forKey: .content),
      enclosure: try container.decodeIfPresent(Enclosure.self, forKey: .enclosure),
      creators: try container.decode([String].self, forKey: .creators)
    )
  }
}
