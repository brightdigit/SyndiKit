import OrchardNestKit

public extension EntryCategoryType {
  var elClass: String {
    switch self {
    case .companies:
      return "website"
    case .design:
      return "brush"
    case .development:
      return "cogs"
    case .marketing:
      return "bullhorn"
    case .newsletters:
      return "envelope"
    case .podcasts:
      return "podcast"
    case .updates:
      return "file-new"
    case .youtube:
      return "video"
    }
  }
}
