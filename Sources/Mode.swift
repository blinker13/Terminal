
public struct Mode : Flag {

	public let name:String
	public let key:Character?
	public let description:String

	public init(name:String, key:Character?, description:String) {
		(self.name, self.key, self.description) = (name, key, description)
	}
}

public extension Mode {
	static let help = Mode(name:"help", key:"h", description:"Display helpful information")
	static let verbose = Mode(name:"verbose", key:"v", description:"Print extended information")
}
