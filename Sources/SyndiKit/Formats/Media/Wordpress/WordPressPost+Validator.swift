//
//  WordPressPost+Validator.swift
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
  public import Foundation
#endif

extension WordPressPost {
  /// A struct responsible for validating required fields from an RSSItem.
  public struct Validator: Sendable {
    /// Validates all required fields from an RSSItem
    ///  and returns a ValidatedFields instance.
    ///
    /// - Parameter item: The RSSItem to validate.
    /// - Returns: A ValidatedFields instance containing all validated required fields.
    /// - Throws: WordPressError.missingField if any required field is missing.
    public static func validateRequiredFields(item: RSSItem) throws -> ValidatedFields {
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

    /// Validates the name field from an RSSItem.
    ///
    /// - Parameter item: The RSSItem to validate.
    /// - Returns: The validated name as CData.
    /// - Throws: WordPressError.missingField(.name) if the name is missing.
    public static func validateName(_ item: RSSItem) throws -> CData {
      guard let name = item.wpPostName else {
        throw WordPressError.missingField(.name)
      }
      return name
    }

    /// Validates the type field from an RSSItem.
    ///
    /// - Parameter item: The RSSItem to validate.
    /// - Returns: The validated type as CData.
    /// - Throws: WordPressError.missingField(.type) if the type is missing.
    public static func validateType(_ item: RSSItem) throws -> CData {
      guard let type = item.wpPostType else {
        throw WordPressError.missingField(.type)
      }
      return type
    }

    /// Validates the creator field from an RSSItem.
    ///
    /// - Parameter item: The RSSItem to validate.
    /// - Returns: The validated creator as String.
    /// - Throws: WordPressError.missingField(.creator) if the creator is missing.
    public static func validateCreator(_ item: RSSItem) throws -> String {
      guard let creator = item.creators.first else {
        throw WordPressError.missingField(.creator)
      }
      return creator
    }

    /// Validates the body field from an RSSItem.
    ///
    /// - Parameter item: The RSSItem to validate.
    /// - Returns: The validated body as CData.
    /// - Throws: WordPressError.missingField(.body) if the body is missing.
    public static func validateBody(_ item: RSSItem) throws -> CData {
      guard let body = item.contentEncoded else {
        throw WordPressError.missingField(.body)
      }
      return body
    }

    /// Validates the status field from an RSSItem.
    ///
    /// - Parameter item: The RSSItem to validate.
    /// - Returns: The validated status as CData.
    /// - Throws: WordPressError.missingField(.status) if the status is missing.
    public static func validateStatus(_ item: RSSItem) throws -> CData {
      guard let status = item.wpStatus else {
        throw WordPressError.missingField(.status)
      }
      return status
    }

    /// Validates the comment status field from an RSSItem.
    ///
    /// - Parameter item: The RSSItem to validate.
    /// - Returns: The validated comment status as CData.
    /// - Throws: WordPressError.missingField(.commentStatus)
    /// if the comment status is missing.
    public static func validateCommentStatus(_ item: RSSItem) throws -> CData {
      guard let commentStatus = item.wpCommentStatus else {
        throw WordPressError.missingField(.commentStatus)
      }
      return commentStatus
    }

    /// Validates the ping status field from an RSSItem.
    ///
    /// - Parameter item: The RSSItem to validate.
    /// - Returns: The validated ping status as CData.
    /// - Throws: WordPressError.missingField(.pingStatus) if the ping status is missing.
    public static func validatePingStatus(_ item: RSSItem) throws -> CData {
      guard let pingStatus = item.wpPingStatus else {
        throw WordPressError.missingField(.pingStatus)
      }
      return pingStatus
    }

    /// Validates the parent ID field from an RSSItem.
    ///
    /// - Parameter item: The RSSItem to validate.
    /// - Returns: The validated parent ID as Int.
    /// - Throws: WordPressError.missingField(.parentID) if the parent ID is missing.
    public static func validateParentID(_ item: RSSItem) throws -> Int {
      guard let parentID = item.wpPostParent else {
        throw WordPressError.missingField(.parentID)
      }
      return parentID
    }

    /// Validates the menu order field from an RSSItem.
    ///
    /// - Parameter item: The RSSItem to validate.
    /// - Returns: The validated menu order as Int.
    /// - Throws: WordPressError.missingField(.menuOrder) if the menu order is missing.
    public static func validateMenuOrder(_ item: RSSItem) throws -> Int {
      guard let menuOrder = item.wpMenuOrder else {
        throw WordPressError.missingField(.menuOrder)
      }
      return menuOrder
    }

    /// Validates the ID field from an RSSItem.
    ///
    /// - Parameter item: The RSSItem to validate.
    /// - Returns: The validated ID as Int.
    /// - Throws: WordPressError.missingField(.id) if the ID is missing.
    public static func validateID(_ item: RSSItem) throws -> Int {
      guard let id = item.wpPostID else {
        throw WordPressError.missingField(.id)
      }
      return id
    }

    /// Validates the is sticky field from an RSSItem.
    ///
    /// - Parameter item: The RSSItem to validate.
    /// - Returns: The validated is sticky value as Int.
    /// - Throws: WordPressError.missingField(.isSticky)
    /// if the is sticky value is missing.
    public static func validateIsSticky(_ item: RSSItem) throws -> Int {
      guard let isSticky = item.wpIsSticky else {
        throw WordPressError.missingField(.isSticky)
      }
      return isSticky
    }

    /// Validates the post date field from an RSSItem.
    ///
    /// - Parameter item: The RSSItem to validate.
    /// - Returns: The validated post date as Date.
    /// - Throws: WordPressError.missingField(.postDate) if the post date is missing.
    public static func validatePostDate(_ item: RSSItem) throws -> Date {
      guard let postDate = item.wpPostDate else {
        throw WordPressError.missingField(.postDate)
      }
      return postDate
    }

    /// Validates the modified date field from an RSSItem.
    ///
    /// - Parameter item: The RSSItem to validate.
    /// - Returns: The validated modified date as Date.
    /// - Throws: WordPressError.missingField(.modifiedDate)
    ///  if the modified date is missing.
    public static func validateModifiedDate(_ item: RSSItem) throws -> Date {
      guard let modifiedDate = item.wpModifiedDate else {
        throw WordPressError.missingField(.modifiedDate)
      }
      return modifiedDate
    }

    /// Validates the link field from an RSSItem.
    ///
    /// - Parameter item: The RSSItem to validate.
    /// - Returns: The validated link as URL.
    /// - Throws: WordPressError.missingField(.link) if the link is missing.
    public static func validateLink(_ item: RSSItem) throws -> URL {
      guard let link = item.link else {
        throw WordPressError.missingField(.link)
      }
      return link
    }
  }
}
