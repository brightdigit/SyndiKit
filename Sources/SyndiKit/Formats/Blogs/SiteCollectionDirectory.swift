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

    // swiftlint:disable:next function_body_length
    internal func sites(
      withLanguage language: SiteLanguageType?,
      withCategory category: SiteCategoryType?
    ) -> [Site] {
      let languageIndices: Set<Int>?
      if let language = language {
        languageIndices = self.languageIndices[language] ?? .init()
      } else {
        languageIndices = nil
      }

      let categoryIndices: Set<Int>?
      if let category = category {
        categoryIndices = self.categoryIndices[category] ?? .init()
      } else {
        categoryIndices = nil
      }

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

      if let current = indices {
        return current.map { self.allSites[$0] }
      } else {
        return allSites
      }
    }

    internal init(blogs: SiteCollection) {
      let result = Self.processBlogs(blogs)
      self.languageDictionary = Dictionary(
        uniqueKeysWithValues: result.languages.map { ($0.type, $0) }
      )
      self.categoryDictionary = Dictionary(grouping: result.categories) { $0.type }
        .compactMapValues(SiteCategory.init)
      self.languageIndices = result.languageIndices
      self.categoryIndices = result.categoryIndices
      allSites = result.sites
    }

    private struct ProcessedBlogsResult {
      let categories: [CategoryLanguage]
      let languages: [SiteLanguage]
      let sites: [Site]
      let languageIndices: [SiteLanguageType: Set<Int>]
      let categoryIndices: [SiteCategoryType: Set<Int>]
    }

    private struct LanguageContentResult {
      let language: SiteLanguage
      let languageIndices: [Int]
      let categories: [CategoryLanguage]
      let categoryIndices: [SiteCategoryType: [Int]]
    }

    private static func processBlogs(_ blogs: SiteCollection) -> ProcessedBlogsResult {
      var categories = [CategoryLanguage]()
      var languages = [SiteLanguage]()
      var sites = [Site]()
      var languageIndices = [SiteLanguageType: Set<Int>]()
      var categoryIndices = [SiteCategoryType: Set<Int>]()

      for languageContent in blogs {
        let languageResult = Self.processLanguageContent(
          languageContent,
          sitesCount: sites.count
        )
        sites.append(
          contentsOf: Self.createSites(from: languageContent, language: languageResult.language))
        languageIndices.formUnion(languageResult.languageIndices, key: languageResult.language.type)
        for (categoryType, indices) in languageResult.categoryIndices {
          categoryIndices.formUnion(indices, key: categoryType)
        }
        languages.append(languageResult.language)
        categories.append(contentsOf: languageResult.categories)
      }
      return ProcessedBlogsResult(
        categories: categories,
        languages: languages,
        sites: sites,
        languageIndices: languageIndices,
        categoryIndices: categoryIndices
      )
    }

    private static func processLanguageContent(
      _ languageContent: SiteLanguageContent,
      sitesCount: Int
    ) -> LanguageContentResult {
      let language = SiteLanguage(content: languageContent)
      var thisLanguageIndices = [Int]()
      var thisCategories = [CategoryLanguage]()
      var thisCategoryIndices = [SiteCategoryType: [Int]]()

      for languageCategory in languageContent.categories {
        let category = CategoryLanguage(
          languageCategory: languageCategory,
          language: language.type
        )
        let categorySiteIndices = (0..<languageCategory.sites.count).map { sitesCount + $0 }
        thisCategoryIndices[category.type] = categorySiteIndices
        thisLanguageIndices.append(contentsOf: categorySiteIndices)
        thisCategories.append(category)
      }
      return LanguageContentResult(
        language: language,
        languageIndices: thisLanguageIndices,
        categories: thisCategories,
        categoryIndices: thisCategoryIndices
      )
    }

    private static func createSites(
      from languageContent: SiteLanguageContent,
      language: SiteLanguage
    ) -> [Site] {
      var sites = [Site]()
      for languageCategory in languageContent.categories {
        let category = CategoryLanguage(
          languageCategory: languageCategory,
          language: language.type
        )
        for site in languageCategory.sites {
          let site = Site(
            site: site,
            categoryType: category.type,
            languageType: language.type
          )
          sites.append(site)
        }
      }
      return sites
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
