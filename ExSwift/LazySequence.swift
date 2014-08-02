//
//  LazySequence.swift
//  ExSwift
//
//  Created by pNre on 30/07/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

extension LazySequence {
    
    typealias T = S.GeneratorType.Element
    
    /**
    *  First element of the sequence
    *  @return First element of the sequence if present
    */
    func first () -> T? {
        var generator = self.generate()
        return generator.next()
    }
    
    /**
    *  Checks if call returns true for any element of self
    *  @param getElement Function to call for each element
    *  @return True if call returns true for any element of self
    */
    func any (getElement: (T) -> Bool) -> Bool {
        var generator = self.generate()
        while let nextItem = generator.next() {
            if getElement(nextItem) {
                return true
            }
        }
        return false
    }
    
    /**
    *  Object at the specified index if exists
    *  @param index
    *  @return Object at index in sequence, nil if index is out of bounds
    */
    func get (index: Int) -> T? {
        var generator = self.generate()
        (index - 1).times {
            generator.next()
        }
        return generator.next()
    }
    
}
