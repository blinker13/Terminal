
public struct Tool : Command {

	public let commands:[Command]
	public let name:String

	public var info:String {
		let length = commands.reduce(0) { max($0, $1.name.characters.count) }
		let descriptions = commands.map { $0.describe(with:length) }
		return descriptions.joined(separator:"\n")
	}

	public var description:String {
		let components = ["Available commands in \(name):\n", info]
		return components.joined(separator:"\n")
	}

	public init(_ name:String, _ commands:[Command]) {
		(self.commands, self.name) = (commands, name)
	}

	public func run(with arguments:Arguments = Tool.arguments) {
		guard let key = arguments.next() else { return help(with:arguments) }
		guard let command = self[key] else { return help(with:arguments) }
		command.run(with:arguments)
	}
}

public extension Tool {

	static var arguments:Arguments {
		let slice = Process.arguments.dropFirst()
		return Arguments(slice)
	}

	static var name:String {
		let components = path.split(separator:"/")
		return components.last!
	}

	static var path:String {
		return Process.arguments.first!
	}

	static func run(with arguments:Arguments = arguments, _ commands:Command ...) {
		let tool = Tool(name, commands)
		tool.run(with:arguments)
	}
}

internal extension Tool {
	subscript (key:String) -> Command? {
		return commands.first {
			$0.name == key
		}
	}
}

private extension Tool {
	func help(with arguments:Arguments) {
		let help = Help(tool:self)
		help.run(with:arguments)
	}
}
