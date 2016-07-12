
internal extension Array {
	func successor(_ index:Int) -> Int? {
		return self.index(index, offsetBy:1, limitedBy:endIndex)
	}
}
