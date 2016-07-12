
public protocol Flag : CustomStringConvertible {	
	var description:String { get }
	var key:Character? { get }
	var name:String { get }
}

internal extension Flag {

	var verb:Argument { return .verb(name) }
	var flag:Argument? { return Argument(flag:key) }

	var selectors:String {
		var components = [verb.description]
		if let flag = flag?.description { components += [flag] }
		return components.joined(separator:", ")
	}

	var signature:String {
		return selectors
	}

	func describe(with distance:Int) -> String {
		let whitespace = String(spaces:distance - signature.characters.count)
		return Help.padding + signature + whitespace + Help.padding + description
	}

	func evaluate(_ argument:Argument) -> Bool {
		return argument == verb || argument == flag
	}
}
