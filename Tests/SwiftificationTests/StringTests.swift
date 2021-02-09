//
// Copyright (c) 2019 Hilton Campbell
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import XCTest
import Swiftification

class StringTests: XCTestCase {
    
    func testTrimmed() {
        let string = "\n       Test        "
        XCTAssertEqual(string.trimmed(), "Test")
    }
    
    func testRandomZeroLength() {
        for _ in 0...500 {
            XCTAssertTrue(String.random(0) == "")
        }
    }
    
    func testRandomDefaultLength() {
        for _ in 0...500 {
            let random = String.random()
            XCTAssertTrue(random.count >= 8)
            XCTAssertTrue(random.count <= 64)
        }
    }
    
    func testRandomLength() {
        for i in 0...500 {
            XCTAssertTrue(String.random(i).count == i)
        }
    }
    
    func testRandomZeroCharacters() {
        for _ in 0...500 {
            XCTAssertTrue(String.random(characters: "") == "")
        }
    }
    
    func testRandomDefaultCharacters() {
        let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz012345789"
        let random = String.random(500)
        for i in 0..<random.count {
            let index = random.index(random.startIndex, offsetBy: i)
            let character = random[index]
            XCTAssertNotNil(characters.range(of: String(character)))
        }
    }
    
    func testRandomCharacters() {
        let characters = "ABCDE"
        let random = String.random(500, characters: characters)
        for i in 0..<random.count {
            let index = random.index(random.startIndex, offsetBy: i)
            let character = random[index]
            XCTAssertNotNil(characters.range(of: String(character)))
        }
    }
    
    func testSafeSubscript() {
        let str = "Hi"
        XCTAssertEqual(str[str.index(str.startIndex, offsetBy: 1)], str[safe: str.index(str.startIndex, offsetBy: 1)]!)
    }
    
    func testAppendAndPrependOptionalString() {
        let str1: String? = "Hi"
        let str2: String? = " Bob "
        let strNil: String? = nil
        let nonNilString = "I'm not Nil!"
        XCTAssertEqual(str1 + str2, "Hi Bob ")
        XCTAssertEqual(str2 + str1, " Bob Hi")
        XCTAssertEqual(str1 + strNil, "Hi")
        XCTAssertEqual(strNil + str1, "Hi")
        XCTAssertEqual(nonNilString + str1, "I'm not Nil!Hi")
        XCTAssertEqual(str1 + nonNilString, "HiI'm not Nil!")
        XCTAssertEqual(strNil + nonNilString, "I'm not Nil!")
        XCTAssertEqual(nonNilString + strNil, "I'm not Nil!")
    }
    
    func testInsertAtIndex() {
        XCTAssertEqual("string".inserting("TEST", at: 0), "TESTstring")
        XCTAssertEqual("string".inserting("TEST", at: 3), "strTESTing")
        XCTAssertEqual("string".inserting("TEST", at: 100), "stringTEST")
    }
    
    func testMD5() {
        let string = "This is a string"
        XCTAssertEqual(string.md5(), "41fb5b5ae4d57c5ee528adb00e5e8e74")
    }

    func testRange() {
        let string = "Test String"
        XCTAssertEqual(string.range, string.startIndex..<string.endIndex)
    }
    
    func testNSRange() {
        let string = "Test String"
        XCTAssertEqual(string.nsRange, NSRange(location: 0, length: string.count))
    }
    
}
