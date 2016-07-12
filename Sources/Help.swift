
public struct Help : Command {

	public var description:String {
		return "Display help information about \(tool.name)"
	}

	private let tool:Tool

	public init(tool:Tool) {
		self.tool = tool
	}

	public func run(with arguments:Arguments) {
		guard let key = arguments.next() else { return print(tool) }
		if let command = tool[key] { return display(command) }
		display(unrecognized:key)
	}
}

internal extension Help {
	static let padding = String(spaces:3)
}

private extension Help {

	func display(_ command:Command) {
		print(command.description)
		print(command.flags)
	}

	func display(unrecognized key:String) {
		print("Unrecognized command:", key)
		print(tool)
	}
}
