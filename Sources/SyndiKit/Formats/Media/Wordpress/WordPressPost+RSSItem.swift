//
//  WordPressPost+RSSItem.swift
//  SyndiKit
//
//  Created by Leo Dion.
//  Copyright © 2025 BrightDigit.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the “Software”), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#if swift(<5.7)
  @preconcurrency import Foundation
#else
  import Foundation
#endif

extension WordPressPost {
  /// A struct representing an Atom category.
  ///   Initializes a ``WordPressPost`` instance from an ``RSSItem``.
  ///
  ///   - Parameter item: The ``RSSItem`` to initialize from.
  ///
  ///   - Throws: `WordPressError.missingField` if any required field is missing.
  ///
  ///   - Note: This initializer is marked as ``public`` to allow external usage.
  ///
  /// - SeeAlso: ``EntryCategory``
  public init(item: RSSItem) throws {
    let validatedFields = try WordPressPost.validateRequiredFields(item: item)
    let processedFields = WordPressPost.processOptionalFields(item: item)

    self = WordPressPost.createWordPressPost(
      validatedFields: validatedFields,
      processedFields: processedFields
    )
  }

  private static func createWordPressPost(
    validatedFields: ValidatedFields,
    processedFields: ProcessedFields
  ) -> WordPressPost {
    let processedData = processCategoryAndMetaData(processedFields: processedFields)
    let basicProps = createBasicProperties(
      validatedFields: validatedFields, processedFields: processedFields)
    let categoryProps = createCategoryProperties(processedData: processedData)
    let metaProps = createMetaProperties(processedData: processedData)
    let dateProps = createDateProperties(
      validatedFields: validatedFields, processedFields: processedFields)

    let wpBasicProps = createWordPressBasicProps(
      basicProps: basicProps, categoryProps: categoryProps, metaProps: metaProps)
    let wpDateProps = createWordPressDateProps(dateProps: dateProps)

    return makeWordPressPostFromProps(
      wpBasicProps: wpBasicProps,
      wpDateProps: wpDateProps
    )
  }

  private static func makeWordPressPostFromProps(
    wpBasicProps: WordPressBasicProps,
    wpDateProps: WordPressDateProps
  ) -> WordPressPost {
    WordPressPost(
      name: wpBasicProps.name,
      title: wpBasicProps.title,
      type: wpBasicProps.type,
      link: wpBasicProps.link,
      pubDate: wpBasicProps.pubDate,
      creator: wpBasicProps.creator,
      body: wpBasicProps.body,
      tags: wpBasicProps.tags,
      categories: wpBasicProps.categories,
      meta: wpBasicProps.meta,
      status: wpBasicProps.status,
      commentStatus: wpBasicProps.commentStatus,
      pingStatus: wpBasicProps.pingStatus,
      parentID: wpBasicProps.parentID,
      menuOrder: wpBasicProps.menuOrder,
      id: wpBasicProps.id,
      isSticky: wpBasicProps.isSticky,
      postDate: wpDateProps.postDate,
      postDateGMT: wpDateProps.postDateGMT,
      modifiedDate: wpDateProps.modifiedDate,
      modifiedDateGMT: wpDateProps.modifiedDateGMT,
      attachmentURL: wpBasicProps.attachmentURL
    )
  }

  private struct ValidatedFields {
    let name: CData
    let type: CData
    let creator: String
    let body: CData
    let status: CData
    let commentStatus: CData
    let pingStatus: CData
    let parentID: Int
    let menuOrder: Int
    let id: Int
    let isSticky: Int
    let postDate: Date
    let modifiedDate: Date
    let link: URL
    let title: String
  }

  private struct ProcessedFields {
    let categoryTerms: [RSSItemCategory]
    let meta: [WordPressElements.PostMeta]
    let pubDate: Date?
    let modifiedDateGMT: Date?
    let postDateGMT: Date?
    let attachmentURL: URL?
  }

  private struct ProcessedData {
    let categoryDictionary: [String: [RSSItemCategory]]
    let metaDictionary: [String: String]
  }

  private struct BasicProperties {
    let name: String
    let title: String
    let type: String
    let link: URL
    let pubDate: Date?
    let creator: String
    let body: String
    let status: String
    let commentStatus: String
    let pingStatus: String
    let parentID: Int
    let menuOrder: Int
    let id: Int
    let isSticky: Bool
    let attachmentURL: URL?
  }

