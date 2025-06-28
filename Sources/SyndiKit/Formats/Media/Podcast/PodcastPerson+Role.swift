//
//  PodcastPerson+Role.swift
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

extension PodcastPerson {
  /// A private enum representing known roles for a podcast person.
  private enum KnownRole: String, Codable, Sendable {
    case guest
    case host
    case editor
    case writer
    case designer
    case composer
    case producer

    /// Initializes a ``KnownRole`` with a case-insensitive string.
    init?(caseInsensitive: String) {
      self.init(rawValue: caseInsensitive.lowercased())
    }

    /// Initializes a ``KnownRole`` with a ``Role`` value.
    init?(role: Role) {
      switch role {
      case .guest:
        self = .guest

      case .host:
        self = .host

      case .editor:
        self = .editor

      case .writer:
        self = .writer

      case .designer:
        self = .designer

      case .composer:
        self = .composer

      case .producer:
        self = .producer

      case .unknown:
        return nil
      }
    }
  }

  /// An enum representing the role of a podcast person.
  public enum Role: Codable, Equatable, RawRepresentable, Sendable {
    case guest
    case host
    case editor
    case writer
    case designer
    case composer
    case producer
    case unknown(String)

    /// The raw value of the role.
    public var rawValue: String {
      if let knownRole = KnownRole(role: self) {
        return knownRole.rawValue
      } else if case let .unknown(string) = self {
        return string
      } else {
        fatalError(
          // swiftlint:disable:next line_length
          "Role attribute of <podcast:person> with value: \(self) should either be a ``KnownRole``, or unknown!"
        )
      }
    }

    /// Initializes a ``Role`` with a raw value.
    public init?(rawValue: String) {
      self.init(caseInsensitive: rawValue)
    }

    /// Initializes a ``Role`` with a case-insensitive string.
    public init(caseInsensitive: String) {
      if let knownRole = KnownRole(caseInsensitive: caseInsensitive) {
        self = .init(knownRole: knownRole)
      } else {
        self = .unknown(caseInsensitive)
      }
    }

    // swiftlint:disable:next cyclomatic_complexity
    private init(knownRole: KnownRole) {
      switch knownRole {
      case .guest: self = .guest
      case .host: self = .host
      case .editor: self = .editor
      case .writer: self = .writer
      case .designer: self = .designer
      case .composer: self = .composer
      case .producer: self = .producer
      }
    }
  }
}
