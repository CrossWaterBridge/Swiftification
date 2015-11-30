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

class DictionaryTests: XCTestCase {
    
    func testUnion1() {
        let dict1 = [1: 1, 2: 2, 3: 3]
        let dict2 = [1: 4]
        let expected = [1: 4, 2: 2, 3: 3]
        let actual = dict1.union(dict2)
        XCTAssertEqual(expected, actual)
    }
    
    func testUnion2() {
        let dict1 = [1: 2]
        let dict2 = [3: 4]
        let expected = [1: 2, 3: 4]
        let actual = dict1.union(dict2)
        XCTAssertEqual(expected, actual)
    }
    
    func testUnionOperator1() {
        let dict1 = [1: 1, 2: 2, 3: 3]
        let dict2 = [1: 4]
        let expected = [1: 4, 2: 2, 3: 3]
        let actual = dict1 | dict2
        XCTAssertEqual(expected, actual)
    }
    
    func testUnionOperator2() {
        let dict1 = [1: 2]
        let dict2 = [3: 4]
        let expected = [1: 2, 3: 4]
        let actual = dict1 | dict2
        XCTAssertEqual(expected, actual)
    }
    
}
