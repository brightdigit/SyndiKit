import Foundation

extension WordPressPost {
  // swiftlint:disable cyclomatic_complexity function_body_length
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
    guard let name = item.wpPostName else {
      throw WordPressError.missingField(.name)
    }
    guard let type = item.wpPostType else {
      throw WordPressError.missingField(.type)
    }
    guard let creator = item.creators.first else {
      throw WordPressError.missingField(.creator)
    }
    guard let body = item.contentEncoded else {
      throw WordPressError.missingField(.body)
    }
    guard let status = item.wpStatus else {
      throw WordPressError.missingField(.status)
    }
    guard let commentStatus = item.wpCommentStatus else {
      throw WordPressError.missingField(.commentStatus)
    }
    guard let pingStatus = item.wpPingStatus else {
      throw WordPressError.missingField(.pingStatus)
    }
    guard let parentID = item.wpPostParent else {
      throw WordPressError.missingField(.parentID)
    }
    guard let menuOrder = item.wpMenuOrder else {
      throw WordPressError.missingField(.menuOrder)
    }
    guard let id = item.wpPostID else {
      throw WordPressError.missingField(.id)
    }
    guard let isSticky = item.wpIsSticky else {
      throw WordPressError.missingField(.isSticky)
    }
    guard let postDate = item.wpPostDate else {
      throw WordPressError.missingField(.postDate)
    }
    guard let modifiedDate = item.wpModifiedDate else {
      throw WordPressError.missingField(.modifiedDate)
    }
    guard let link = item.link else {
      throw WordPressError.missingField(.link)
    }

    let title = item.title
    let categoryTerms = item.categoryTerms
    let meta = item.wpPostMeta
    let pubDate = item.pubDate

    let categoryDictionary = Dictionary(
      grouping: categoryTerms) {
      $0.domain
    }

    modifiedDateGMT = item.wpModifiedDateGMT
    self.name = name.value
    self.title = title
    self.type = type.value
    self.link = link
    self.pubDate = pubDate
    self.creator = creator
    self.body = body.value
    tags = categoryDictionary["post_tag", default: []].map { $0.value }
    categories = categoryDictionary["category", default: []].map { $0.value }
    self.meta = Dictionary(grouping: meta) { $0.key.value }
      .compactMapValues { $0.last?.value.value }
    self.status = status.value
    self.commentStatus = commentStatus.value
    self.pingStatus = pingStatus.value
    self.parentID = parentID
    self.menuOrder = menuOrder
    self.id = id
    self.isSticky = (isSticky != 0)
    self.postDate = postDate
    postDateGMT = item.wpPostDateGMT
    self.modifiedDate = modifiedDate
    attachmentURL = item.wpAttachmentURL
  }

  // swiftlint:enable cyclomatic_complexity function_body_length
}
