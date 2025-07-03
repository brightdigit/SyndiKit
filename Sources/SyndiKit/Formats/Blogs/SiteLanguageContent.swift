//
//  SiteLanguageContent.swift
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
/// A struct representing the content of a site in a specific language.
///
/// - Note: This struct conforms to the ``Codable`` protocol.
///
/// - Important: All properties of this struct are read-only.
///
/// - SeeAlso: ``SiteLanguageCategory``
///
/// - Author: Your Name
///
/// - Version: 1.0
/// - SeeAlso: ``EntryCategory``
public struct SiteLanguageContent: Codable, Sendable {
  /// The language of the site content.
  public let language: String

  /// The title of the site.
  public let title: String

  /// The categories of the site.
  public let categories: [SiteLanguageCategory]
}
