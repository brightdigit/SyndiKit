//
//  ITunesProperties.swift
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

internal struct ITunesProperties {
    let title: String?
    let episode: iTunesEpisode?
    let author: String?
    let subtitle: String?
    let summary: CData?
    let explicit: String?
    let duration: iTunesDuration?
    let image: iTunesImage?

    init(
        title: String?,
        episode: iTunesEpisode?,
        author: String?,
        subtitle: String?,
        summary: CData?,
        explicit: String?,
        duration: iTunesDuration?,
        image: iTunesImage?
    ) {
        self.title = title
        self.episode = episode
        self.author = author
        self.subtitle = subtitle
        self.summary = summary
        self.explicit = explicit
        self.duration = duration
        self.image = image
    }

    init(
        itunesTitle: String?,
        itunesEpisode: Int?,
        itunesAuthor: String?,
        itunesSubtitle: String?,
        itunesSummary: CData?,
        itunesExplicit: String?,
        itunesDuration: TimeInterval?,
        itunesImage: iTunesImage?
    ) {
        self.title = itunesTitle
        self.episode = itunesEpisode.map(iTunesEpisode.init)
        self.author = itunesAuthor
        self.subtitle = itunesSubtitle
        self.summary = itunesSummary
        self.explicit = itunesExplicit
        self.duration = itunesDuration.map(iTunesDuration.init)
        self.image = itunesImage
    }

    init(from container: KeyedDecodingContainer<RSSItem.CodingKeys>) throws {
        self.init(
            title: try container.decodeIfPresent(String.self, forKey: .itunesTitle),
            episode: try container.decodeIfPresent(iTunesEpisode.self, forKey: .itunesEpisode),
            author: try container.decodeIfPresent(String.self, forKey: .itunesAuthor),
            subtitle: try container.decodeIfPresent(String.self, forKey: .itunesSubtitle),
            summary: try container.decodeIfPresent(CData.self, forKey: .itunesSummary),
            explicit: try container.decodeIfPresent(String.self, forKey: .itunesExplicit),
            duration: try container.decodeIfPresent(iTunesDuration.self, forKey: .itunesDuration),
            image: try container.decodeIfPresent(iTunesImage.self, forKey: .itunesImage)
        )
    }
}
