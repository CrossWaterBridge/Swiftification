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

public extension Array {
    
    /// Returns the element at `index`, or `nil` if `index` is out of bounds.
    subscript(safe index: Int) -> Element? {
        return (indices ~= index ? self[index] : nil)
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
        return self[Int(rand()) % count]
    }
    
    /// Randomly rearranges the elements of self using the Fisher-Yates shuffle
    mutating func shuffleInPlace() {
        for var index = count - 1; index >= 1; index-- {
            let newIndex = (0...index).random()
            if index != newIndex {
                swap(&self[index], &self[newIndex])
            }
        }
        
    }
    
    func shuffled() -> [Element] {
        var tempArray = self
        tempArray.shuffleInPlace()
        
        return tempArray
    }
    
}
