//
// Copyright (c) 2015 Hilton Campbell
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

class ArrayTests: XCTestCase {
    
    func testSafe() {
        let array: [Int] = [1, 2, 3]
        XCTAssertNil(array[safe: -1])
        XCTAssertEqual(array[safe: 0], array[0])
        XCTAssertEqual(array[safe: 1], array[1])
        XCTAssertEqual(array[safe: 2], array[2])
        XCTAssertNil(array[safe: 3])
    }
    
    func testRandom() {
        let array = Array(1...10)
        for var index = 0; index < 500; index++ {
            let random = array.random()
            XCTAssertTrue(random <= 10 && random >= 1)
        }
    }
    
    func testFind() {
        let array = Array(1...10)
        XCTAssertNotNil(array.find { $0 == 2 })
        XCTAssertNil(array.find { $0 == 15 })
    }
    
    func testShuffled() {
        let array = Array(1...10)
        let shuffledArray = array.shuffled()
        XCTAssertTrue(array == Array(1...10))
        XCTAssertTrue(shuffledArray != Array(1...10))
        for value in shuffledArray {
            XCTAssertTrue(value >= 1 && value <= 10)
        }
    }
    
    func testShuffleInPlace() {
        var array = Array(1...10)
        array.shuffleInPlace()
        XCTAssertTrue(array != Array(1...10))
    }
    
}
