import XCTest
@testable import rec_rename

final class rec_renameTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(rec_rename().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
