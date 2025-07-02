//
//  iTunesOwner.swift
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
  import Foundation
#elseif swift(<6.1)
  import Foundation
#else
  public import Foundation
#endif

// swift-format-ignore: TypeNamesShouldBeCapitalized
/// A struct representing an Atom category.
/// A struct representing the owner of an iTunes account.
///
/// - Note: This struct conforms to the ``Codable`` protocol.
///
/// - Warning: Do not modify the ``CodingKeys`` enum.
///
/// - SeeAlso: ``CodingKeys``
///
/// - Remark: The ``email`` property is optional.
///
/// - Important: The ``name`` property is required.
///
/// - Version: 1.0
/// - SeeAlso: ``EntryCategory``
public struct iTunesOwner: Codable, Sendable {
  /// The coding keys used to encode and decode the struct.
  internal enum CodingKeys: String, CodingKey {
    case name = "itunes:name"
    case email = "itunes:email"
  }

  /// The name of the iTunes owner.
  public let name: String

  /// The email address of the iTunes owner.
  public let email: String?
}
