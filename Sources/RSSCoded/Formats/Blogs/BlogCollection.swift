import Foundation

public struct BlogCollection {
  let allSites: [BlogSite]
  let languages: [LanguageType: Language]
  let categories: [CategoryType: Category]
  let languageIndicies: [LanguageType: Set<Int>]
  let categoryIndicies: [CategoryType: Set<Int>]

  public func sites(withLanguage language: LanguageType? = nil, withCategory category: CategoryType? = nil) -> [BlogSite] {
    let languageIndicies: Set<Int>?
    if let language = language {
      languageIndicies = self.languageIndicies[language] ?? .init()
    } else {
      languageIndicies = nil
    }

    let categoryIndicies: Set<Int>?
    if let category = category {
      categoryIndicies = self.categoryIndicies[category] ?? .init()
    } else {
      categoryIndicies = nil
    }

    var indicies: Set<Int>?

    if let languageIndicies = languageIndicies {
      indicies = languageIndicies
    }

    if let categoryIndicies = categoryIndicies {
      if let current = indicies {
        indicies = current.intersection(categoryIndicies)
      } else {
        indicies = categoryIndicies
      }
    }

    if let current = indicies {
      return current.map { self.allSites[$0] }
    } else {
      return allSites
    }
  }

  public init(blogs: BlogArray) {
    var categories = [CategoryLanguage]()
    var languages = [Language]()
    var sites = [BlogSite]()
    var languageIndicies = [LanguageType: Set<Int>]()
    var categoryIndicies = [CategoryType: Set<Int>]()

    for languageContent in blogs {
      let language = Language(content: languageContent)
      var thisLanguageIndicies = [Int]()
      for languageCategory in languageContent.categories {
        var thisCategoryIndicies = [Int]()
        let category = CategoryLanguage(languageCategory: languageCategory, language: language.type)
        for site in languageCategory.sites {
          let index = sites.count
          sites.append(BlogSite(site: site, categoryType: category.type, languageType: language.type))
          thisCategoryIndicies.append(index)
          thisLanguageIndicies.append(index)
        }
        categoryIndicies.formUnion(thisCategoryIndicies, key: category.type)
        categories.append(category)
      }
      languageIndicies.formUnion(thisLanguageIndicies, key: language.type)
      languages.append(language)
    }

    self.categories = Dictionary(grouping: categories, by: { $0.type }).mapValues(Category.init)
    self.languages = Dictionary(uniqueKeysWithValues: languages.map { ($0.type, $0) })
    self.languageIndicies = languageIndicies
    self.categoryIndicies = categoryIndicies
    allSites = sites
  }
}
