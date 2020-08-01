import OrchardNestKit

struct SiteCatalogMap {
  let languages: [String: String]
  let categories: [String: [String: String]]
  let organizedSites: [OrganizedSite]

  init(sites: [LanguageContent]) {
    var languages = [String: String]()
    var categories = [String: [String: String]]()
    var organizedSites = [OrganizedSite]()

    for lang in sites {
      languages[lang.language] = lang.title
      for category in lang.categories {
        var categoryMap = categories[category.slug] ?? [String: String]()
        categoryMap[lang.language] = category.title
        categories[category.slug] = categoryMap
        organizedSites.append(contentsOf: category.sites.map {
          OrganizedSite(languageCode: lang.language, categorySlug: category.slug, site: $0)
        })
      }
    }

    self.categories = categories
    self.languages = languages
    self.organizedSites = organizedSites
  }
}
