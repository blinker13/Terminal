
import XCTest
@testable import Terminal

class ArgumentTests : XCTestCase {

	func test_init() {
		let subject = Argument(flag:"h")
		XCTAssertNotNil(subject)
	}

	func test_init_nil() {
		let subject = Argument(flag:nil)
		XCTAssertNil(subject)
	}

	func test_parse_empty() {
		XCTAssertEqual(Argument.parse(""), [.value("")])
	}
}

class FlagArgumentTests : XCTestCase {

	let subject:Argument = .flag("x")

	func test_raw() {
		XCTAssertEqual(subject.raw, "x")
	}

	func test_description() {
		XCTAssertEqual(subject.description, "-x")
	}

	func test_hashValue() {
		XCTAssertEqual(subject.hashValue, "-x".hashValue)
	}

	func test_parse() {
		XCTAssertEqual(Argument.parse("-x"), [.flag("x")])
		XCTAssertEqual(Argument.parse("-xyz"), [.flag("x"), .flag("y"), .flag("z")])
	}
}

class ValueArgumentTests : XCTestCase {

	let subject:Argument = .value("foo")

	func test_raw() {
		XCTAssertEqual(subject.raw, "foo")
	}

	func test_description() {
		XCTAssertEqual(subject.description, "foo")
	}

	func test_hashValue() {
		XCTAssertEqual(subject.hashValue, "foo".hashValue)
	}

	func test_parse() {
		XCTAssertEqual(Argument.parse("foo"), [.value("foo")])
	}
}

class VerbArgumentTests : XCTestCase {

	let subject:Argument = .verb("bar")

	func test_raw() {
		XCTAssertEqual(subject.raw, "bar")
	}

	func test_description() {
		XCTAssertEqual(subject.description, "--bar")
	}

	func test_hashValue() {
		XCTAssertEqual(subject.hashValue, "--bar".hashValue)
	}

	func test_parse() {
		XCTAssertEqual(Argument.parse("--bar"), [.verb("bar")])
		XCTAssertEqual(Argument.parse("--bar=foo"), [.verb("bar"), .value("foo")])
	}
}
