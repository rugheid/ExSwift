//
//  ExSwiftCharacterTests.swift
//  ExSwift
//
//  Created by Rugen Heidbuchel on 01/11/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation
import XCTest

class CharacterExtensionsTests: XCTestCase {
    
    func testUnicharValue () {
        
        let expected: unichar = 49
        let result = Character("1").unicharValue
        XCTAssertEqual(expected, result)
    }
    
}