import Foundation

struct SyndicationUpdate: Codable, Equatable {
  let period: SyndicationUpdatePeriod
  let frequency: Int
  let base: Date?

  init?(period: SyndicationUpdatePeriod? = nil, frequency: Int? = nil, base: Date? = nil) {
    guard period != nil || frequency != nil else {
      return nil
    }
    self.period = period ?? .daily
    self.frequency = frequency ?? 1
    self.base = base
  }
}
