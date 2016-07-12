
public struct Block : Command {

	public let name:String
	public let description:String
	public let handler:(Arguments) -> Void

	public init(name:String, description:String, handler:(Arguments) -> Void) {
		(self.name, self.description, self.handler) = (name, description, handler)
	}

	public func run(with arguments: Arguments) {
		handler(arguments)
	}
}
