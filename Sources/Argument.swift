
internal enum Argument {
	case flag(Character)
	case value(String)
	case verb(String)
}

internal extension Argument {

	static func parse(_ parameter:String) -> [Argument] {
		if let string = parameter.drop(prefix:"--") { return parse(verb:string) }
		else if let string = parameter.drop(prefix:"-") { return parse(flag:string) }
		else { return [.value(parameter)] }
	}

	var raw:String {
		switch self {
			case let .flag(parameter): return String(parameter)
			case let .value(parameter): return parameter
			case let .verb(parameter): return parameter
		}
	}

	init?(flag:Character?) {
		guard let key = flag else { return nil }
		self = .flag(key)
	}
}

private extension Argument {

	static func parse(flag parameter:String) -> [Argument] {
		return parameter.characters.map(Argument.flag)
	}

	static func parse(verb parameter:String) -> [Argument] {
		let split = parameter.split(separator:"=")
		let verb:Argument = .verb(split.first!)
		let values = split.dropFirst()
		return [verb] + values.map(Argument.value)
	}

	var prefix:String {
		switch self {
			case .flag: return "-"
			case .value: return ""
			case .verb: return "--"
		}
	}
}

extension Argument : CustomStringConvertible {
	internal var description:String {
		return prefix + raw
	}
}

extension Argument : Hashable {
	internal var hashValue:Int {
		return description.hashValue
	}
}

internal func == (left:Argument, right:Argument) -> Bool {
	return left.hashValue == right.hashValue
}
