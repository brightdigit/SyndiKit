public struct SiteLanguageCategory: Codable {
  public let title: String
  public let slug: String
  public let description: String
  public let sites: [Site]
}
