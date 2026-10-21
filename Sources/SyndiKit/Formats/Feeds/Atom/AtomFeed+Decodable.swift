//
//  AtomFeed+Decodable.swift
//  SyndiKit
//
//  Created by Leo Dion.
//  Copyright © 2026 BrightDigit.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#if swift(<6.0)
  import Foundation
#else
  internal import Foundation
#endif

extension AtomFeed {
  /// Creates a new instance by decoding from the given decoder.
  ///
  /// Links with an empty `href` are skipped: App Store review pages without
  /// reviews carry `<link rel="first" href=""/>` and similar.
  /// - Parameter decoder: The decoder to read data from.
  /// - Throws: An error if reading from the decoder fails.
  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(String.self, forKey: .id)
    title = try container.decode(String.self, forKey: .title)
    description = try container.decodeIfPresent(String.self, forKey: .description)
    subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle)
    published = try container.decodeIfPresent(Date.self, forKey: .published)
    pubDate = try container.decodeIfPresent(Date.self, forKey: .pubDate)
    links =
      try container.decodeIfPresent([NonEmptyLink].self, forKey: .links)?
      .compactMap(\.link) ?? []
    entries = try container.decodeIfPresent([AtomEntry].self, forKey: .entries) ?? []
    authors = try container.decodeIfPresent([Author].self, forKey: .authors) ?? []
    youtubeChannelID = try container.decodeIfPresent(String.self, forKey: .youtubeChannelID)
  }
}
