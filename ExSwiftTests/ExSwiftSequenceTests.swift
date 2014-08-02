//
//  ExSwiftSequenceTests.swift
//  ExSwift
//
//  Created by Colin Eberhardt on 24/06/2014.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import XCTest

class ExtensionsSequenceTests: XCTestCase {
    
    let sequence = 1...5
    let emptySequence = 1..<1
    
    func testFirst () {
        let first = SequenceOf(sequence).first()
        XCTAssertEqual(first!, 1)
    }
    
    func testFirstEmptySequence () {
        let first = SequenceOf(emptySequence).first()
        XCTAssertNil(first)
    }
    
    func testSkip () {
        let skipped = SequenceOf(sequence).skip(2)
        XCTAssertEqualArrays(Array(skipped), [3, 4, 5])
    }
    
    func testSkipBeyondEnd () {
        let skipped = SequenceOf(sequence).skip(8)
        XCTAssertEqualArrays(Array(skipped), [])
    }
    
    func testSkipWhile () {
        let skipped = SequenceOf(sequence).skipWhile { $0 < 3 }
        XCTAssertEqualArrays(Array(skipped), [4, 5])
    }
    
    func testSkipWhileBeyondEnd () {
        let skipped = SequenceOf(sequence).skipWhile { $0 < 20 }
        XCTAssertEqualArrays(Array(skipped), [])
    }
    
    func testContains () {
        XCTAssertTrue(SequenceOf(sequence).contains(1))
        XCTAssertFalse(SequenceOf(sequence).contains(56))
    }
    
    func testTake () {
        let take = SequenceOf(sequence).take(2)
        XCTAssertEqualArrays(Array(take), [1, 2])
    }
    
    func testTakeBeyondSequenceEnd () {
        let take = SequenceOf(sequence).take(20)
        XCTAssertEqualArrays(Array(take), [1, 2, 3, 4, 5])
    }
    
    func testTakeWhile () {
        let take = SequenceOf(sequence).takeWhile { $0 != 3 }
        XCTAssertEqualArrays(Array(take), [1, 2])
    }
    
    func testTakeWhileConditionNeverTrue () {
        let take = SequenceOf(sequence).takeWhile { $0 == 7 }
        XCTAssertEqualArrays(Array(take), [])
    }
    
    func testTakeWhileConditionNotMet () {
        let take = SequenceOf(sequence).takeWhile { $0 != 7 }
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
        let subSequence = SequenceOf(sequence).get(10..<15)
        XCTAssertEqualArrays(Array(subSequence), [])
    }
    
    func testAny () {
        XCTAssertTrue(SequenceOf(sequence).any { $0 == 1 })
        XCTAssertFalse(SequenceOf(sequence).any { $0 == 77 })
    }
    
    func testFilter () {
        let evens = SequenceOf(sequence).filter { $0 % 2 == 0 }
        XCTAssertEqualArrays(Array(evens), [2, 4])
        
        let odds = SequenceOf(sequence).filter { $0 % 2 == 1 }
        XCTAssertEqualArrays(Array(odds), [1, 3, 5])
        
        let all = SequenceOf(sequence).filter { $0 < 10 }
        XCTAssertEqualArrays(Array(all), [1, 2, 3, 4, 5])
        
        let none = SequenceOf(sequence).filter { $0 > 10 }
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