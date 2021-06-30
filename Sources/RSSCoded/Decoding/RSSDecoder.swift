import Foundation
import XMLCoder

protocol CustomDecoderSetup {
  func setup(decoder: TypeDecoder)
}

protocol DecoderSetup {
  var source: DecoderSource { get }
}

enum DecoderSource: DecoderSetup {
  case json
  case xml

  var source: DecoderSource {
    self
  }
}

protocol DecodableFeed: Decodable, Feedable {
  static var source: DecoderSetup { get }
}

extension DecodableFeed {
  static func decoding(using decoder: TypeDecoder) -> Decoding<Self> {
    Decoding(for: Self.self, using: decoder)
  }

  static func anyDecoding(using decoder: TypeDecoder) -> AnyDecoding {
    Self.decoding(using: decoder)
  }
}

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

  public init(
    jsonDecoderProvider: ((JSONDecoder) -> Void)? = nil,
    xmlDecoderProvider: ((XMLDecoder) -> Void)? = nil
  ) {
    defaultJSONDecoderSetup = jsonDecoderProvider ?? Self.decoder(_:)
    defaultXMLDecoderSetup = xmlDecoderProvider ?? Self.decoder(_:)
  }

  let defaultJSONDecoderSetup: (JSONDecoder) -> Void
  let defaultXMLDecoderSetup: (XMLDecoder) -> Void

  let deedTypes: [DecodableFeed.Type] = [RSSFeed.self, AtomFeed.self]

  lazy var xmlDecoder: XMLDecoder = {
    let decoder = XMLDecoder()
    self.defaultXMLDecoderSetup(decoder)
    return decoder
  }()

  lazy var jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    self.defaultJSONDecoderSetup(decoder)
    return decoder
  }()

  lazy var xmlDecodings: [AnyDecoding] = {
    deedTypes.map { type in
      let source = type.source
      let setup = type.source as? CustomDecoderSetup
      let decoder: TypeDecoder

      switch (source.source, setup?.setup(decoder:)) {
      case let (.xml, .some(setup)):
        decoder = XMLDecoder()
        setup(decoder)

      case let (.json, .some(setup)):
        decoder = JSONDecoder()
        setup(decoder)

      case (.xml, .none):
        decoder = self.xmlDecoder

      case (.json, .none):
        decoder = self.jsonDecoder
      }

      return type.anyDecoding(using: decoder)
    }
  }()

  lazy var jsonDecodings: [AnyDecoding] = {
    [Decoding(for: JSONFeed.self, using: self.jsonDecoder) as AnyDecoding]
  }()

  public func decode(_ data: Data) throws -> Feedable {
    var errors = [DecodingError]()

    var isXML = true
    for decoding in xmlDecodings {
      guard isXML else {
        break
      }
      do {
        return try decoding.decodeFeed(data: data)
      } catch let decodingError as DecodingError {
        errors.append(decodingError)
      } catch let error as NSError {
        guard error.domain == "NSXMLParserErrorDomain" else {
          throw error
        }
        isXML = false
      }
    }

    for decoding in jsonDecodings {
      do {
        return try decoding.decodeFeed(data: data)
      } catch let decodingError as DecodingError {
        errors.append(decodingError)
      }
    }

    throw DecodingError.failedAttempts(errors)
  }
}
