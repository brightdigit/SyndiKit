extension Dictionary {
  internal mutating func formUnion<SequenceType: Sequence, ElementType>(
    _ collection: SequenceType,
    key: Key
  ) where Value == Set<ElementType>, SequenceType.Element == ElementType {
    if let set = self[key] {
      self[key] = set.union(collection)
    } else {
      self[key] = Set(collection)
    }
  }
}
