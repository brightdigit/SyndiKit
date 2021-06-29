import Foundation
import XMLCoder

public class RSSDecoder {
  static func decoder(_ decoder: JSONDecoder) {
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .custom(DateFormatterDecoder.RSS.decoder.decode(from:))
  }

  static func decoder(_ decoder: XMLDecoder) {
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .custom(DateFormatterDecoder.RSS.decoder.decode(from:))
    decoder.trimValueWhitespaces = false
  }

  public init(jsonDecoderProvider: ((JSONDecoder) -> Void)? = nil, xmlDecoderProvider: ((XMLDecoder) -> Void)? = nil) {
    self.jsonDecoderProvider = jsonDecoderProvider ?? Self.decoder(_:)
    self.xmlDecoderProvider = xmlDecoderProvider ?? Self.decoder(_:)
  }

  let jsonDecoderProvider: (JSONDecoder) -> Void
  let xmlDecoderProvider: (XMLDecoder) -> Void

  lazy var xmlDecoder: XMLDecoder = {
    let decoder = XMLDecoder()
    self.xmlDecoderProvider(decoder)
    return decoder
  }()

  lazy var jsonDecoder: JSONDecoder = {
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

  public func decode(_ data: Data) throws -> Feedable {
    var errors = [DecodingError]()
    do {
      let rss = try rssDecoding.decode(data: data)
      return rss
    } catch let decodingError as DecodingError {
      errors.append(decodingError)
    } catch let error as NSError {
      guard error.domain == "NSXMLParserErrorDomain" else {
        throw error
      }
    }

    do {
      return try atomDecoding.decode(data: data)
    } catch let decodingError as DecodingError {
      errors.append(decodingError)
    } catch let error as NSError {
      guard error.domain == "NSXMLParserErrorDomain" else {
        throw error
      }
    }

    do {
      return try jsonFeedDecoding.decode(data: data)
    } catch let decodingError as DecodingError {
      errors.append(decodingError)
    }

    throw DecodingError.failedAttempts(errors)
  }
}
