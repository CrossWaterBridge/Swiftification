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

struct EquatableButNotHashable: Equatable {
    let value: Int
}

func == (lhs: EquatableButNotHashable, rhs: EquatableButNotHashable) -> Bool {
    return lhs.value == rhs.value
}

class SequenceTests: XCTestCase {
    func testFirst1() {
        let sequence = [1, 2, 3].makeIterator()
        let expected = 1
        let actual = sequence.first
        XCTAssertEqual(expected, actual)
    }
    
    func testFirst2() {
        let sequence = [Int]().makeIterator()
        let expected: Int? = nil
        let actual = sequence.first
        XCTAssertEqual(expected, actual)
    }
    
    func testTakeWhile1() {
        let array = [1, 2, 3]
        let expected = [1, 2]
        let actual = array.takeWhile { $0 < 3 }
        XCTAssertEqual(expected, actual)
    }
    
    func testTakeWhile2() {
        let array = [1, 2, 3]
        let expected = [Int]()
        let actual = array.takeWhile { _ in false }
        XCTAssertEqual(expected, actual)
    }
    
    func testTakeWhile3() {
        let array = [1, 2, 3]
        let expected = array
        let actual = array.takeWhile { _ in true }
        XCTAssertEqual(expected, actual)
    }
    
    func testUnique1() {
        let array = [1, 1, 2, 2, 3, 4]
        XCTAssertEqual(array.unique(), [1, 2, 3, 4])
    }
    
    func testUnique2() {
        let array = ["happy", "sad", "mad", "glad", "bad", "mad", "bad", "happy", "sad", "mad"]
        XCTAssertEqual(array.unique(), ["happy", "sad", "mad", "glad", "bad"])
    }
    
    func testUnique3() {
        let array = [EquatableButNotHashable(value: 1), EquatableButNotHashable(value: 2), EquatableButNotHashable(value: 1)]
        XCTAssertEqual(array.unique(), [EquatableButNotHashable(value: 1), EquatableButNotHashable(value: 2)])
    }
    
    func testUniqueBy() {
        let array = [(a: 1, b: 1), (a: 1, b: 2), (a: 2, b: 2)]
        let unique = array.unique { $0.a }
        XCTAssertTrue(array.count == 3)
        XCTAssertTrue(unique.count == 2)
    }
    
    func testUniqueByOrder1() {
        let array = [1, 1, 2, 2, 3, 4]
        XCTAssertEqual(array.unique { $0 }, [1, 2, 3, 4])
    }
    
    func testUniqueByOrder2() {
        let array = ["happy", "sad", "mad", "glad", "bad", "mad", "bad", "happy", "sad", "mad"]
        XCTAssertEqual(array.unique { $0 }, ["happy", "sad", "mad", "glad", "bad"])
    }
    
    func testUniqueByOrder3() {
        let array = [
            ["man": "Bob"],
            ["man": "Fred"],
            ["woman": "Sally"],
            ["woman": "Bertha"],
            ["woman": "Jill"]
        ]
        let actual = array.unique { $0.keys.first! }
        let expected = [
            ["man": "Bob"],
            ["woman": "Sally"]
        ]
        
        XCTAssertTrue(actual.elementsEqual(expected) { $0 == $1 })
    }
    
    @available(*, deprecated)
    func testAny() {
        let array = [1, 2, 3]
        XCTAssertTrue(array.any { $0 == 1 })
        XCTAssertFalse(array.any { $0 == 4 })
    }
    
    func testAll() {
        let array = [1, 2, 3]
        XCTAssertTrue(array.all { $0 > 0 })
        XCTAssertFalse(array.all { $0 == 1 })
    }
}
