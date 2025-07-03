//
//  SiteCategory.swift
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
/// A struct representing a site category.
///
/// - Note: This struct is used to categorize sites based on their type and descriptors.
///
/// - Parameters:
///   - type: The type of the site category.
///   - descriptors: A dictionary mapping site language types to category descriptors.
///
/// - Important: This struct should not be used directly.
/// Instead, use the ``SiteCategoryBuilder`` to create instances of ``SiteCategory``.
///
/// - SeeAlso: ``SiteCategoryType``
/// - SeeAlso: ``CategoryDescriptor``
/// - SeeAlso: ``CategoryLanguage``
/// - SeeAlso: ``SiteCategoryBuilder``
/// - SeeAlso: ``EntryCategory``
public struct SiteCategory: Sendable {
  /// The type of the site category.
  public let type: SiteCategoryType

  /// A dictionary mapping site language types to category descriptors.
  public let descriptors: [SiteLanguageType: CategoryDescriptor]

  /// A struct representing an Atom category.
  ///   Initializes a ``SiteCategory`` instance with the given languages.
  ///
  ///   - Parameter languages: An array of ``CategoryLanguage`` instances.
  ///
  ///   - Returns: A new ``SiteCategory`` instance
  ///   if at least one language is provided, ``nil`` otherwise.
  /// - SeeAlso: ``EntryCategory``
  internal init?(languages: [CategoryLanguage]) {
    guard let type = languages.first?.type else {
      return nil
    }
    self.type = type
    descriptors = Dictionary(grouping: languages) { $0.language }
      .compactMapValues { $0.first?.descriptor }
  }
}
