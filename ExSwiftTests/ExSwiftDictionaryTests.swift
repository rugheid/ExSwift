//
//  ExSwiftDictionaryTests.swift
//  ExSwift
//
//  Created by pNre on 04/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import XCTest

class ExSwiftDictionaryTests: XCTestCase {
    
    var dictionary = [
        "A": 1,
        "B": 2,
        "C": 3
    ]
    
    func testHas() {
        XCTAssertTrue(dictionary.has("A"))
        XCTAssertFalse(dictionary.has("Z"))
    }

    func testMapValues() {
        let mapped = dictionary.mapValues(mapFunction: { return $1 + 1 })
        XCTAssert(mapped == ["A": 2, "B": 3, "C": 4])
    }
    
    func testMap() {
        let mapped = dictionary.map(mapFunction: { return ($0 + "A", $1 + 1) })
        XCTAssert(mapped == ["AA": 2, "BA": 3, "CA": 4])
    }
    
    func testFilter() {
        let filtered = dictionary.filter {
            (key: String, Value: Int) in
            return key != "A"
        }
        
        XCTAssert(filtered == ["B": 2, "C": 3])
    }

    func testIsEmpty() {
        let e = Dictionary<String, String>()

        XCTAssertTrue(e.isEmpty())
        XCTAssertFalse(dictionary.isEmpty())
    }

    func testMerge() {
        let a = dictionary.merge([ "D": 4 ])
        
        XCTAssert(a == ["A": 1, "B": 2, "C": 3, "D": 4])
    }

    func testShift() {
        let (key, value) = dictionary.shift()
        
        XCTAssertEqual(2, dictionary.count)
        XCTAssertNotNil(key)
        XCTAssertNotNil(value)
    }
    
}