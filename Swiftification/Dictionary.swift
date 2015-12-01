//
// Copyright (c) 2015 Hilton Campbell
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

public extension Dictionary {
    
    init<C: CollectionType where C.Generator.Element == Element>(_ elements: C) {
        self.init()
        for (key, value) in elements {
            self[key] = value
        }
    }
    
    /// Returns the union of `self` and the other dictionaries. If more than
    /// one dictionary has the same key, it will take on the rightmost
    /// dictionary's value.
    @warn_unused_result
    func union(first: Dictionary, _ rest: Dictionary...) -> Dictionary {
        var result = self
        for dictionary in [first] + rest {
            for (key, value) in dictionary {
                result[key] = value
            }
        }
        return result
    }
    
    /// Returns a new dictionary by running a map on each key and getting a new value
    @warn_unused_result
    func mapValues<V>(map: (Key, Value) -> V) -> [Key: V] {
        var results = [Key: V]()
        for (key, value) in self {
            results[key] = map(key, value)
        }
        
        return results
    }
    
}

/// Returns the union of the two dictionaries. For any keys that both
/// dictionaries have in common, the result will take on the value from the
/// right dictionary.
public func | <K, V>(lhs: Dictionary<K, V>, rhs: Dictionary<K, V>) -> Dictionary<K, V> {
    return lhs.union(rhs)
}
