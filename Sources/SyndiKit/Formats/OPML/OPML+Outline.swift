//
//  OPML+Outline.swift
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

extension OPML {
  public struct Outline: Codable, Equatable, Sendable {
    public enum CodingKeys: String, CodingKey {
      case text
      case title
      case description
      case type
      case url
      case htmlUrl
      case xmlUrl
      case language
      case created
      case categories = "category"
      case isComment
      case isBreakpoint
      case version

      case outlines = "outline"
    }

    public let text: String
    public let title: String?
    public let description: String?
    public let type: OutlineType?
    public let url: URL?
    public let htmlUrl: URL?
    public let xmlUrl: URL?
    public let language: String?
    public let created: String?
    public let categories: ListString<String>?
    // swiftlint:disable:next discouraged_optional_boolean
    public let isComment: Bool?
    // swiftlint:disable:next discouraged_optional_boolean
    public let isBreakpoint: Bool?
    public let version: String?

    public let outlines: [Outline]?
  }
}
