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

public extension Sequence {
    var first: Iterator.Element? {
        return first(where: { _ in return true })
    }

    /// Returns the first element of `self` that tests `true`, or `nil` if no element tests `true`.
    @available(*, deprecated, message: "please use 'first(where:)' instead")
    func takeFirst(_ test: (Iterator.Element) throws -> Bool) rethrows -> Iterator.Element? {
        for element in self where try test(element) {
            return element
        }
        return nil
    }
    
    /// Returns all elements until the first element of `self` that tests `false`.
    func takeWhile(_ test: (Iterator.Element) throws -> Bool) rethrows -> [Iterator.Element] {
        var results: [Iterator.Element] = []
        for element in self {
            if try !test(element) {
                break
            }
            results.append(element)
        }
        return results
    }
    
    /// Returns the array of elements for which condition(element) is unique
    func unique<T: Hashable>(by condition: (Iterator.Element) throws -> T) rethrows -> [Iterator.Element] {
        var results: [Iterator.Element] = []
        var tempSet = Set<T>()
        for element in self {
            let value: T = try condition(element)
            if !tempSet.contains(value) {
                tempSet.insert(value)
                results.append(element)
            }
        }
        return results
    }
    
    /// Checks if test returns true for any element of self.
    func any(_ condition: (Iterator.Element) throws -> Bool) rethrows -> Bool {
        for element in self where try condition(element) {
            return true
        }
        return false
    }
    
    /// Checks if test returns true for every element of self.
    func all(_ condition: (Iterator.Element) throws -> Bool) rethrows -> Bool {
        for element in self where try !condition(element) {
            return false
        }
        return true
    }
}

public extension Sequence where Iterator.Element: Hashable {
    /// Returns an array removing the duplicate elements in self. The original element order is preserved.
    func unique() -> [Iterator.Element] {
        var results: [Iterator.Element] = []
        var tempSet = Set<Iterator.Element>()
        for element in self where !tempSet.contains(element) {
            tempSet.insert(element)
            results.append(element)
        }
        return results
    }
}

public extension Sequence where Iterator.Element: Equatable {
    /// Returns an array removing the duplicate elements in self. The original element order is preserved.
    func unique() -> [Iterator.Element] {
        var results: [Iterator.Element] = []
        for element in self where !results.contains(element) {
            results.append(element)
        }
        return results
    }
}
