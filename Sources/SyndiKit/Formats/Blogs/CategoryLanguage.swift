//
//  CategoryLanguage.swift
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

/// A struct representing an Atom category.
/// A struct representing a category in a specific language.
///
/// - Parameters:
///   - languageCategory: The category in a specific language.
///   - language: The language of the category.
///
/// - Note: This struct is used internally.
///
/// - SeeAlso: ``SiteCategoryType``
/// - SeeAlso: ``CategoryDescriptor``
/// - SeeAlso: ``SiteLanguageType``
/// - SeeAlso: ``EntryCategory``
public struct CategoryLanguage: Sendable {
  /// The type of the category.
  public let type: SiteCategoryType

  /// The descriptor of the category.
  public let descriptor: CategoryDescriptor

  /// The language of the category.
  public let language: SiteLanguageType

  /// A struct representing an Atom category.
  ///   Initializes a ``CategoryLanguage`` instance.
  ///
  ///   - Parameters:
  ///     - languageCategory: The category in a specific language.
  ///     - language: The language of the category.
  /// - SeeAlso: ``EntryCategory``
  internal init(languageCategory: SiteLanguageCategory, language: SiteLanguageType) {
    type = languageCategory.slug
    descriptor = CategoryDescriptor(
      title: languageCategory.title,
      description: languageCategory.description
    )
    self.language = language
  }
}
