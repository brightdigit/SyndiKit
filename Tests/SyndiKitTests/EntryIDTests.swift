//
//  EntryIDTests.swift
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

import SyndiKit
import Testing

#if swift(<6.0)
  import Foundation
#else
  internal import Foundation
#endif

@Suite("Entry ID Tests")
internal struct EntryIDTests {
  /// Builds every case of ``EntryID`` so each branch of
  /// `init(string:)`, `description`, and Codable round-trips is exercised.
  private static let samples: [(string: String, entryID: EntryID)] = {
    let urlString = "https://example.com/post/1"
    let uuidString = "e621e1f8-c36c-495a-93fc-0c247a3e6e5f"
    var entries: [(string: String, entryID: EntryID)] = []
    if let url = URL(string: urlString) {
      entries.append((urlString, .url(url)))
    }
    if let uuid = UUID(uuidString: uuidString) {
      entries.append((uuidString, .uuid(uuid)))
    }
    entries.append(("yt:video:abc123", .path(["yt", "video", "abc123"], separatedBy: ":")))
    entries.append(("alpha/beta/gamma", .path(["alpha", "beta", "gamma"], separatedBy: "/")))
    entries.append(("plainstring", .string("plainstring")))
    return entries
  }()

  @Test("init(string:) selects the expected case for every input")
  internal func initStringBranches() {
    for sample in Self.samples {
      #expect(EntryID(string: sample.string) == sample.entryID)
    }
  }

  @Test("init?(_:) never returns nil and matches init(string:)")
  internal func optionalInit() {
    for sample in Self.samples {
      #expect(EntryID(sample.string) == sample.entryID)
    }
  }

  @Test("description round-trips back to the original string for every case")
  internal func descriptionForEachCase() {
    for sample in Self.samples {
      #expect(sample.entryID.description == sample.string)
    }
  }

  @Test("Codable round-trips every case through JSON")
  internal func codableRoundTrip() throws {
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    for sample in Self.samples {
      let data = try encoder.encode(sample.entryID)
      let decoded = try decoder.decode(EntryID.self, from: data)
      #expect(decoded == sample.entryID)
    }
  }
}
