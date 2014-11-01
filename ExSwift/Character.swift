//
//  Character.swift
//  ExSwift
//
//  Created by Rugen Heidbuchel on 01/11/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

public extension Character {
    
    /**
    Returns the unichar value.
    
    :returns: The unichar value of the receiver.
    */
    var unicharValue: unichar {
        return NSString(string: "\(self)").characterAtIndex(0)
    }
}