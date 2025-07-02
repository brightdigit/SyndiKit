//
//  RSSImage.swift
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
  public import Foundation
#endif

/// Represents a GIF, JPEG, or PNG image.
public struct RSSImage: Codable, Sendable {
  /// The URL of the image.
  public let url: URL

  /// The title or description of the image.
  ///
  /// This is used in the ``alt`` attribute of the HTML `<img>` tag
  /// when the channel is rendered in HTML.
  public let title: String

  /// The URL of the site that the image links to.
  ///
  /// In practice, the image ``title`` and ``link`` should have
  /// the same value as the channel's ``title`` and ``link``.
  public let link: URL

  /// The width of the image in pixels.
  public let width: Int?

  /// The height of the image in pixels.
  public let height: Int?

  /// Additional description of the image.
  ///
  /// This text is included in the ``title`` attribute of the link
  /// formed around the image in the HTML rendering.
  public let description: String?
}
