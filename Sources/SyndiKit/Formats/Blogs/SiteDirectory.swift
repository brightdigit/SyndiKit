import Foundation

public struct SiteCollectionDirectory: SiteDirectory {
  public typealias SiteSequence = [Site]

  public typealias LanguageSequence =
    Dictionary<SiteLanguageType, SiteLanguage>.Values

  public typealias CategorySequence =
    Dictionary<SiteCategoryType, SiteCategory>.Values

  private struct Instance {
    private let allSites: [Site]
    private let languageDictionary: [SiteLanguageType: SiteLanguage]
    private let categoryDictionary: [SiteCategoryType: SiteCategory]
    private let languageIndicies: [SiteLanguageType: Set<Int>]
    private let categoryIndicies: [SiteCategoryType: Set<Int>]

    private func sites(
      withLanguage language: SiteLanguageType?,
      withCategory category: SiteCategoryType?
    ) -> [Site] {
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
    private init(blogs: SiteCollection) {
      var categories = [CategoryLanguage]()
      var languages = [SiteLanguage]()
      var sites = [Site]()
      var languageIndicies = [SiteLanguageType: Set<Int>]()
      var categoryIndicies = [SiteCategoryType: Set<Int>]()

      for languageContent in blogs {
        let language = SiteLanguage(content: languageContent)
        var thisLanguageIndicies = [Int]()
        for languageCategory in languageContent.categories {
          var thisCategoryIndicies = [Int]()
          let category = CategoryLanguage(
            languageCategory: languageCategory,
            language: language.type
          )
          for site in languageCategory.sites {
            let index = sites.count
            let site = Site(
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

      categoryDictionary = Dictionary(grouping: categories) { $0.type }
        .compactMapValues(SiteCategory.init)
      languageDictionary = Dictionary(
        uniqueKeysWithValues: languages.map { ($0.type, $0) }
      )
      self.languageIndicies = languageIndicies
      self.categoryIndicies = categoryIndicies
      allSites = sites
    }
  }

  private let instance: Instance

  public var languages: Dictionary<
    SiteLanguageType, SiteLanguage
  >.Values {
    instance.languageDictionary.values
  }

  public var categories: Dictionary<
    SiteCategoryType, SiteCategory
  >.Values {
    instance.categoryDictionary.values
  }

  internal init(blogs: SiteCollection) {
    instance = .init(blogs: blogs)
  }

  public func sites(
    withLanguage language: SiteLanguageType?,
    withCategory category: SiteCategoryType?
  ) -> [Site] {
    instance.sites(withLanguage: language, withCategory: category)
  }
}

public protocol SiteDirectory {
  associatedtype SiteSequence: Sequence
    where SiteSequence.Element == Site
  associatedtype LanguageSequence: Sequence
    where LanguageSequence.Element == SiteLanguage
  associatedtype CategorySequence: Sequence
    where CategorySequence.Element == SiteCategory

  var languages: LanguageSequence { get }
  var categories: CategorySequence { get }

  func sites(
    withLanguage language: SiteLanguageType?,
    withCategory category: SiteCategoryType?
  ) -> SiteSequence
}

extension SiteDirectory {
  public func sites(
    withLanguage language: SiteLanguageType? = nil,
    withCategory category: SiteCategoryType? = nil
  ) -> SiteSequence {
    sites(withLanguage: language, withCategory: category)
  }
}
