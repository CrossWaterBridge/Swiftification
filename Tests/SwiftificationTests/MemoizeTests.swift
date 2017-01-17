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

class MemoizeTests: XCTestCase {
    
    func testZeroArgMemoize() {
        var i = 0
        let f: () -> Int = {
            i += 1
            return i
        }
        let memoized = memoize(f)
        XCTAssertEqual(memoized(), 1)
        XCTAssertEqual(memoized(), 1)
    }
    
    func testOneArgMemoize() {
        var i = 0
        let f: (Int) -> Int = { j in
            i += 1
            return i + j
        }
        let memoized = memoize(f)
        XCTAssertEqual(memoized(1), 2)
        XCTAssertEqual(memoized(1), 2)
        XCTAssertEqual(memoized(2), 4)
        XCTAssertEqual(memoized(1), 2)
        XCTAssertEqual(memoized(3), 6)
    }
    
}
