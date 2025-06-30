//
//  WordPressProperties.swift
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

import Foundation

internal struct WordPressProperties {
    let postID: Int?
    let postDate: Date?
    let postDateGMT: Date?
    let modifiedDate: Date?
    let modifiedDateGMT: Date?
    let postName: CData?
    let postType: CData?
    let postMeta: [WordPressElements.PostMeta]
    let commentStatus: CData?
    let pingStatus: CData?
    let status: CData?
    let postParent: Int?
    let menuOrder: Int?
    let isSticky: Int?
    let postPassword: CData?
    let attachmentURL: URL?

    init(
        wpCommentStatus: String?,
        wpPingStatus: String?,
        wpStatus: String?,
        wpPostParent: Int?,
        wpMenuOrder: Int?,
        wpIsSticky: Int?,
        wpPostPassword: String?,
        wpPostID: Int?,
        wpPostDate: Date?,
        wpPostDateGMT: Date?,
        wpModifiedDate: Date?,
        wpModifiedDateGMT: Date?,
        wpPostName: String?,
        wpPostType: String?,
        wpPostMeta: [WordPressElements.PostMeta],
        wpAttachmentURL: URL?
    ) {
        self.postID = wpPostID
        self.postDate = wpPostDate
        self.postDateGMT = wpPostDateGMT
        self.modifiedDate = wpModifiedDate
        self.modifiedDateGMT = wpModifiedDateGMT
        self.postName = wpPostName.map(CData.init)
        self.postType = wpPostType.map(CData.init)
        self.postMeta = wpPostMeta
        self.commentStatus = wpCommentStatus.map(CData.init)
        self.pingStatus = wpPingStatus.map(CData.init)
        self.status = wpStatus.map(CData.init)
        self.postParent = wpPostParent
        self.menuOrder = wpMenuOrder
        self.isSticky = wpIsSticky
        self.postPassword = wpPostPassword.map(CData.init)
        self.attachmentURL = wpAttachmentURL
    }

    init(from container: KeyedDecodingContainer<RSSItem.CodingKeys>) throws {
        let (postDateGMT, modifiedDateGMT) = try Self.decodeWordPressDateGMT(from: container)
        let attachmentURL = try Self.decodeWordPressAttachmentURL(from: container)
        self.init(
            wpCommentStatus: try container.decodeIfPresent(String.self, forKey: .wpCommentStatus),
            wpPingStatus: try container.decodeIfPresent(String.self, forKey: .wpPingStatus),
            wpStatus: try container.decodeIfPresent(String.self, forKey: .wpStatus),
            wpPostParent: try container.decodeIfPresent(Int.self, forKey: .wpPostParent),
            wpMenuOrder: try container.decodeIfPresent(Int.self, forKey: .wpMenuOrder),
            wpIsSticky: try container.decodeIfPresent(Int.self, forKey: .wpIsSticky),
            wpPostPassword: try container.decodeIfPresent(String.self, forKey: .wpPostPassword),
            wpPostID: try container.decodeIfPresent(Int.self, forKey: .wpPostID),
            wpPostDate: try container.decodeIfPresent(Date.self, forKey: .wpPostDate),
            wpPostDateGMT: postDateGMT,
            wpModifiedDate: try container.decodeIfPresent(Date.self, forKey: .wpModifiedDate),
            wpModifiedDateGMT: modifiedDateGMT,
            wpPostName: try container.decodeIfPresent(String.self, forKey: .wpPostName),
            wpPostType: try container.decodeIfPresent(String.self, forKey: .wpPostType),
            wpPostMeta: try container.decodeIfPresent([WordPressElements.PostMeta].self, forKey: .wpPostMeta) ?? [],
            wpAttachmentURL: attachmentURL
        )
    }

    private static func decodeWordPressDateGMT(from container: KeyedDecodingContainer<RSSItem.CodingKeys>) throws -> (Date?, Date?) {
        let wpPostDateGMT = try container.decodeIfPresent(String.self, forKey: .wpPostDateGMT)
        let postDateGMT: Date?
        if let wpPostDateGMT = wpPostDateGMT {
            if wpPostDateGMT == "0000-00-00 00:00:00" {
                postDateGMT = nil
            } else {
                postDateGMT = try container.decode(Date.self, forKey: .wpPostDateGMT)
            }
        } else {
            postDateGMT = nil
        }

        let wpModifiedDateGMT = try container.decodeIfPresent(String.self, forKey: .wpModifiedDateGMT)
        let modifiedDateGMT: Date?
        if let wpModifiedDateGMT = wpModifiedDateGMT {
            if wpModifiedDateGMT == "0000-00-00 00:00:00" {
                modifiedDateGMT = nil
            } else {
                modifiedDateGMT = try container.decode(Date.self, forKey: .wpModifiedDateGMT)
            }
        } else {
            modifiedDateGMT = nil
        }

        return (postDateGMT, modifiedDateGMT)
    }

    private static func decodeWordPressAttachmentURL(from container: KeyedDecodingContainer<RSSItem.CodingKeys>) throws -> URL? {
        let wpAttachmentURLCDData = try container.decodeIfPresent(CData.self, forKey: .wpAttachmentURL)
        return wpAttachmentURLCDData.map { $0.value }.flatMap(URL.init(string:))
    }
}
