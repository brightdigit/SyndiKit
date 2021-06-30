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

  public init(
    types: [DecodableFeed.Type]? = nil,
    defaultJSONDecoderSetup: ((JSONDecoder) -> Void)? = nil,
    defaultXMLDecoderSetup: ((XMLDecoder) -> Void)? = nil
  ) {
    self.types = types ?? Self.defaultTypes
    self.defaultJSONDecoderSetup = defaultJSONDecoderSetup ?? Self.decoder(_:)
    self.defaultXMLDecoderSetup = defaultXMLDecoderSetup ?? Self.decoder(_:)
  }

  let defaultJSONDecoderSetup: (JSONDecoder) -> Void
  let defaultXMLDecoderSetup: (XMLDecoder) -> Void
  let types: [DecodableFeed.Type]

  static let defaultTypes: [DecodableFeed.Type] = [
    RSSFeed.self,
    AtomFeed.self,
    JSONFeed.self
  ]

  lazy var defaultXMLDecoder: XMLDecoder = {
    let decoder = XMLDecoder()
    self.defaultXMLDecoderSetup(decoder)
    return decoder
  }()

  lazy var defaultJSONDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    self.defaultJSONDecoderSetup(decoder)
    return decoder
  }()

  lazy var decodings: [DecoderSource: [AnyDecoding]] = {
    let decodings = types.map { type -> (DecoderSource, AnyDecoding) in
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
        decoder = self.defaultXMLDecoder

      case (.json, .none):
        decoder = self.defaultJSONDecoder
      }

      return (source.source, type.anyDecoding(using: decoder))
    }
    return Dictionary(grouping: decodings, by: { $0.0 }).mapValues { $0.map { $0.1 } }
  }()

  public func decode(_ data: Data) throws -> Feedable {
    var errors = [DecodingError]()

    guard let firstByte = data.first else {
      throw DecodingError.dataCorrupted(
        .init(codingPath: [], debugDescription: "Empty Data.")
      )
    }
    guard let source = DecoderSource(rawValue: firstByte) else {
      throw DecodingError.dataCorrupted(
        .init(codingPath: [], debugDescription: "Unmatched First Byte: \(firstByte)")
      )
    }
    guard let decodings = self.decodings[source] else {
      throw DecodingError.failedAttempts(errors)
    }
    for decoding in decodings {
      do {
        return try decoding.decodeFeed(data: data)
      } catch let decodingError as DecodingError {
        errors.append(decodingError)
      }
    }

    throw DecodingError.failedAttempts(errors)
  }
}
