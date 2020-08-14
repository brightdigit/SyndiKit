extension Array where Element == [String] {
  func crossReduce() -> [[String]] {
    reduce([[String]]()) { (arrays, newPaths) -> [[String]] in
      if arrays.count > 0 {
        return arrays.flatMap { (array) -> [[String]] in
          newPaths.map { (newPath) -> [String] in
            var newArray = array
            newArray.append(newPath)
            return newArray
          }
        }
      } else {
        return newPaths.map { [$0] }
      }
    }
  }
}
