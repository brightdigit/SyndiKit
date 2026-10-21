//
//  iTunesReviewProperties.swift
//  SyndiKit
//
//  Created by Leo Dion.
//  Copyright © 2026 BrightDigit.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#if swift(<6.0)
  import Foundation
#else
  internal import Foundation
#endif

// Intentional Apple iTunes branding; lowercase "i" prefix is required.
// swiftlint:disable type_name
// swift-format-ignore: TypeNamesShouldBeCapitalized
/// The `im:` properties of an App Store customer review
/// (`xmlns:im="http://itunes.apple.com/rss"`) on an ``AtomEntry``.
///
/// Returns `nil` for entries without an `im:rating`, such as the app-metadata
/// entry that may lead the first page of a review feed.
public struct iTunesReviewProperties: Sendable {
  /// The star rating, 1 to 5.
  public let rating: Int

  /// The app version the review was written for.
  public let version: String?

  /// The sum of helpful votes.
  public let voteSum: Int?

  /// The number of votes.
  public let voteCount: Int?

  /// Creates the review properties of an entry.
  /// - Parameter entry: The Atom entry to read from.
  public init?(entry: AtomEntry) {
    guard let rating = entry.itunesRating?.value else {
      return nil
    }
    self.rating = rating
    self.version = entry.itunesVersion
    self.voteSum = entry.itunesVoteSum?.value
    self.voteCount = entry.itunesVoteCount?.value
  }
}
// swiftlint:enable type_name
