
public struct Option<Value:StringLiteralConvertible> : Flag {

	public let name:String
	public let key:Character?
	public let description:String
	public let fallback:Value

	public init(name:String, key:Character? = nil, description:String, fallback:Value) {
		(self.name, self.key, self.description, self.fallback) = (name, key, description, fallback)
	}
}

internal extension Option {
	func extract(_ arg:Value.StringLiteralType?) -> Value {
		guard let literal = arg else { return fallback }
		return Value(stringLiteral:literal)
	}
}
