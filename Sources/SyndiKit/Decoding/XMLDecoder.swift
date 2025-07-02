//
//  XMLDecoder.swift
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
import XMLCoder

internal struct XMLDecoder: TypeDecoder {
  internal let getCoreOfficeXMLDecoder: @Sendable () -> XMLCoder.XMLDecoder

  internal init() {
    self.init {
      .init()
    }
  }

  internal init(
    _ getCoreOfficeXMLDecoder: @escaping @Sendable () -> XMLCoder.XMLDecoder
  ) {
    self.getCoreOfficeXMLDecoder = getCoreOfficeXMLDecoder
  }

  internal func decode<T>(
    _ type: T.Type,
    from data: Data
  ) throws -> T where T: DecodableFeed {
    try getCoreOfficeXMLDecoder().decode(type, from: data)
  }
}
