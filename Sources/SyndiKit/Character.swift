//
//  File.swift
//  
//
//  Created by Ahmed Shendy on 27/09/2023.
//

import Foundation

extension Character {
  func asOsmType() -> PodcastLocation.OsmQuery.OsmType? {
    .init(rawValue: String(self))
  }
}
