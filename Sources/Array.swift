//
// Copyright (c) 2016 Hilton Campbell
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import Foundation

public extension Array {
    /// Access element at `index`. Reading returns the element or `nil` if `index` is out of bounds. Writing only sets if `index` is in bounds.
    subscript(safe index: Int) -> Element? {
        get {
            return (indices ~= index ? self[index] : nil)
        }
        set {
            guard indices ~= index, let newValue = newValue else { return }
            self[index] = newValue
        }
    }
    
    /// Returns the first occurence of item, if found
    func find(where condition: (Element) -> Bool) -> Element? {
        if let index = index(where: { condition($0) }) {
            return self[index]
        }

        return nil
    }
    
    /// Returns a random item
    func random() -> Element {
        return self[Int.random(0..<count)]
    }
    
    /// Randomly rearranges the elements of self using the Fisher-Yates shuffle
    mutating func shuffle() {
        guard count > 1 else { return }
        
        for index in (1..<count).reversed() {
            let newIndex = Int.random(0...index)
            if index != newIndex {
                swap(&self[index], &self[newIndex])
            }
        }
    }
    
    /// Returns a randomly arranged array using the Fisher-Yates shuffle
    func shuffled() -> [Element] {
        var tempArray = self
        tempArray.shuffle()
        
        return tempArray
    }
    
    /// Groups the array into a dictionary by key specified in closure
    func grouped<U>(by groupClosure: (Element) -> U) -> [U: Array] {
        var grouped = [U: Array]()
        for element in self {
            let key = groupClosure(element)
            grouped[key] = (grouped[key] ?? []) + [element]
        }
        
        return grouped
    }
    
    /// Splits the array each time the closure returns a new value.
    func partitioned<T: Equatable>(by closure: (Element) -> T) -> [[Element]] {
        var partitions = [[Element]]()
        var lastValue: T?
        for element in self {
            let value = closure(element)
            if value == lastValue {
                partitions[partitions.count - 1].append(element)
            } else {
                partitions.append([element])
                lastValue = value
            }
        }
        
        return partitions
    }
    
    /// Sections the ordered array by the element specified in the closure, preserving the order of the original array.
    func sectioned<T: Equatable>(by sectionFunction: (Element) -> T) -> [(header: T, items: [Element])] {
        var previousSectionHeader: T? = nil
        var currentGroup = [Element]()
        var allGroups = [(header: T, items: [Element])]()
        
        for item in self {
            let sectionHeader = sectionFunction(item)
            if sectionHeader == previousSectionHeader {
                currentGroup.append(item)
            } else {
                if let previousSectionHeader = previousSectionHeader, !currentGroup.isEmpty {
                    allGroups.append((header: previousSectionHeader, items: currentGroup))
                }
                previousSectionHeader = sectionHeader
                currentGroup = [item]
            }
        }
        
        if let previousSectionHeader = previousSectionHeader, !currentGroup.isEmpty {
            allGroups.append((header: previousSectionHeader, items: currentGroup))
        }
        
        return allGroups
    }
    
    /// Sections the ordered array by the element specified in the closure, preserving the order of the original array.
    func sectioned<T: Equatable>(by sectionFunction: (Element) -> T?) -> [(header: T?, items: [Element])] {
        var previousSectionHeader: T? = nil
        var currentGroup = [Element]()
        var allGroups = [(header: T?, items: [Element])]()
        
        for item in self {
            let sectionHeader = sectionFunction(item)
            if sectionHeader == previousSectionHeader {
                currentGroup.append(item)
            } else {
                if !currentGroup.isEmpty {
                    allGroups.append((header: previousSectionHeader, items: currentGroup))
                }
                previousSectionHeader = sectionHeader
                currentGroup = [item]
            }
        }
        
        if !currentGroup.isEmpty {
            allGroups.append((header: previousSectionHeader, items: currentGroup))
        }
        
        return allGroups
    }
        
    /// Returns an array containing the the last numberOfElements elements of self.
    func tail(_ numberOfElements: Int) -> Array {
        return Array(self[Swift.max(count - numberOfElements, 0)..<count])
    }
    
    /// Returns the first element of self and removes it from the array. Returns `nil` if array is empty.
    mutating func shift() -> Element? {
        if !isEmpty {
            return remove(at: 0)
        }
        return nil
    }
    
    /// Returns an array containing the first n elements of self.
    func take(_ numberOfElements: Int) -> Array {
        return Array(self[0..<Swift.max(Swift.min(numberOfElements, count), 0)])
    }
    
    /// Returns an array containing the remaining elements of self after skipping the first n.
    func skip(_ numberOfElements: Int) -> Array {
        if count > numberOfElements {
            return Array(self[numberOfElements..<count])
        }
        return []
    }
}
