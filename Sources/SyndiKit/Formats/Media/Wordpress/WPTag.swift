//
//  File.swift
//  File
//
//  Created by Leo Dion on 7/29/21.
//

import Foundation
public struct WPTag: Codable {
  let termID: Int
  let slug: CData
  let name: CData

  enum CodingKeys: String, CodingKey {
    case termID = "wp:termId"
    case slug = "wp:tagSlug"
    case name = "wp:tagName"
  }
}
