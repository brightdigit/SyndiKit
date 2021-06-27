//
//  File.swift
//  
//
//  Created by Leo Dion on 6/26/21.
//

import Foundation
import XMLCoder

protocol TypeDecoder {
  func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
}

extension JSONDecoder: TypeDecoder {}

extension XMLDecoder: TypeDecoder {}

