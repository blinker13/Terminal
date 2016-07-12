
import XCTest
import Terminal

struct Loo : Command {

	let description = "Use this for fun"

	let verbose = Mode(name:"verbose", key:"v", description:"Use for extensive logging")
	let bar = Option(name:"bar", description:"barbarbar", fallback:"BANANA")

	func run(with arguments:Arguments) {
		let isVerbose = arguments.is(verbose)
		let value = arguments.parse(bar)

		print("Hello World ->", isVerbose, "--", value)
	}
}

class ToolTests : XCTestCase {

	func test_init() {
		print("==========================================================\n")

		let args = ["help", "loo"]
		let arguments = Arguments(args)


		Tool.run(with:arguments,
			Block(name:"bar", description:"Hello Bar") { print($0) },
			Block(name:"foo", description:"Hello Foo") { print($0) },
			Loo()
		)

		print("\n==========================================================")
	}
}
