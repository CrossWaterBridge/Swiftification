//
// Copyright (c) 2016 Hilton Campbell
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

class NSRegularExpressionTests: XCTestCase {
    
    func testFirstMatch() throws {
        let string = "The quick brown fox jumps over the lazy dog"
        
        let regex = try NSRegularExpression(pattern: " ", options: [])
        let result1 = regex.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.count))!
        let result2 = regex.firstMatch(in: string)!
        
        XCTAssertEqual(result1.numberOfRanges, result2.numberOfRanges)
        for i in 0..<result1.numberOfRanges {
            XCTAssertEqual(result1.range(at: i), result2.range(at: i))
        }
    }
    
    func testFirstMatchWithRange() throws {
        let string = "The quick brown fox jumps over the lazy dog"
        
        let nsRange = NSRange(location: 4, length: 11)
        let startIndex = string.index(string.startIndex, offsetBy: 4)
        let swiftRange = startIndex..<string.index(startIndex, offsetBy: 11)
        
        let regex = try NSRegularExpression(pattern: " ", options: [])
        let result1 = regex.firstMatch(in: string, options: [], range: nsRange)!
        let result2 = regex.firstMatch(in: string, range: swiftRange)!
        
        XCTAssertEqual(result1.numberOfRanges, result2.numberOfRanges)
        for i in 0..<result1.numberOfRanges {
            XCTAssertEqual(result1.range(at: i), result2.range(at: i))
        }
    }
    
    func testMatches() throws {
        let string = "The quick brown fox jumps over the lazy dog"
        
        let regex = try NSRegularExpression(pattern: " ", options: [])
        let matches1 = regex.matches(in: string, options: [], range: NSRange(location: 0, length: string.count))
        let matches2 = regex.matches(in: string)
        
        XCTAssertEqual(matches1.count, matches2.count)
        for (index, result1) in matches1.enumerated() {
            let result2 = matches2[index]
            XCTAssertEqual(result1.numberOfRanges, result2.numberOfRanges)
            for i in 0..<result1.numberOfRanges {
                XCTAssertEqual(result1.range(at: i), result2.range(at: i))
            }
        }
    }
    
    func testMatchesWithRange() throws {
        let string = "The quick brown fox jumps over the lazy dog"
        
        let nsRange = NSRange(location: 4, length: 11)
        let startIndex = string.index(string.startIndex, offsetBy: 4)
        let swiftRange = startIndex..<string.index(startIndex, offsetBy: 11)
        
        let regex = try NSRegularExpression(pattern: " ", options: [])
        let matches1 = regex.matches(in: string, range: nsRange)
        let matches2 = regex.matches(in: string, range: swiftRange)
        
        XCTAssertEqual(matches1.count, matches2.count)
        for (index, result1) in matches1.enumerated() {
            let result2 = matches2[index]
            XCTAssertEqual(result1.numberOfRanges, result2.numberOfRanges)
            for i in 0..<result1.numberOfRanges {
                XCTAssertEqual(result1.range(at: i), result2.range(at: i))
            }
        }
    }
    
    func testNumberOfMatches() throws {
        let string = "The quick brown fox jumps over the lazy dog"
        
        let regex = try NSRegularExpression(pattern: " ", options: [])
        let numberOfMatches1 = regex.numberOfMatches(in: string, options: [], range: NSRange(location: 0, length: string.count))
        let numberOfMatches2 = regex.numberOfMatches(in: string)
        
        XCTAssertEqual(numberOfMatches1, 8)
        XCTAssertEqual(numberOfMatches1, numberOfMatches2)
    }
    
    func testNumberOfMatchesWithRange() throws {
        let string = "The quick brown fox jumps over the lazy dog"
        
        let nsRange = NSRange(location: 4, length: 11)
        let startIndex = string.index(string.startIndex, offsetBy: 4)
        let swiftRange = startIndex..<string.index(startIndex, offsetBy: 11)
        
        let regex = try NSRegularExpression(pattern: " ", options: [])
        let numberOfMatches1 = regex.numberOfMatches(in: string, options: [], range: nsRange)
        let numberOfMatches2 = regex.numberOfMatches(in: string, range: swiftRange)
        
        XCTAssertEqual(numberOfMatches1, 1)
        XCTAssertEqual(numberOfMatches1, numberOfMatches2)
    }
    
    func testStringByReplacingMatches() throws {
        let string = "The quick brown fox jumps over the lazy dog"
        
        let regex = try NSRegularExpression(pattern: "fox", options: [])
        let replaced = regex.stringByReplacingMatches(in: string) { _, _ -> String? in
            return "hen"
        }
        XCTAssertEqual("The quick brown hen jumps over the lazy dog", replaced)
    }
    
    func testStringByReplacingMatchesWithRange() throws {
        let string = "The quick brown fox jumps over the lazy dog"
        let range = string.range(of: "fox jumps")!
        
        let regex1 = try NSRegularExpression(pattern: "fox", options: [])
        let replaced1 = regex1.stringByReplacingMatches(in: string, range: range) { _, _ -> String? in
            return "hen"
        }
        XCTAssertEqual("The quick brown hen jumps over the lazy dog", replaced1)
        
        let regex2 = try NSRegularExpression(pattern: "dog", options: [])
        let replaced2 = regex2.stringByReplacingMatches(in: string, range: range) { _, _ -> String? in
            return "cat"
        }
        XCTAssertEqual(string, replaced2)
    }
    
}
