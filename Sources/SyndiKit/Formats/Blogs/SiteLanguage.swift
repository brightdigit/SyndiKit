//
//  SiteLanguage.swift
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
/// A struct representing a site language.
///
/// Use this struct to define the type and title of a site language.
///
/// - Note: This struct is used internally and should not be directly instantiated.
///
/// - Parameters:
///   - content: The content of the site language.
///
/// - SeeAlso: ``SiteLanguageType``
///
/// - Author: Your Name
/// - SeeAlso: ``EntryCategory``
public struct SiteLanguage: Sendable {
  /// The type of the site language.
  public let type: SiteLanguageType

  /// The title of the site language.
  public let title: String

  /// A struct representing an Atom category.
  ///   Initializes a new ``SiteLanguage`` instance.
  ///
  ///   - Parameters:
  ///     - content: The content of the site language.
  ///
  ///   - Returns: A new ``SiteLanguage`` instance.
  /// - SeeAlso: ``EntryCategory``
  internal init(content: SiteLanguageContent) {
    type = content.language
    title = content.title
  }
}
