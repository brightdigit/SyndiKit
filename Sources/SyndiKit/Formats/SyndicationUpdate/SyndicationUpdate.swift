#if swift(>=5.7)
@preconcurrency import Foundation
#else
import Foundation
#endif

// swiftlint:disable line_length
/// Properties concerning how often it is updated a feed is updated.
///
/// These properties come from
///  [the RDF Site Summary Syndication Module](https://web.resource.org/rss/1.0/modules/syndication/).
public struct SyndicationUpdate: Codable, Equatable, Sendable {
  // swiftlint:enable line_length

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
