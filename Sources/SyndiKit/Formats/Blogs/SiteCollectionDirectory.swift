//
//  SiteCollectionDirectory.swift
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

/// A directory of site collections.
public struct SiteCollectionDirectory: SiteDirectory, Sendable {
  /// A sequence of sites.
  public typealias SiteSequence = [Site]

  /// A sequence of languages.
  public typealias LanguageSequence = Dictionary<SiteLanguageType, SiteLanguage>.Values

  /// A sequence of categories.
  public typealias CategorySequence = Dictionary<SiteCategoryType, SiteCategory>.Values

  /// The internal structure of the site collection directory.
  internal struct Instance: Sendable {
    internal let allSites: [Site]
    internal let languageDictionary: [SiteLanguageType: SiteLanguage]
    internal let categoryDictionary: [SiteCategoryType: SiteCategory]
    internal let languageIndices: [SiteLanguageType: Set<Int>]
    internal let categoryIndices: [SiteCategoryType: Set<Int>]

    internal func sites(
      withLanguage language: SiteLanguageType?,
      withCategory category: SiteCategoryType?
    ) -> [Site] {
      filteredSites(language: language, category: category)
    }

    private func filteredSites(
      language: SiteLanguageType?,
      category: SiteCategoryType?
    ) -> [Site] {
      let languageIndices = getLanguageIndices(for: language)
      let categoryIndices = getCategoryIndices(for: category)
      let combinedIndices = combineIndices(
        languageIndices: languageIndices, categoryIndices: categoryIndices)
      return getSitesFromIndices(combinedIndices)
    }

    private func getLanguageIndices(for language: SiteLanguageType?) -> Set<Int>? {
      guard let language = language else { return nil }
      return self.languageIndices[language] ?? .init()
    }

    private func getCategoryIndices(for category: SiteCategoryType?) -> Set<Int>? {
      guard let category = category else { return nil }
      return self.categoryIndices[category] ?? .init()
    }

    private func combineIndices(
      languageIndices: Set<Int>?,
      categoryIndices: Set<Int>?
    ) -> Set<Int>? {
      var indices: Set<Int>?

      if let languageIndices = languageIndices {
        indices = languageIndices
      }

      if let categoryIndices = categoryIndices {
        if let current = indices {
          indices = current.intersection(categoryIndices)
        } else {
          indices = categoryIndices
        }
      }

      return indices
    }

    private func getSitesFromIndices(_ indices: Set<Int>?) -> [Site] {
      if let current = indices {
        return current.map { self.allSites[$0] }
      } else {
        return allSites
      }
    }

    internal init(blogs: SiteCollection) {
      let result = ProcessedBlogsResult.process(blogs)
      self.languageDictionary = Dictionary(
        uniqueKeysWithValues: result.languages.map { ($0.type, $0) }
      )
      self.categoryDictionary = Dictionary(grouping: result.categories) { $0.type }
        .compactMapValues(SiteCategory.init)
      self.languageIndices = result.languageIndices
      self.categoryIndices = result.categoryIndices
      allSites = result.sites
    }
  }

  private let instance: Instance

  /// A sequence of languages in the site collection directory.
  public var languages: Dictionary<SiteLanguageType, SiteLanguage>.Values {
    instance.languageDictionary.values
  }

  /// A sequence of categories in the site collection directory.
  public var categories: Dictionary<SiteCategoryType, SiteCategory>.Values {
    instance.categoryDictionary.values
  }

  /// Initializes a new instance of the ``SiteCollectionDirectory`` struct.
  ///
  /// - Parameter blogs: The site collection to use.
  internal init(blogs: SiteCollection) {
    instance = .init(blogs: blogs)
  }

  /// Retrieves a list of sites based on the specified language and category.
  ///
  /// - Parameters:
  ///   - language: The language of the sites to retrieve.
  ///   - category: The category of the sites to retrieve.
  /// - Returns: A list of sites matching the specified language and category.
  public func sites(
    withLanguage language: SiteLanguageType?,
    withCategory category: SiteCategoryType?
  ) -> [Site] {
    instance.sites(withLanguage: language, withCategory: category)
  }
}
