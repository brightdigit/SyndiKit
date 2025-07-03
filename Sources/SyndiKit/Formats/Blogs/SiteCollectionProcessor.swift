//
//  SiteCollectionProcessor.swift
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

/// A utility struct for processing site collections.
///
/// This struct provides static methods for creating sites from language content.
///
/// - Note: This struct is used internally for processing site collections.
///
/// - SeeAlso: ``SiteLanguageContent``
/// - SeeAlso: ``SiteLanguage``
/// - SeeAlso: ``Site``
internal struct SiteCollectionProcessor: Sendable {
  /// Creates sites from language content.
  ///
  /// - Parameters:
  ///   - languageContent: The language content to create sites from.
  ///   - language: The language of the content.
  /// - Returns: An array of sites created from the language content.
  internal static func createSites(
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
