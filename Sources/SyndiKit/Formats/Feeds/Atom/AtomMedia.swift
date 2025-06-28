//
//  AtomMedia.swift
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

#if swift(>=5.7)
  @preconcurrency import Foundation
#else
  import Foundation
#endif

/// A struct representing an Atom category.
/// Media structure which enables content publishers and bloggers
/// to syndicate multimedia content such as TV and video clips, movies, images and audio.
///
/// For more details, check out
/// [the Media RSS Specification](https://www.rssboard.org/media-rss).
/// - SeeAlso: ``EntryCategory``
public struct AtomMedia: Codable, Sendable {
  /// A struct representing an Atom category.
  ///   The type of object.
  ///
  ///   While this attribute can at times seem redundant if type is supplied,
  ///   it is included because it simplifies decision making on the reader side,
  ///   as well as flushes out any ambiguities between MIME type and object type.
  ///   It is an optional attribute.
  /// - SeeAlso: ``EntryCategory``
  public let url: URL

  /// The direct URL to the media object.
  public let medium: String?

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    url = try container.decode(UTF8EncodedURL.self, forKey: .url).value
    medium = try container.decodeIfPresent(String.self, forKey: .medium)
  }
}
