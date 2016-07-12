
import XCTest
@testable import Terminal

class ArgumentsTests : XCTestCase {

	let value = "foo"
	let input = "--bar=test"
	let flag = "-v"
	let verb = "--moo"
	let value2 = "go"

	let expect = [
		Argument.value("foo"),
		Argument.verb("bar"),
		Argument.value("test"),
		Argument.flag("v"),
		Argument.verb("moo"),
		Argument.value("go")
	]

	func test_init() {
		let subject = Arguments([value, input, flag, verb, value2])
		XCTAssertEqual(subject.arguments, expect)
	}

	func test_initWithArraySlice() {
		let subject = Arguments([verb, value2].dropLast())
		XCTAssertEqual(subject.arguments.last, Argument.verb("moo"))
	}

	func test_initWithArrayLiteral() {
		let subject:Arguments = [value, input, flag, verb, value2]
		XCTAssertEqual(subject.arguments, expect)
	}

	func test_parse() {
		let option = Option(name:"bar", description:"", fallback:"foo")
		let subject = Arguments([value, input, flag, verb, value2])
		XCTAssertEqual(subject.parse(option), "test")
	}

	func test_is() {
		let noisy = Mode(name:"noisy", key:"n", description:"")
		let verbose = Mode(name:"verbose", key:"v", description:"")
		let subject = Arguments([value, input, flag, verb, value2])
		XCTAssertTrue(subject.is(verbose))
		XCTAssertFalse(subject.is(noisy))
	}

	func test_next() {
		let subject = Arguments([value, input, flag, verb, value2])
		XCTAssertEqual(subject.next(), value)
		XCTAssertNil(subject.next())
	}
}
