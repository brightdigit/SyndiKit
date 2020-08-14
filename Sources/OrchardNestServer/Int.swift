import Foundation

extension Int {
  var positionalTime: String {
    let (hours, hoursMod) = quotientAndRemainder(dividingBy: 3600)
    let (minutes, seconds) = hoursMod.quotientAndRemainder(dividingBy: 60)
    return [hours, minutes, seconds].filter { $0 > 0 }.map {
      String(format: "%02i", $0)
    }.joined(separator: ":")
  }
}
