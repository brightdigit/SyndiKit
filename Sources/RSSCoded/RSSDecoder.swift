//
//  File.swift
//  
//
//  Created by Leo Dion on 6/26/21.
//

import Foundation
import XMLCoder

class RSSDecoder {
  internal init(jsonDecoderProvider: @escaping (JSONDecoder) -> Void = Feed.decoder(_:), xmlDecoderProvider: @escaping (XMLDecoder) -> Void = Feed.decoder(_:)) {
    self.jsonDecoderProvider = jsonDecoderProvider
    self.xmlDecoderProvider = xmlDecoderProvider
  }
  
  let jsonDecoderProvider : (JSONDecoder) -> Void
  let xmlDecoderProvider: (XMLDecoder) -> Void
  
  lazy var xmlDecoder : XMLDecoder = {
    let decoder = XMLDecoder()
    self.xmlDecoderProvider(decoder)
    return decoder
  }()
  
  
  lazy var jsonDecoder : JSONDecoder = {
    let decoder = JSONDecoder()
    self.jsonDecoderProvider(decoder)
    return decoder
  }()
  
  lazy var rssDecoding = {
    Decoding(for: RSSFeed.self, using: self.xmlDecoder)
  }()
  
  lazy var atomDecoding = {
    Decoding(for: AtomFeed.self, using: self.xmlDecoder)
  }()
  
  lazy var jsonFeedDecoding = {
    Decoding(for: JSONFeed.self, using: self.jsonDecoder)
  }()

  
  func decode(_ data: Data) throws -> Feed {
    var errors = [DecodingError]()
    do {
      let rss = try self.rssDecoding.decode(data: data)
      return Feed.rss(rss)
    } catch let decodingError as DecodingError {
      errors.append(decodingError)
    }
    
    do {
      let atom = try self.atomDecoding.decode(data: data)
      return Feed.atom(atom)
    } catch let decodingError as DecodingError {
      errors.append(decodingError)
    }
    
    do {
      let json = try self.jsonFeedDecoding.decode(data: data)
      return Feed.json(json)
    } catch let decodingError as DecodingError {
      errors.append(decodingError)
    }
    
    throw DecodingError.failedAttempts(errors)
  }
}
