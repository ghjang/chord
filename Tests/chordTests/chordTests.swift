import XCTest
@testable import chord

class chordTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        //XCTAssertEqual(chord().text, "Hello, World!")
    }

    func testTokenization() {
        let expr = "C + 1"

        guard let tokenizer = Tokenizer(text: expr) else { return }

        for token in tokenizer {
            print(token)
        }
    }

    static var allTests = [
        ("testExample", testExample),
        ("Tokenization", testTokenization)
    ]
}
