import Foundation

public typealias LanguageType = String

public typealias CategoryType = String

public struct Language {
  init(content: LanguageContent) {
    type = content.language
    title = content.title
  }

  public let type: LanguageType
  public let title: String
}

public struct CategoryDescriptor {
  public let title: String
  public let description: String
}

public struct CategoryLanguage {
  internal init(languageCategory: LanguageCategory, language: LanguageType) {
    type = languageCategory.slug
    descriptor = CategoryDescriptor(title: languageCategory.title, description: languageCategory.description)
    self.language = language
  }

  public let type: CategoryType
  public let descriptor: CategoryDescriptor
  public let language: LanguageType
}

public struct Category {
  internal init(languages: [CategoryLanguage]) {
    type = languages.first!.type
    descriptors = Dictionary(grouping: languages, by: { $0.language }).mapValues { $0.first!.descriptor }
  }

  public let type: CategoryType
  public let descriptors: [LanguageType: CategoryDescriptor]
}

public struct BlogSite {
  internal init(site: Site, categoryType: CategoryType, languageType: LanguageType) {
    title = site.title
    author = site.author
    siteURL = site.siteURL
    feedURL = site.feedURL
    twitterURL = site.twitterURL
    category = categoryType
    language = languageType
  }

  public let title: String
  public let author: String
  public let siteURL: URL
  public let feedURL: URL
  public let twitterURL: URL?
  public let category: CategoryType
  public let language: LanguageType
}

extension Dictionary {
  mutating func formUnion<SequenceType: Sequence, ElementType>(_ collection: SequenceType, key: Key) where Value == Set<ElementType>, SequenceType.Element == ElementType {
    if let set = self[key] {
      self[key] = set.union(collection)
    } else {
      self[key] = Set(collection)
    }
  }
}

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

  init(blogs: BlogArray) {
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
