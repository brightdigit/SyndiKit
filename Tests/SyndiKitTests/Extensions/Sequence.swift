extension Sequence {
  internal func mapPairResult<Success>(
    _ transform: @escaping (Element) throws -> Success
  ) -> [(Element, Result<Success, Error>)] {
    map { element in
      (element, Result { try transform(element) })
    }
  }

  internal func mapResult<Success>(
    _ transform: @escaping (Element) throws -> Success
  ) -> [Result<Success, Error>] {
    map { element in
      Result { try transform(element) }
    }
  }

  internal func flatResultMapValue<SuccessKey, SuccessValue, NewSuccess>(
    _ transform: @escaping (SuccessValue) throws -> NewSuccess
  ) -> [(SuccessKey, Result<NewSuccess, Error>)]
    where Element == (SuccessKey, Result<SuccessValue, Error>) {
    map {
      let value = $0.1.flatMap { value in
        Result { try transform(value) }
      }
      return ($0.0, value)
    }
  }

  internal func flatResultMap<Success, NewSuccess>(
    _ transform: @escaping (Success) throws -> NewSuccess
  ) -> [Result<NewSuccess, Error>]
    where Element == Result<Success, Error> {
    map {
      $0.flatMap { success in
        Result {
          try transform(success)
        }
      }
    }
  }
}
