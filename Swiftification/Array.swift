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
    func find(condition: (Element) -> Bool) -> Element? {
        if let index = indexOf({ condition($0) }) {
            return self[index]
        }

        return nil
    }
    
    /// Returns a random item
    func random() -> Element {
        return self[Int.random(0..<count)]
    }
    
    /// Randomly rearranges the elements of self using the Fisher-Yates shuffle
    mutating func shuffleInPlace() {
        guard count > 1 else { return }
        
        for index in (1..<count).reverse() {
            let newIndex = Int.random(0...index)
            if index != newIndex {
                swap(&self[index], &self[newIndex])
            }
        }
    }
    
    /// Returns a randomly arranged array using the Fisher-Yates shuffle
    @warn_unused_result(mutable_variant="shuffleInPlace")
    func shuffle() -> [Element] {
        var tempArray = self
        tempArray.shuffleInPlace()
        
        return tempArray
    }
    
    /// Groups the array into a dictionary by key specified in closure
    func groupBy<U>(groupClosure: (Element) -> U) -> [U: Array] {
        var grouped = [U: Array]()
        for element in self {
            let key = groupClosure(element)
            grouped[key] = (grouped[key] ?? []) + [element]
        }
        
        return grouped
    }
    
    /// Sections the ordered array by the string specified in the closure, preserving the order of the original array.
    func sectionBy(@noescape sectionFunction: (Element) -> String) -> [(title: String, items: [Element])] {
        var lastTitle = ""
        var currentGroup = [Element]()
        var allGroups = [(title: String, items: [Element])]()
        
        for item in self {
            let title = sectionFunction(item)
            if title == lastTitle {
                currentGroup.append(item)
            } else {
                if !currentGroup.isEmpty {
                    allGroups.append((title: lastTitle, items: currentGroup))
                }
                lastTitle = title
                currentGroup = [item]
            }
        }
        
        if !currentGroup.isEmpty {
            allGroups.append((title: lastTitle, items: currentGroup))
        }
        
        return allGroups
    }
        
    /// Returns an array containing the the last numberOfElements elements of self.
    @warn_unused_result
    func tail(numberOfElements: Int) -> Array {
        return Array(self[max(count - numberOfElements, 0)..<count])
    }
    
    /// Returns the first element of self and removes it from the array. Returns `nil` if array is empty.
    mutating func shift() -> Element? {
        if !isEmpty {
            return removeAtIndex(0)
        }
        return nil
    }
    
    /// Returns an array containing the first n elements of self.
    @warn_unused_result
    func take(numberOfElements: Int) -> Array {
        return Array(self[0..<max(min(numberOfElements, count), 0)])
    }

}
