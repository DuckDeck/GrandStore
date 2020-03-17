import XCTest
@testable import GrandStore

final class GrandStoreTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(GrandStore().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
