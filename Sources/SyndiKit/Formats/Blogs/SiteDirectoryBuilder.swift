//
//  SiteDirectoryBuilder.swift
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

/// A builder for creating a site collection directory.
public struct SiteCollectionDirectoryBuilder: SiteDirectoryBuilder, Sendable {
  /// Initializes a new instance of ``SiteCollectionDirectoryBuilder``.
  public init() {}

  /// A struct representing an Atom category.
  ///   Creates a site collection directory from a site collection.
  ///
  ///   - Parameter blogs: The site collection to build the directory from.
  ///
  ///   - Returns: A new instance of ``SiteCollectionDirectory``.
  /// - SeeAlso: ``EntryCategory``
  public func directory(fromCollection blogs: SiteCollection) -> SiteCollectionDirectory {
    SiteCollectionDirectory(blogs: blogs)
  }
}

/// A protocol for building site directories.
public protocol SiteDirectoryBuilder: Sendable {
  /// The type of site directory to build.
  associatedtype SiteDirectoryType: SiteDirectory

  /// A struct representing an Atom category.
  ///   Creates a site directory from a site collection.
  ///
  ///   - Parameter blogs: The site collection to build the directory from.
  ///
  ///   - Returns: A new instance of ``SiteDirectoryType``.
  /// - SeeAlso: ``EntryCategory``
  func directory(fromCollection blogs: SiteCollection) -> SiteDirectoryType
}
