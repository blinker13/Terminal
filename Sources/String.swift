
internal extension String {

	init(spaces:Int) {
		let whitespace = Character(" ")
		self.init(repeating:whitespace, count:spaces)
	}

	func split(separator:Character) -> [String] {
		let sequence = characters.split(separator:separator)
		return sequence.map(String.init)
	}

	func drop(prefix:String) -> String? {
		guard self.hasPrefix(prefix) else { return nil }
		let slice = self.characters.dropFirst(prefix.characters.count)
		return String(slice)
	}
}
