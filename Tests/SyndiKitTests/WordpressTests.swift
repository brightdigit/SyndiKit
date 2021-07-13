//
//  File.swift
//  
//
//  Created by Leo Dion on 7/2/21.
//

import Foundation
import SyndiKit
import XCTest

final class WordpressTests: XCTestCase {
  func testDateDecoder () {
    let dateDecoder = DateFormatterDecoder.RSS.decoder
    let result = dateDecoder.decodeString("Fri, 06 Oct 2017 17:21:35 +0000")
    XCTAssertNotNil(result)
    
    let another = dateDecoder.decodeString("2017-10-06 16:59:50")
    XCTAssertNotNil(another)
  }
  func testWordpressPosts () {
    let xmlDataSet = try! FileManager.default.dataFromDirectory(at: Directories.Wordpress)
    
    let decoder = RSSDecoder()
    
    let exports = Dictionary(uniqueKeysWithValues: xmlDataSet).mapValues { result in
      result.flatMap { data in
         Result{ try decoder.decode(data) }
      }
    }
    
    for (name, result) in exports {
      let feedable : Feedable
      do {
        feedable = try result.get()
      } catch {
        XCTAssertNil(error, name)
        
        continue
      }
      
      guard let feed = feedable as? RSSFeed else {
        XCTFail()
        continue
      }
      
      XCTAssertGreaterThan(feed.channel.wpTags.count, 0)
      XCTAssertGreaterThan(feed.channel.wpCategories.count, 0)
      let notPostIndex = feed.channel.items.firstIndex(where: {
        $0.wpPostID == nil
      })
      
      XCTAssertNil(notPostIndex)
      
      if let index = notPostIndex {
        dump(feed.channel.items[index])
      }
    }
  }
}
