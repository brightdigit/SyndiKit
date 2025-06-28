//
//  AtomMediaGroup.swift
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

import Foundation

/// A group of media elements in an Atom feed.
public struct AtomMediaGroup: Codable, Sendable {
  /// Coding keys for encoding and decoding.
  public enum CodingKeys: String, CodingKey {
    case title = "media:title"
    case descriptions = "media:description"
    case contents = "media:content"
    case thumbnails = "media:thumbnail"
  }

  /// The title of the media group.
  public let title: String?

  /// The media elements within the group.
  public let contents: [AtomMedia]

  /// The thumbnail images associated with the media group.
  public let thumbnails: [AtomMedia]

  /// The descriptions of the media group.
  public let descriptions: [String]
}
