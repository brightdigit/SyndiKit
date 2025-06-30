//
//  Site.swift
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
#else
  import Foundation
#endif

/// A struct representing a website.
public struct Site: Sendable {
  /// The title of the website.
  public let title: String

  /// The author of the website.
  public let author: String

  /// The URL of the website.
  public let siteURL: URL

  /// The URL of the website's feed.
  public let feedURL: URL

  /// The URL of the website's Twitter page, if available.
  public let twitterURL: URL?

  /// The category of the website.
  public let category: SiteCategoryType

  /// The language of the website.
  public let language: SiteLanguageType

  /// Initializes a new ``Site`` instance.
  ///
  /// - Parameters:
  ///   - site: The `SiteLanguageCategory.Site` instance to use as a base.
  ///   - categoryType: The category type of the website.
  ///   - languageType: The language type of the website.
  internal init(
    site: SiteLanguageCategory.Site,
    categoryType: SiteCategoryType,
    languageType: SiteLanguageType
  ) {
    title = site.title
    author = site.author
    siteURL = site.siteURL
    feedURL = site.feedURL
    twitterURL = site.twitterURL
    category = categoryType
    language = languageType
  }
}
