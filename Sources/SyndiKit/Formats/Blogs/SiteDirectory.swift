//
//  SiteDirectory.swift
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

/// A protocol for site directories.
public protocol SiteDirectory: Sendable {
  /// List of Sites
  associatedtype SiteSequence: Sequence where SiteSequence.Element == Site
  /// List of Languages
  associatedtype LanguageSequence: Sequence where LanguageSequence.Element == SiteLanguage
  /// List of Categories
  associatedtype CategorySequence: Sequence where CategorySequence.Element == SiteCategory

  /// A sequence of languages in the site directory.
  var languages: LanguageSequence { get }

  /// A sequence of categories in the site directory.
  var categories: CategorySequence { get }

  /// Retrieves a list of sites based on the specified language and category.
  ///
  /// - Parameters:
  ///   - language: The language of the sites to retrieve.
  ///   - category: The category of the sites to retrieve.
  /// - Returns: A list of sites matching the specified language and category.
  func sites(
    withLanguage language: SiteLanguageType?,
    withCategory category: SiteCategoryType?
  ) -> SiteSequence
}

extension SiteDirectory {
  /// Retrieves a list of sites based on the specified language and category.
  ///
  /// - Parameters:
  ///   - language: The language of the sites to retrieve.
  ///   - category: The category of the sites to retrieve.
  /// - Returns: A list of sites matching the specified language and category.
  public func sites(
    withLanguage language: SiteLanguageType? = nil,
    withCategory category: SiteCategoryType? = nil
  ) -> SiteSequence {
    sites(withLanguage: language, withCategory: category)
  }
}
