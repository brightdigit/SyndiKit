import Foundation

extension TimeInterval {
  static let second = 1.0
  static let minute = 60 * TimeInterval.second
  static let hour = 60 * TimeInterval.minute
  static let day = 24 * TimeInterval.hour
  static let week = 7 * TimeInterval.day
  static let month = 30 * TimeInterval.day
  static let year = 365.25 * TimeInterval.day
}

extension TimeInterval {
  // swiftlint:disable:next cyclomatic_complexity
  init(iso8601: String) throws {
    let value = iso8601
    guard value.hasPrefix("P") else {
      throw Errors.notBeginWithP
    }
    // originalValue = value
    var timeInterval: TimeInterval = 0
    var numberValue: String = ""
    let numbers = Set("0123456789.,")
    var isTimePart = false

    var dateComponents = DateComponents(
      calendar: Calendar.current,
      timeZone: TimeZone.current,
      era: nil, year: 0, month: 0, day: 0, hour: 0, minute: 0, second: 0, nanosecond: nil,
      weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil
    )

    func addTimeInterval(base: Component) {
      guard let value = Double(numberValue.replacingOccurrences(of: ",", with: ".")) else {
        numberValue = ""
        return
      }
      timeInterval += value * base.timeInterval()
      numberValue = ""

      let components = base.value(duration: value)
      for component in components {
        var currentValue = dateComponents.value(for: component.component) ?? 0
        currentValue += component.duration
        dateComponents.setValue(currentValue, for: component.component)
      }
    }

    for char in value {
      switch char {
      case "P":
        continue
      case "T":
        isTimePart = true
      case _ where numbers.contains(char):
        numberValue.append(char)
      case "D":
        addTimeInterval(base: .day)
      case "Y":
        addTimeInterval(base: .year)
      case "M":
        if isTimePart {
          addTimeInterval(base: .minute)
        } else {
          addTimeInterval(base: .month)
        }
      case "W":
        addTimeInterval(base: .week)
      case "H":
        if isTimePart {
          addTimeInterval(base: .hour)
        } else {
          throw Errors.timePartNotBeginWithT
        }
      case "S":
        if isTimePart {
          addTimeInterval(base: .second)
        } else {
          throw Errors.timePartNotBeginWithT
        }
      default:
        throw Errors.unknownElement
      }
    }
    if numberValue.count > 0 {
      throw Errors.discontinuous
    }
    self = timeInterval
  }
}
