//
//  PodcastTranscript+MimeType.swift
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

extension PodcastTranscript {
  /// A private enum representing known MIME types for the transcript.
  private enum KnownMimeType: String, Codable, Sendable {
    case plain = "text/plain"
    case html = "text/html"
    case srt = "text/srt"
    case vtt = "text/vtt"
    case json = "application/json"
    case subrip = "application/x-subrip"

    /// Initializes a ``KnownMimeType`` with a case-insensitive string.
    init?(caseInsensitive: String) {
      self.init(rawValue: caseInsensitive)
    }

    /// Initializes a ``KnownMimeType`` with a ``MimeType``.
    init?(mimeType: MimeType) {
      switch mimeType {
      case .plain: self = .plain
      case .html: self = .html
      case .srt: self = .srt
      case .vtt: self = .vtt
      case .json: self = .json
      case .subrip: self = .subrip
      case .unknown: return nil
      }
    }
  }

  /// An enum representing the MIME type of the transcript.
  public enum MimeType: Codable, Equatable, RawRepresentable, Sendable {
    case plain
    case html
    case srt
    case vtt
    case json
    case subrip
    case unknown(String)

    /// The raw value of the MIME type.
    public var rawValue: String {
      if let knownMimeType = KnownMimeType(mimeType: self) {
        return knownMimeType.rawValue
      } else if case let .unknown(string) = self {
        return string
      } else {
        fatalError(
          // swiftlint:disable:next line_length
          "Type attribute of <podcast:transcript> with value: \(self) should either be a ``KnownMimeType``, or unknown!"
        )
      }
    }

    /// Initializes a ``MimeType`` with a raw value.
    public init?(rawValue: String) {
      self.init(caseInsensitive: rawValue)
    }

    /// Initializes a ``MimeType`` with a case-insensitive string.
    public init(caseInsensitive: String) {
      if let knownMimeType = KnownMimeType(caseInsensitive: caseInsensitive) {
        self = .init(knownMimeType: knownMimeType)
      } else {
        self = .unknown(caseInsensitive)
      }
    }

    /// Initializes a ``MimeType`` with a ``KnownMimeType``.
    private init(knownMimeType: KnownMimeType) {
      switch knownMimeType {
      case .plain: self = .plain
      case .html: self = .html
      case .srt: self = .srt
      case .vtt: self = .vtt
      case .json: self = .json
      case .subrip: self = .subrip
      }
    }
  }
}
