//
//  WordPressPost+ProcessedData.swift
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

#if swift(<5.7)
  @preconcurrency import Foundation
#elseif swift(<6.1)
  import Foundation
#else
  internal import Foundation
#endif

extension WordPressPost {
  /// A struct containing processed category and meta data for creating a WordPress post.
  public struct ProcessedData: Sendable {
    /// Dictionary of categories grouped by domain.
    public let categoryDictionary: [String: [RSSItemCategory]]

    /// Dictionary of meta data with key-value pairs.
    public let metaDictionary: [String: String]

    /// Initializes a ProcessedData instance with category and meta dictionaries.
    public init(
      categoryDictionary: [String: [RSSItemCategory]],
      metaDictionary: [String: String]
    ) {
      self.categoryDictionary = categoryDictionary
      self.metaDictionary = metaDictionary
    }
  }
}
