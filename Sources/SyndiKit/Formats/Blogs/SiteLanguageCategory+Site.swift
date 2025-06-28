//
//  SiteLanguageCategory+Site.swift
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

#if swift(>=5.7)
  @preconcurrency import Foundation
#else
  import Foundation
#endif

// swiftlint:disable nesting
extension SiteLanguageCategory {
  /// A ``struct`` representing a site.
  public struct Site: Codable, Sendable {
    /// The title of the site.
    public let title: String

    /// The author of the site.
    public let author: String

    /// The URL of the site.
    public let siteURL: URL

    /// The URL of the site's feed.
    public let feedURL: URL

    /// The URL of the site's Twitter page.
    public let twitterURL: URL?

    /// Coding keys to map properties to JSON keys.
    internal enum CodingKeys: String, CodingKey {
      case title
      case author
      case siteURL = "site_url"
      case feedURL = "feed_url"
      case twitterURL = "twitter_url"
    }
  }
}

/// A type alias for `SiteLanguageCategory.Site`.
public typealias SiteStub = SiteLanguageCategory.Site
