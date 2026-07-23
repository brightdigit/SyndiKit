//
//  MediaPropertiesNilTests.swift
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

import Testing

@testable import SyndiKit

#if swift(<6.0)
  import Foundation
#else
  internal import Foundation
#endif

@Suite("Media Properties Nil-Branch Tests")
internal struct MediaPropertiesNilTests {
  /// A minimal RSS feed whose single item has no `<enclosure>` element.
  private static let rssWithoutEnclosure = """
    <?xml version="1.0" encoding="UTF-8"?>
    <rss version="2.0">
      <channel>
        <title>No Enclosure Channel</title>
        <link>https://example.com</link>
        <description>A channel without media enclosures.</description>
        <item>
          <title>Plain Article</title>
          <link>https://example.com/article</link>
          <guid>https://example.com/article</guid>
          <description>An article with no enclosure.</description>
        </item>
      </channel>
    </rss>
    """

  /// A minimal Atom feed whose single entry has no YouTube channel/video IDs.
  private static let atomWithoutYouTubeIDs = """
    <?xml version="1.0" encoding="utf-8"?>
    <feed xmlns="http://www.w3.org/2005/Atom">
      <title>No YouTube Feed</title>
      <id>https://example.com/feed</id>
      <updated>2026-01-01T00:00:00+00:00</updated>
      <link href="https://example.com/" rel="alternate" type="text/html" />
      <entry>
        <title>An Ordinary Entry</title>
        <id>https://example.com/entry</id>
        <updated>2026-01-01T00:00:00+00:00</updated>
        <link href="https://example.com/entry" rel="alternate" type="text/html" />
      </entry>
    </feed>
    """

  @Test("PodcastEpisodeProperties(rssItem:) returns nil when there is no enclosure")
  internal func podcastEpisodeWithoutEnclosure() throws {
    let data = try #require(Self.rssWithoutEnclosure.data(using: .utf8))
    let feed = try SynDecoder().decode(data)
    let rssFeed = try #require(feed as? RSSFeed)
    let item = try #require(rssFeed.channel.items.first)

    #expect(item.enclosure == nil)
    #expect(PodcastEpisodeProperties(rssItem: item) == nil)
  }

  @Test("YouTubeIDProperties(entry:) returns nil for a non-YouTube Atom entry")
  internal func youTubeIDPropertiesWithoutYouTubeIDs() throws {
    let data = try #require(Self.atomWithoutYouTubeIDs.data(using: .utf8))
    let feed = try SynDecoder().decode(data)
    let atomFeed = try #require(feed as? AtomFeed)
    let entry = try #require(atomFeed.entries.first)

    #expect(entry.youtubeChannelID == nil)
    #expect(entry.youtubeVideoID == nil)
    #expect(YouTubeIDProperties(entry: entry) == nil)
  }
}
