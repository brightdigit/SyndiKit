//
//  File.swift
//  
//
//  Created by Leo Dion on 6/26/21.
//

import Foundation
struct Decoding<DecoderType: TypeDecoder, DecodingType: Decodable> {
  let decoder: DecoderType

  init(for _: DecodingType.Type, using decoder: DecoderType) {
    self.decoder = decoder
  }

  func decode(data: Data) throws -> DecodingType {
    return try decoder.decode(DecodingType.self, from: data)
  }
}
