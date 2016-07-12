
public protocol Command : CustomStringConvertible {

	var description:String { get }
	var name:String { get }

	func run(with arguments:Arguments)
}

public extension Command {

	var name:String {
		let type = String(self.dynamicType)
		return type.lowercased()
	}

	var flags:String {
		let mirror = Mirror(reflecting:self)
		let flags = mirror.children.flatMap { $0.value as? Flag }
		let length = flags.reduce(0) { max($0, $1.signature.characters.count) }
		let descriptions = flags.map { $0.describe(with:length) }
		return descriptions.joined(separator:"\n")
	}

	func run(with args:[String]) {
		let arguments = Arguments(args)
		run(with:arguments)
	}

	func run(with slice:ArraySlice<String>) {
		let values = Array(slice)
		run(with:values)
	}

	func run(with arguments:String ...) {
		run(with:arguments)
	}
}

internal extension Command {
	func describe(with distance:Int) -> String {
		let whitespace = String(spaces:distance - name.characters.count)
		return Help.padding + name + whitespace + Help.padding + description
	}
}

internal func length(command:Command) -> Int {
	return command.name.characters.count
}
