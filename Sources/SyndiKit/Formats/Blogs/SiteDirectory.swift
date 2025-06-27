import Foundation

/// A directory of site collections.
public struct SiteCollectionDirectory: SiteDirectory, Sendable {
  /// A sequence of sites.
  public typealias SiteSequence = [Site]

  /// A sequence of languages.
  public typealias LanguageSequence = Dictionary<SiteLanguageType, SiteLanguage>.Values

  /// A sequence of categories.
  public typealias CategorySequence = Dictionary<SiteCategoryType, SiteCategory>.Values

  /// The internal structure of the site collection directory.
  internal struct Instance: Sendable {
    internal let allSites: [Site]
    internal let languageDictionary: [SiteLanguageType: SiteLanguage]
    internal let categoryDictionary: [SiteCategoryType: SiteCategory]
    internal let languageIndices: [SiteLanguageType: Set<Int>]
    internal let categoryIndices: [SiteCategoryType: Set<Int>]

    // swiftlint:disable:next function_body_length
    internal func sites(
      withLanguage language: SiteLanguageType?,
      withCategory category: SiteCategoryType?
    ) -> [Site] {
      let languageIndices: Set<Int>?
      if let language = language {
        languageIndices = self.languageIndices[language] ?? .init()
      } else {
        languageIndices = nil
      }

      let categoryIndices: Set<Int>?
      if let category = category {
        categoryIndices = self.categoryIndices[category] ?? .init()
      } else {
        categoryIndices = nil
      }

      var indices: Set<Int>?

      if let languageIndices = languageIndices {
        indices = languageIndices
      }

      if let categoryIndices = categoryIndices {
        if let current = indices {
          indices = current.intersection(categoryIndices)
        } else {
          indices = categoryIndices
        }
      }

      if let current = indices {
        return current.map { self.allSites[$0] }
      } else {
        return allSites
      }
    }

    // swiftlint:disable function_body_length
    internal init(blogs: SiteCollection) {
      var categories = [CategoryLanguage]()
      var languages = [SiteLanguage]()
      var sites = [Site]()
      var languageIndices = [SiteLanguageType: Set<Int>]()
      var categoryIndices = [SiteCategoryType: Set<Int>]()

      for languageContent in blogs {
        let language = SiteLanguage(content: languageContent)
        var thisLanguageIndices = [Int]()
        for languageCategory in languageContent.categories {
          var thisCategoryIndices = [Int]()
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
            thisCategoryIndices.append(index)
            thisLanguageIndices.append(index)
          }
          categoryIndices.formUnion(thisCategoryIndices, key: category.type)
          categories.append(category)
        }
        languageIndices.formUnion(thisLanguageIndices, key: language.type)
        languages.append(language)
      }

      categoryDictionary = Dictionary(grouping: categories) { $0.type }
        .compactMapValues(SiteCategory.init)
      languageDictionary = Dictionary(
        uniqueKeysWithValues: languages.map { ($0.type, $0) }
      )
      self.languageIndices = languageIndices
      self.categoryIndices = categoryIndices
      allSites = sites
    }
  }

  private let instance: Instance

  /// A sequence of languages in the site collection directory.
  public var languages: Dictionary<SiteLanguageType, SiteLanguage>.Values {
    instance.languageDictionary.values
  }

  /// A sequence of categories in the site collection directory.
  public var categories: Dictionary<SiteCategoryType, SiteCategory>.Values {
    instance.categoryDictionary.values
  }

  /// Initializes a new instance of the ``SiteCollectionDirectory`` struct.
  ///
  /// - Parameter blogs: The site collection to use.
  internal init(blogs: SiteCollection) {
    instance = .init(blogs: blogs)
  }

  /// Retrieves a list of sites based on the specified language and category.
  ///
  /// - Parameters:
  ///   - language: The language of the sites to retrieve.
  ///   - category: The category of the sites to retrieve.
  /// - Returns: A list of sites matching the specified language and category.
  public func sites(
    withLanguage language: SiteLanguageType?,
    withCategory category: SiteCategoryType?
  ) -> [Site] {
    instance.sites(withLanguage: language, withCategory: category)
  }
}

/// A protocol for site directories.
public protocol SiteDirectory: Sendable {
  /// List of Sites
  associatedtype SiteSequence: Sequence where SiteSequence.Element == Site
  /// List of Languages
  associatedtype LanguageSequence: Sequence where LanguageSequence.Element == SiteLanguage
  /// List of Categories
  associatedtype CategorySequence: Sequence where CategorySequence.Element == SiteCategory

  /// A sequence of languages in the site directory.
  var languages: LanguageSequence { get }

  /// A sequence of categories in the site directory.
  var categories: CategorySequence { get }

  /// Retrieves a list of sites based on the specified language and category.
  ///
  /// - Parameters:
  ///   - language: The language of the sites to retrieve.
  ///   - category: The category of the sites to retrieve.
  /// - Returns: A list of sites matching the specified language and category.
  func sites(
    withLanguage language: SiteLanguageType?,
    withCategory category: SiteCategoryType?
  ) -> SiteSequence
}

extension SiteDirectory {
  /// Retrieves a list of sites based on the specified language and category.
  ///
  /// - Parameters:
  ///   - language: The language of the sites to retrieve.
  ///   - category: The category of the sites to retrieve.
  /// - Returns: A list of sites matching the specified language and category.
  public func sites(
    withLanguage language: SiteLanguageType? = nil,
    withCategory category: SiteCategoryType? = nil
  ) -> SiteSequence {
    sites(withLanguage: language, withCategory: category)
  }
}
