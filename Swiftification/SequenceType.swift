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

public extension SequenceType {
    
    /// Returns the first element of `self` that tests `true`, or `nil` if no element tests `true`.
    @warn_unused_result
    func takeFirst(@noescape test: Generator.Element throws -> Bool) rethrows -> Generator.Element? {
        for element in self where try test(element) {
            return element
        }
        return nil
    }
    
    /// Returns the array of elements for which condition(element) is unique
    @warn_unused_result
    func uniqueBy<T: Hashable>(condition: (Generator.Element) -> T) -> [Generator.Element] {
        var results: [Generator.Element] = []
        var tempSet = Set<T>()
        for element in self {
            let value: T = condition(element)
            if !tempSet.contains(value) {
                tempSet.insert(value)
                results.append(element)
            }
        }
        return results
    }
    
    /// Checks if test returns true for any element of self.
    @warn_unused_result
    func any(condition: (Generator.Element) -> Bool) -> Bool {
        for element in self where condition(element) {
            return true
        }
        return false
    }
   
}

public extension SequenceType where Generator.Element: Hashable {
    
    /// Returns an array removing the duplicate elements in self. The original element order is preserved.
    @warn_unused_result
    func unique() -> [Generator.Element] {
        var results: [Generator.Element] = []
        var tempSet = Set<Generator.Element>()
        for element in self where !tempSet.contains(element) {
            tempSet.insert(element)
            results.append(element)
        }
        return results
    }
    
}

public extension SequenceType where Generator.Element: Equatable {
    
    /// Returns an array removing the duplicate elements in self. The original element order is preserved.
    @warn_unused_result
    func unique() -> [Generator.Element] {
        var results: [Generator.Element] = []
        for element in self where !results.contains(element) {
            results.append(element)
        }
        return results
    }
    
}
