// import Foundation
//
// enum Component {
//  case second
//  case minute
//  case hour
//  case day
//  case week
//  case month
//  case year
//
//  func timeInterval() -> TimeInterval {
//    switch self {
//    case .second:
//      return .second
//    case .minute:
//      return .minute
//    case .hour:
//      return .hour
//    case .day:
//      return .day
//    case .week:
//      return .week
//    case .month:
//      return .month
//    case .year:
//      return .year
//    }
//  }
//
//  func stepDown() -> (duration: Int, component: Component) {
//    switch self {
//    case .year:
//      return (duration: 12, component: .month)
//    case .month:
//      return (duration: 30, component: .day)
//    case .week:
//      return (duration: 7, component: .day)
//    case .day:
//      return (duration: 24, component: .hour)
//    case .hour:
//      return (duration: 60, component: .minute)
//    case .minute:
//      return (duration: 60, component: .second)
//    case .second:
//      return (duration: 1, component: .second)
//    }
//  }
//
//  func toCalendarComponent() -> Calendar.Component {
//    switch self {
//    case .year:
//      return .year
//    case .month:
//      return .month
//    case .week:
//      return .day
//    case .day:
//      return .day
//    case .hour:
//      return .hour
//    case .minute:
//      return .minute
//    case .second:
//      return .second
//    }
//  }
//
//  func value(duration: Double) -> [ComponentDuration] {
//    var correctedDuration = duration
//    if self == .week {
//      correctedDuration *= 7
//    }
//    let intValue = Int(correctedDuration.rounded(.down))
//    var output: [ComponentDuration] = []
//
//    output.append(ComponentDuration(duration: intValue, component: toCalendarComponent()))
//    let remainedDuration = duration - Double(intValue)
//    if remainedDuration > 0.0001 {
//      let step = stepDown()
//      let recalculatedRemainedDuration = Double(step.duration) * remainedDuration
//      let intRecalculatedRemainedDuration = Int(recalculatedRemainedDuration.rounded(.down))
//      output.append(ComponentDuration(duration: intRecalculatedRemainedDuration, component: step.component.toCalendarComponent()))
//    }
//    return output
//  }
// }
