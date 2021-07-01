import Foundation

public struct BlogCollection {
  let allSites: [BlogSite]
  let languageDictionary: [LanguageType: Language]
  let categoryDictionary: [CategoryType: Category]
  let languageIndicies: [LanguageType: Set<Int>]
  let categoryIndicies: [CategoryType: Set<Int>]

  public func languages() -> Dictionary<LanguageType, Language>.Values {
    return languageDictionary.values
  }
  public func categories() -> Dictionary<CategoryType, Category>.Values {
    return categoryDictionary.values
  }
  public func sites(
    withLanguage language: LanguageType? = nil,
    withCategory category: CategoryType? = nil
  ) -> [BlogSite] {
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

  // swiftlint:disable function_body_length
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
        let category = CategoryLanguage(
          languageCategory: languageCategory,
          language: language.type
        )
        for site in languageCategory.sites {
          let index = sites.count
          let site = BlogSite(
            site: site,
            categoryType: category.type,
            languageType: language.type
          )
          sites.append(site)
          thisCategoryIndicies.append(index)
          thisLanguageIndicies.append(index)
        }
        categoryIndicies.formUnion(thisCategoryIndicies, key: category.type)
        categories.append(category)
      }
      languageIndicies.formUnion(thisLanguageIndicies, key: language.type)
      languages.append(language)
    }

    self.categoryDictionary = Dictionary(
      grouping: categories,
      by: { $0.type }
    ).compactMapValues(Category.init)
    self.languageDictionary = Dictionary(uniqueKeysWithValues: languages.map { ($0.type, $0) })
    self.languageIndicies = languageIndicies
    self.categoryIndicies = categoryIndicies
    allSites = sites
  }
}