  private struct CategoryProperties {
    let tags: [String]
    let categories: [String]
  }

  private struct MetaProperties {
    let meta: [String: String]
  }

  private struct DateProperties {
    let postDate: Date
    let postDateGMT: Date?
    let modifiedDate: Date
    let modifiedDateGMT: Date?
  }

  private struct WordPressBasicProps {
    let name: String
    let title: String
    let type: String
    let link: URL
    let pubDate: Date?
    let creator: String
    let body: String
    let tags: [String]
    let categories: [String]
    let meta: [String: String]
    let status: String
    let commentStatus: String
    let pingStatus: String
    let parentID: Int
    let menuOrder: Int
    let id: Int
    let isSticky: Bool
    let attachmentURL: URL?
  }

  private struct WordPressDateProps {
    let postDate: Date
    let postDateGMT: Date?
    let modifiedDate: Date
    let modifiedDateGMT: Date?
  }

  private static func validateRequiredFields(item: RSSItem) throws -> ValidatedFields {
    let name = try validateName(item)
    let type = try validateType(item)
    let creator = try validateCreator(item)
    let body = try validateBody(item)
    let status = try validateStatus(item)
    let commentStatus = try validateCommentStatus(item)
    let pingStatus = try validatePingStatus(item)
    let parentID = try validateParentID(item)
    let menuOrder = try validateMenuOrder(item)
    let id = try validateID(item)
    let isSticky = try validateIsSticky(item)
    let postDate = try validatePostDate(item)
    let modifiedDate = try validateModifiedDate(item)
    let link = try validateLink(item)

    return ValidatedFields(
      name: name,
      type: type,
      creator: creator,
      body: body,
      status: status,
      commentStatus: commentStatus,
      pingStatus: pingStatus,
      parentID: parentID,
      menuOrder: menuOrder,
      id: id,
      isSticky: isSticky,
      postDate: postDate,
      modifiedDate: modifiedDate,
      link: link,
      title: item.title
    )
  }

  private static func validateName(_ item: RSSItem) throws -> CData {
    guard let name = item.wpPostName else {
      throw WordPressError.missingField(.name)
    }
    return name
  }

  private static func validateType(_ item: RSSItem) throws -> CData {
    guard let type = item.wpPostType else {
      throw WordPressError.missingField(.type)
    }
    return type
  }

  private static func validateCreator(_ item: RSSItem) throws -> String {
    guard let creator = item.creators.first else {
      throw WordPressError.missingField(.creator)
    }
    return creator
  }

  private static func validateBody(_ item: RSSItem) throws -> CData {
    guard let body = item.contentEncoded else {
      throw WordPressError.missingField(.body)
    }
    return body
  }

  private static func validateStatus(_ item: RSSItem) throws -> CData {
    guard let status = item.wpStatus else {
      throw WordPressError.missingField(.status)
    }
    return status
  }

  private static func validateCommentStatus(_ item: RSSItem) throws -> CData {
    guard let commentStatus = item.wpCommentStatus else {
      throw WordPressError.missingField(.commentStatus)
    }
    return commentStatus
  }

  private static func validatePingStatus(_ item: RSSItem) throws -> CData {
    guard let pingStatus = item.wpPingStatus else {
      throw WordPressError.missingField(.pingStatus)
    }
    return pingStatus
  }

  private static func validateParentID(_ item: RSSItem) throws -> Int {
    guard let parentID = item.wpPostParent else {
      throw WordPressError.missingField(.parentID)
    }
    return parentID
  }

  private static func validateMenuOrder(_ item: RSSItem) throws -> Int {
    guard let menuOrder = item.wpMenuOrder else {
      throw WordPressError.missingField(.menuOrder)
    }
    return menuOrder
  }

  private static func validateID(_ item: RSSItem) throws -> Int {
    guard let id = item.wpPostID else {
      throw WordPressError.missingField(.id)
    }
    return id
  }

  private static func validateIsSticky(_ item: RSSItem) throws -> Int {
    guard let isSticky = item.wpIsSticky else {
      throw WordPressError.missingField(.isSticky)
    }
    return isSticky
  }

  private static func validatePostDate(_ item: RSSItem) throws -> Date {
    guard let postDate = item.wpPostDate else {
      throw WordPressError.missingField(.postDate)
    }
    return postDate
  }

