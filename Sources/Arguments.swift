
public final class Arguments {

	internal let arguments:[Argument]
	internal var index:Int

	public init(_ args:[String] = Process.arguments) {
		let slices = args.map(Argument.parse)
		let arguments = slices.flatMap { $0 }
		self.index = arguments.startIndex
		self.arguments = arguments
	}
}

public extension Arguments {

	convenience init(_ slice:ArraySlice<String>) {
		let args = Array(slice)
		self.init(args)
	}

	func parse<Value>(_ option:Option<Value>) -> Value {
		let arg = value(where:option)
		return option.extract(arg)
	}

	func `is`(_ flag:Flag) -> Bool {
		return index(where:flag.evaluate) != nil
	}
}

private extension Arguments {

	func value<Value>(where option:Option<Value>) -> Value.StringLiteralType? {
		guard let index = index(where:option.evaluate) else { return nil }
		guard let next = arguments.successor(index) else { return nil }
		guard case let .value(value) = arguments[next] else { return nil }
		return value as? Value.StringLiteralType
	}

	func index(where evaluate:(Argument) -> Bool) -> Int? {
		return arguments.index(where:evaluate)
	}
}

extension Arguments : ArrayLiteralConvertible {
	public convenience init(arrayLiteral args:String ...) {
		self.init(args)
	}
}

extension Arguments : Sequence, IteratorProtocol {

	public func next() -> String? {
		guard index < arguments.endIndex else { return nil }
		guard case let .value(value) = arguments[index] else { return nil }
		defer { index = arguments.index(index, offsetBy:1) }
		return value
	}
}
