//
//  ArrayTests.swift
//  Swiftification
//
//  Created by Hilton Campbell on 11/27/15.
//  Copyright © 2015 Hilton Campbell. All rights reserved.
//

import XCTest
@testable import Swiftification

class ArrayTests: XCTestCase {
    
    func testSafe() {
        let array: [Int] = [1, 2, 3]
        XCTAssertNil(array[safe: -1])
        XCTAssertEqual(array[safe: 0], array[0])
        XCTAssertEqual(array[safe: 1], array[1])
        XCTAssertEqual(array[safe: 2], array[2])
        XCTAssertNil(array[safe: 3])
    }
    
}
