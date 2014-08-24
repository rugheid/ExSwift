//
//  ExSwiftLazySequenceTests.swift
//  ExSwift
//
//  Created by pNre on 30/07/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import XCTest

class ExSwiftLazySequenceTests: XCTestCase {
    
    let sequence = lazy(1...5) as LazySequence
    let emptySequence = lazy(1..<1) as LazySequence

    func testFirst () {
        XCTAssertEqual(sequence.first!, 1)
    }
    
    func testFirstEmptySequence () {
        XCTAssertNil(emptySequence.first)
    }
    
    func testSkip () {
        XCTAssertEqual(sequence.skip(2).array, [3, 4, 5])
    }
    
    func testSkipBeyondEnd () {
        XCTAssertTrue(sequence.skip(8).array.isEmpty)
    }
    
    func testSkipWhile () {
        XCTAssertEqual(sequence.skipWhile { $0 < 3 }.array, [4, 5])
    }
    
    func testSkipWhileBeyondEnd () {
        XCTAssertTrue(sequence.skipWhile { $0 < 20 }.array.isEmpty)
    }
    
    func testContains () {
        XCTAssertTrue(sequence.contains(1))
        XCTAssertFalse(sequence.contains(56))
    }
    
    func testTake () {
        XCTAssertEqual(sequence.take(2).array, [1, 2])
    }
    
    func testTakeBeyondSequenceEnd () {
        XCTAssertEqual(sequence.take(20).array, [1, 2, 3, 4, 5])
    }
    
    func testTakeWhile () {
        XCTAssertEqual(sequence.takeWhile { $0 != 3 }.array, [1, 2])
    }
    
    func testTakeWhileConditionNeverTrue () {
        XCTAssertTrue(sequence.takeWhile { $0 == 7 }.array.isEmpty)
    }
    
    func testTakeWhileConditionNotMet () {
        XCTAssertEqual(sequence.takeWhile { $0 != 7 }.array, [1, 2, 3, 4, 5])
    }
    
    func testIndexOf () {
        XCTAssertEqual(sequence.indexOf(2)!, 1)
        XCTAssertNil(sequence.indexOf(77))
    }
    
    func testGet () {
        XCTAssertEqual(sequence.get(3)!, 3)
        XCTAssertNil(sequence.get(22))
    }
    
    func testGetRange () {
        XCTAssertEqual(sequence.get(1..<3).array, [2, 3])
        XCTAssertTrue(sequence.get(0..<0).array.isEmpty)
    }
    
    func testGetRangeOutOfBounds () {
        XCTAssertTrue(sequence.get(10..<15).array.isEmpty)
    }
    
    func testAny () {
        XCTAssertTrue(sequence.any { $0 == 1 })
        XCTAssertFalse(sequence.any { $0 == 77 })
    }
    
    func testReject () {
        var rejected = sequence.reject { $0 == 3 }
        XCTAssertEqual(rejected.array, [1, 2, 4, 5])
        
        rejected = sequence.reject { $0 == 1 }
        XCTAssertEqual(rejected.array, [2, 3, 4, 5])
        
        rejected = sequence.reject { $0 == 10 }
        XCTAssertEqual(rejected.array, [1, 2, 3, 4, 5])
    }
}
