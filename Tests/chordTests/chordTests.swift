import XCTest
@testable import chord

class chordTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        //XCTAssertEqual(chord().text, "Hello, World!")
    }

    func testSuccessTokenization() {
        let expressions = [
            ("", 0),
            ("   ", 0),
            ("C + 1", 3),
            (" C# - 1", 3),
            (" D# - 1 + 10 ", 5),
            (" C C# D D# E F F# G G# A A# B", 12),
            ("+-+-", 4),
            ("C++100--D#", 7),
            ("Cb  Bb  100  G#", 4),
        ]

        expressions.forEach{
            let tokenizer = Tokenizer(text: $0.0)
            var tokens: [Token] = []
            tokens.append(contentsOf: tokenizer)
            XCTAssert(tokens.count == $0.1)
        }
    }

    func testFailTokenization() {
        let expressions = [
            ("Cb#  Bb  100  G#", 4),
            ("Cbb  Bb  100  G#", 4),
        ]

        expressions.forEach{
            let tokenizer = Tokenizer(text: $0.0)
            var tokens: [Token] = []
            tokens.append(contentsOf: tokenizer)
            XCTAssert(tokens.count != $0.1)
        }
    }

    static var allTests = [
        ("testExample", testExample),
        ("Tokenization Success Cases", testSuccessTokenization),
        ("Tokenization Fail Cases", testFailTokenization)
    ]
}
