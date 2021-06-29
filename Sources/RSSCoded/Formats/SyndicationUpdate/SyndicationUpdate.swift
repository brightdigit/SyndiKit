import Foundation

public struct SyndicationUpdate: Codable, Equatable {
  public let period: SyndicationUpdatePeriod
  public let frequency: Int
  public let base: Date?

  public init?(period: SyndicationUpdatePeriod? = nil, frequency: Int? = nil, base: Date? = nil) {
    guard period != nil || frequency != nil else {
      return nil
    }
    self.period = period ?? .daily
    self.frequency = frequency ?? 1
    self.base = base
  }
}
