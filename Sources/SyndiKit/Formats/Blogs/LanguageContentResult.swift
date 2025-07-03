//
//  LanguageContentResult.swift
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

#if swift(<6.1)
  import Foundation
#else
  internal import Foundation
#endif

/// A struct representing the result of processing language content.
///
/// This struct contains the processed data for a specific language content,
/// including the language, indices, categories, and category indices.
///
/// - Note: This struct is used internally for processing site collections.
///
/// - SeeAlso: ``SiteLanguageContent``
/// - SeeAlso: ``SiteLanguage``
/// - SeeAlso: ``CategoryLanguage``
internal struct LanguageContentResult: Sendable {
  /// The language of the content.
  internal let language: SiteLanguage

  /// The indices of sites in this language.
  internal let languageIndices: [Int]

  /// The categories in this language.
  internal let categories: [CategoryLanguage]

  /// A mapping of category types to arrays of site indices.
  internal let categoryIndices: [SiteCategoryType: [Int]]

  /// Processes language content and returns a language content result.
  ///
  /// - Parameters:
  ///   - languageContent: The language content to process.
  ///   - sitesCount: The current count of sites (for index calculation).
  /// - Returns: A language content result containing the processed data.
  internal static func process(
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
}
