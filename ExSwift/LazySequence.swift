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
    
    /**
    *  Objects in the specified range
    *  @param range
    *  @return Subsequence in range
    */
    func get (range: Range<Int>) -> SequenceOf<T> {
        return self.skip(range.startIndex)
                   .take(range.endIndex - range.startIndex)
    }
    
    /**
    *  Index of the first occurrence of item, if found
    *  @param item The item to search for
    *  @return Index of the matched item or nil
    */
    func indexOf <U: Equatable> (item: U) -> Int? {
        var index = 0;
        for current in self {
            if let equatable = current as? U {
                if equatable == item {
                    return index
                }
            }
            index++
        }
        return nil
    }
    
    /**
    *  Subsequence from n to the end of the sequence
    *  @return Sequence from n to the end
    */
    func skip (n: Int) -> SequenceOf<T> {
        var generator =  self.generate();
        for _ in 0..<n {
            generator.next()
        }
        return SequenceOf<T> { generator }
    }
    
    /**
    *  Opposite of filter
    *  @param exclude Function invoked to test elements for exlcusion from the sequence
    *  @return Filtered sequence
    */
    func reject (exclude: (T -> Bool)) -> LazySequence<FilterSequenceView<S>> {
        return self.filter {
            return !exclude($0)
        }
    }
    
    /**
    *  Skips the elements in the sequence up until the condition returns false
    *  @param condition A function which returns a boolean if an element satisfies a given condition or not
    *  @return Elements of the sequence starting with the element which does not meet the condition
    */
    func skipWhile(condition:(T) -> Bool) -> SequenceOf<T> {
        var generator =  self.generate()
        var keepSkipping = true
        while let nextItem = generator.next() {
            if !condition(nextItem) {
                break
            }
        }
        return SequenceOf<T> { generator }
    }
    
    /**
    *  Checks if self contains the item object
    *  @param item The item to search for
    *  @return true if self contains item
    */
    func contains<T:Equatable> (item: T) -> Bool {
        var generator =  self.generate()
        while let nextItem = generator.next() {
            if nextItem as T == item {
                return true
            }
        }
        return false
    }
    
    /**
    *  Returns the first n elements from self
    *  @return First n elements
    */
    func take (n: Int) -> SequenceOf<T> {
        return SequenceOf(TakeSequence(self, n))
    }
    
    /**
    *  Returns the elements of the sequence up until an element does not meet the condition
    *  @param condition A function which returns a boolean if an element satisfies a given condition or not.
    *  @return Elements of the sequence up until an element does not meet the condition
    */
    func takeWhile (condition: (T?) -> Bool) -> SequenceOf<T>  {
        return SequenceOf(TakeWhileSequence(self, condition))
    }
}