  private static func validateModifiedDate(_ item: RSSItem) throws -> Date {
    guard let modifiedDate = item.wpModifiedDate else {
      throw WordPressError.missingField(.modifiedDate)
    }
    return modifiedDate
  }

  private static func validateLink(_ item: RSSItem) throws -> URL {
    guard let link = item.link else {
      throw WordPressError.missingField(.link)
    }
    return link
  }

  private static func processOptionalFields(item: RSSItem) -> ProcessedFields {
    ProcessedFields(
      categoryTerms: item.categoryTerms,
      meta: item.wpPostMeta,
      pubDate: item.pubDate,
      modifiedDateGMT: item.wpModifiedDateGMT,
      postDateGMT: item.wpPostDateGMT,
      attachmentURL: item.wpAttachmentURL
    )
  }

  private static func processCategoryAndMetaData(
    processedFields: ProcessedFields
  ) -> ProcessedData {
    let categoryDictionary = Dictionary(
      grouping: processedFields.categoryTerms.filter { $0.domain != nil }
    ) {
      $0.domain!
    }

    let metaDictionary = Dictionary(grouping: processedFields.meta) { $0.key.value }
      .compactMapValues { $0.last?.value.value }

    return ProcessedData(
      categoryDictionary: categoryDictionary,
      metaDictionary: metaDictionary
    )
  }

  private static func createBasicProperties(
    validatedFields: ValidatedFields,
    processedFields: ProcessedFields
  ) -> BasicProperties {
    BasicProperties(
      name: validatedFields.name.value,
      title: validatedFields.title,
      type: validatedFields.type.value,
      link: validatedFields.link,
      pubDate: processedFields.pubDate,
      creator: validatedFields.creator,
      body: validatedFields.body.value,
      status: validatedFields.status.value,
      commentStatus: validatedFields.commentStatus.value,
      pingStatus: validatedFields.pingStatus.value,
      parentID: validatedFields.parentID,
      menuOrder: validatedFields.menuOrder,
      id: validatedFields.id,
      isSticky: (validatedFields.isSticky != 0),
      attachmentURL: processedFields.attachmentURL
    )
  }

  private static func createCategoryProperties(
    processedData: ProcessedData
  ) -> CategoryProperties {
    CategoryProperties(
      tags:
        processedData
        .categoryDictionary["post_tag", default: []]
        .map { $0.value },
      categories:
        processedData
        .categoryDictionary["category", default: []]
        .map { $0.value }
    )
  }

  private static func createMetaProperties(
    processedData: ProcessedData
  ) -> MetaProperties {
    MetaProperties(meta: processedData.metaDictionary)
  }

  private static func createDateProperties(
    validatedFields: ValidatedFields,
    processedFields: ProcessedFields
  ) -> DateProperties {
    DateProperties(
      postDate: validatedFields.postDate,
      postDateGMT: processedFields.postDateGMT,
      modifiedDate: validatedFields.modifiedDate,
      modifiedDateGMT: processedFields.modifiedDateGMT
    )
  }

  private static func createWordPressBasicProps(
    basicProps: BasicProperties,
    categoryProps: CategoryProperties,
    metaProps: MetaProperties
  ) -> WordPressBasicProps {
    WordPressBasicProps(
      name: basicProps.name,
      title: basicProps.title,
      type: basicProps.type,
      link: basicProps.link,
      pubDate: basicProps.pubDate,
      creator: basicProps.creator,
      body: basicProps.body,
      tags: categoryProps.tags,
      categories: categoryProps.categories,
      meta: metaProps.meta,
      status: basicProps.status,
      commentStatus: basicProps.commentStatus,
      pingStatus: basicProps.pingStatus,
      parentID: basicProps.parentID,
      menuOrder: basicProps.menuOrder,
      id: basicProps.id,
      isSticky: basicProps.isSticky,
      attachmentURL: basicProps.attachmentURL
    )
  }

  private static func createWordPressDateProps(
    dateProps: DateProperties
  ) -> WordPressDateProps {
    WordPressDateProps(
      postDate: dateProps.postDate,
      postDateGMT: dateProps.postDateGMT,
      modifiedDate: dateProps.modifiedDate,
      modifiedDateGMT: dateProps.modifiedDateGMT
    )
  }
}
