//
//  CollectionTypeTests.swift
//  Swiftification
//
//  Created by Hilton Campbell on 11/27/15.
//  Copyright © 2015 Hilton Campbell. All rights reserved.
//

import XCTest
@testable import Swiftification

class CollectionTypeTests: XCTestCase {
    
    func testMapFilter() {
        let array = [1, 2, 3]
        let expected = ["1", "2", "3"]
        let actual = array.map { "\($0)" }
        XCTAssertEqual(expected, actual)
    }
    
    func testTakeFirst() {
        let array = [1, 2, 3]
        let expected = 3
        let actual = array.takeFirst { $0 > 2 }
        XCTAssertEqual(expected, actual)
    }
    
}
