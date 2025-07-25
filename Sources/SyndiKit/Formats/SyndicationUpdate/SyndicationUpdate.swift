//
//  SyndicationUpdate.swift
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

/// Properties concerning how often it is updated a feed is updated.
///
/// These properties come from
///  [
///  the RDF Site Summary Syndication Module
///  ](
///  https://web.resource.org/rss/1.0/modules/syndication/
///  ).
public struct SyndicationUpdate: Codable, Equatable, Sendable {
  /// Describes the period over which the channel format is updated.
  /// The default value is ``SyndicationUpdatePeriod/daily``.
  public let period: SyndicationUpdatePeriod

  /// Used to describe the frequency of updates in relation to the update period.
  /// The default value is 1.
  ///
  /// A positive integer indicates how many times in that period the channel is updated.
  /// For example, an updatePeriod of daily, and an updateFrequency of 2
  /// indicates the channel format is updated twice daily.
  public let frequency: Int

  /// Defines a base date
  /// to be used in concert with
  /// ``SyndicationUpdate/period``  and ``SyndicationUpdate/frequency``
  ///  to calculate the publishing schedule.
  public let base: Date?

  internal init?(
    period: SyndicationUpdatePeriod? = nil,
    frequency: Int? = nil,
    base: Date? = nil
  ) {
    guard period != nil || frequency != nil else {
      return nil
    }
    self.period = period ?? .daily
    self.frequency = frequency ?? 1
    self.base = base
  }
}
