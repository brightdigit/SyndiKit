//
//  ProcessedBlogsResult.swift
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

/// A struct representing the result of processing a site collection.
///
/// This struct contains all the processed data from a site collection,
/// including categories, languages, sites, and their corresponding indices.
///
/// - Note: This struct is used internally for processing site collections.
///
/// - SeeAlso: ``SiteCollection``
/// - SeeAlso: ``CategoryLanguage``
/// - SeeAlso: ``SiteLanguage``
/// - SeeAlso: ``Site``
internal struct ProcessedBlogsResult: Sendable {
  /// The categories found in the site collection.
  let categories: [CategoryLanguage]

  /// The languages found in the site collection.
  let languages: [SiteLanguage]

  /// The sites found in the site collection.
  let sites: [Site]

  /// A mapping of language types to sets of site indices.
  let languageIndices: [SiteLanguageType: Set<Int>]

  /// A mapping of category types to sets of site indices.
  let categoryIndices: [SiteCategoryType: Set<Int>]

  /// Creates a processed blogs result from a site collection.
  ///
  /// - Parameter blogs: The site collection to process.
  /// - Returns: A processed blogs result containing all the extracted data.
  internal static func process(_ blogs: SiteCollection) -> ProcessedBlogsResult {
    var categories = [CategoryLanguage]()
    var languages = [SiteLanguage]()
    var sites = [Site]()
    var languageIndices = [SiteLanguageType: Set<Int>]()
    var categoryIndices = [SiteCategoryType: Set<Int>]()

    for languageContent in blogs {
      let languageResult = LanguageContentResult.process(
        languageContent,
        sitesCount: sites.count
      )
      sites.append(
        contentsOf: SiteCollectionProcessor.createSites(from: languageContent, language: languageResult.language))
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
}
