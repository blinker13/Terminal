
import XCTest
@testable import Terminal

class ModeTests : XCTestCase {

	let subject = Mode(name:"foo", key:"f", description:"Foooo")

	func test_verb() {
		XCTAssertEqual(subject.verb, .verb("foo"))
	}

	func test_flag() {
		XCTAssertEqual(subject.flag, .flag("f"))
	}

	func test_selectors() {
		XCTAssertEqual(subject.selectors, "--foo, -f")
	}

	func test_signature() {
		XCTAssertEqual(subject.signature, "--foo, -f")
	}

	func test_describeWithDistance() {
		let result = subject.describe(with:10)
		XCTAssertEqual(result, "   --foo, -f    Foooo")
	}

	func test_evaluate() {
		XCTAssertFalse(subject.evaluate(.value("f")))
		XCTAssertFalse(subject.evaluate(.value("foo")))
		XCTAssertFalse(subject.evaluate(.verb("bar")))
		XCTAssertFalse(subject.evaluate(.flag("b")))
		XCTAssertTrue(subject.evaluate(.verb("foo")))
		XCTAssertTrue(subject.evaluate(.flag("f")))
	}
}
