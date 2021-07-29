//
//  File.swift
//  File
//
//  Created by Leo Dion on 7/29/21.
//

import Foundation

public struct WPCategory: Codable {
  let termID: Int
  let niceName: CData
  let parent: CData
  let name: String

  enum CodingKeys: String, CodingKey {
    case termID = "wp:termId"
    case niceName = "wp:categoryNicename"
    case parent = "wp:categoryParent"
    case name = "wp:catName"
  }
}
