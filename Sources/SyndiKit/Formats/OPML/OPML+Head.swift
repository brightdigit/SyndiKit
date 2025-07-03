//
//  OPML+Head.swift
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

extension OPML {
  /// A struct representing the head section of an OPML document.
  /// The head contains metadata about the OPML document including title, dates,
  /// owner information, and window settings.
  public struct Head: Codable, Equatable, Sendable {
    public let title: String?
    public let dateCreated: String?
    public let dateModified: String?
    public let ownerName: String?
    public let ownerEmail: String?
    public let ownerId: String?
    public let docs: String?
    public let expansionStates: ListString<Int>?
    public let vertScrollState: Int?
    public let windowTop: Int?
    public let windowLeft: Int?
    public let windowBottom: Int?
    public let windowRight: Int?

    // swiftlint:disable:next nesting
    internal enum CodingKeys: String, CodingKey {
      case title
      case dateCreated
      case dateModified
      case ownerName
      case ownerEmail
      case ownerId
      case docs
      case expansionStates = "expansionState"
      case vertScrollState
      case windowTop
      case windowLeft
      case windowBottom
      case windowRight
    }
  }
}
