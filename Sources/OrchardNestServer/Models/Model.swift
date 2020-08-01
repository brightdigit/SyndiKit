import Fluent

extension Model {
  static func dictionary<IDType>(from elements: [Self]) -> [IDType: Self] where IDType == Self.IDValue {
    return Dictionary(uniqueKeysWithValues:
      elements.compactMap { model in
        model.id.map { ($0, model) }
      }
    )
  }
}
