//
//  WordPressPost+Processor.swift
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
#elseif swift(<6.1)
  import Foundation
#else
internal import Foundation
#endif

extension WordPressPost {
  /// A struct responsible for processing optional fields
  ///  and creating WordPress post components.
  public struct Processor: Sendable {
    /// Processes optional fields from an RSSItem and returns a ProcessedFields instance.
    ///
    /// - Parameter item: The RSSItem to process.
    /// - Returns: A ProcessedFields instance containing all processed optional fields.
    public static func processOptionalFields(item: RSSItem) -> ProcessedFields {
      ProcessedFields(
        categoryTerms: item.categoryTerms,
        meta: item.wpPostMeta,
        pubDate: item.pubDate,
        modifiedDateGMT: item.wpModifiedDateGMT,
        postDateGMT: item.wpPostDateGMT,
        attachmentURL: item.wpAttachmentURL
      )
    }

    /// Processes category and meta data from ProcessedFields
    ///  and returns a ProcessedData instance.
    ///
    /// - Parameter processedFields: The ProcessedFields to process.
    /// - Returns: A ProcessedData instance
    /// containing processed category
    ///  and meta dictionaries.
    public static func processCategoryAndMetaData(
      processedFields: ProcessedFields
    ) -> ProcessedData {
      let categoryDictionary = Dictionary( grouping: processedFields.categoryTerms.compactMap{ term in
        term.domain.map{
          ($0, term)
        }
      }) {
        $0.0
      }.mapValues{
        $0.map{
          $0.1
        }
      }

      let metaDictionary = Dictionary(grouping: processedFields.meta) { $0.key.value }
        .compactMapValues { $0.last?.value.value }

      return ProcessedData(
        categoryDictionary: categoryDictionary,
        metaDictionary: metaDictionary
      )
    }

    /// Creates BasicProperties from validated and processed fields.
    ///
    /// - Parameters:
    ///   - validatedFields: The validated required fields.
    ///   - processedFields: The processed optional fields.
    /// - Returns: A BasicProperties instance.
    public static func createBasicProperties(
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

    /// Creates CategoryProperties from processed data.
    ///
    /// - Parameter processedData: The processed data containing category information.
    /// - Returns: A CategoryProperties instance.
    public static func createCategoryProperties(
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

    /// Creates MetaProperties from processed data.
    ///
    /// - Parameter processedData: The processed data containing meta information.
    /// - Returns: A MetaProperties instance.
    public static func createMetaProperties(
      processedData: ProcessedData
    ) -> MetaProperties {
      MetaProperties(meta: processedData.metaDictionary)
    }

    /// Creates DateProperties from validated and processed fields.
    ///
    /// - Parameters:
    ///   - validatedFields: The validated required fields.
    ///   - processedFields: The processed optional fields.
    /// - Returns: A DateProperties instance.
    public static func createDateProperties(
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

    /// Creates a WordPressPost from basic, category, meta, and date properties.
    ///
    /// - Parameters:
    ///   - basicProps: The basic properties.
    ///   - categoryProps: The category properties.
    ///   - metaProps: The meta properties.
    ///   - dateProps: The date properties.
    /// - Returns: A WordPressPost instance.
    public static func createWordPressPostFromProperties(
      basicProps: BasicProperties,
      categoryProps: CategoryProperties,
      metaProps: MetaProperties,
      dateProps: DateProperties
    ) -> WordPressPost {
      WordPressPost(
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
        postDate: dateProps.postDate,
        postDateGMT: dateProps.postDateGMT,
        modifiedDate: dateProps.modifiedDate,
        modifiedDateGMT: dateProps.modifiedDateGMT,
        attachmentURL: basicProps.attachmentURL
      )
    }

    /// Creates a WordPressPost from validated and processed fields.
    ///
    /// - Parameters:
    ///   - validatedFields: The validated required fields.
    ///   - processedFields: The processed optional fields.
    /// - Returns: A WordPressPost instance.
    public static func createWordPressPost(
      validatedFields: ValidatedFields,
      processedFields: ProcessedFields
    ) -> WordPressPost {
      let processedData = processCategoryAndMetaData(processedFields: processedFields)
      let basicProps = createBasicProperties(
        validatedFields: validatedFields,
        processedFields: processedFields
      )
      let categoryProps = createCategoryProperties(processedData: processedData)
      let metaProps = createMetaProperties(processedData: processedData)
      let dateProps = createDateProperties(
        validatedFields: validatedFields,
        processedFields: processedFields
      )

      return createWordPressPostFromProperties(
        basicProps: basicProps,
        categoryProps: categoryProps,
        metaProps: metaProps,
        dateProps: dateProps
      )
    }
  }
}
