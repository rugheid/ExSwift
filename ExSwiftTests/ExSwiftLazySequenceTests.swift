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
        XCTAssertEqual(sequence.first()!, 1)
    }
    
    func testFirstEmptySequence () {
        XCTAssertNil(emptySequence.first())
    }
    
    func testSkip () {
        XCTAssertEqualArrays(sequence.skip(2).array, [3, 4, 5])
    }
    
    func testSkipBeyondEnd () {
        XCTAssertEqualArrays(sequence.skip(8).array, [])
    }
    
    func testSkipWhile () {
        XCTAssertEqualArrays(sequence.skipWhile { $0 < 3 }.array, [4, 5])
    }
    
    func testSkipWhileBeyondEnd () {
        var skipped = SequenceOf(sequence).skipWhile { $0 < 20 }
        XCTAssertEqualArrays(Array(skipped), [])
    }
    
    func testContains () {
        XCTAssertTrue(SequenceOf(sequence).contains(1))
        XCTAssertFalse(SequenceOf(sequence).contains(56))
    }
    
    func testTake () {
        var take = SequenceOf(sequence).take(2)
        XCTAssertEqualArrays(Array(take), [1, 2])
    }
    
    func testTakeBeyondSequenceEnd () {
        var take = SequenceOf(sequence).take(20)
        XCTAssertEqualArrays(Array(take), [1, 2, 3, 4, 5])
    }
    
    func testTakeWhile () {
        var take = SequenceOf(sequence).takeWhile { $0 != 3 }
        XCTAssertEqualArrays(Array(take), [1, 2])
    }
    
    func testTakeWhileConditionNeverTrue () {
        var take = SequenceOf(sequence).takeWhile { $0 == 7 }
        XCTAssertEqualArrays(Array(take), [])
    }
    
    func testTakeWhileConditionNotMet () {
        var take = SequenceOf(sequence).takeWhile { $0 != 7 }
        XCTAssertEqualArrays(Array(take), [1, 2, 3, 4, 5])
    }
    
    func testIndexOf () {
        XCTAssertEqual(SequenceOf(sequence).indexOf(2)!, 1)
        XCTAssertNil(SequenceOf(sequence).indexOf(77))
    }
    
    func testGet () {
        XCTAssertEqual(SequenceOf(sequence).get(3)!, 3)
        XCTAssertNil(SequenceOf(sequence).get(22))
    }
    
    func testGetRange () {
        var subSequence = SequenceOf(sequence).get(1..<3)
        XCTAssertEqualArrays(Array(subSequence), [2, 3])
        
        subSequence = SequenceOf(sequence).get(0..<0)
        XCTAssertEqualArrays(Array(subSequence), [])
    }
    
    func testGetRangeOutOfBounds () {
        var subSequence = SequenceOf(sequence).get(10..<15)
        XCTAssertEqualArrays(Array(subSequence), [])
    }
    
    func testAny () {
        XCTAssertTrue(SequenceOf(sequence).any { $0 == 1 })
        XCTAssertFalse(SequenceOf(sequence).any { $0 == 77 })
    }
    
    func testFilter () {
        var evens = SequenceOf(sequence).filter { $0 % 2 == 0 }
        XCTAssertEqualArrays(Array(evens), [2, 4])
        
        var odds = SequenceOf(sequence).filter { $0 % 2 == 1 }
        XCTAssertEqualArrays(Array(odds), [1, 3, 5])
        
        var all = SequenceOf(sequence).filter { $0 < 10 }
        XCTAssertEqualArrays(Array(all), [1, 2, 3, 4, 5])
        
        var none = SequenceOf(sequence).filter { $0 > 10 }
        XCTAssertEqualArrays(Array(none), [])
    }
    
    func testReject () {
        var rejected = SequenceOf(sequence).reject { $0 == 3 }
        XCTAssertEqualArrays(Array(rejected), [1, 2, 4, 5])
        
        rejected = SequenceOf(sequence).reject { $0 == 1 }
        XCTAssertEqualArrays(Array(rejected), [2, 3, 4, 5])
        
        rejected = SequenceOf(sequence).reject { $0 == 10 }
        XCTAssertEqualArrays(Array(rejected), [1, 2, 3, 4, 5])
    }
}
