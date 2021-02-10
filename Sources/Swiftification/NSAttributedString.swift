//
// Copyright (c) 2019 Hilton Campbell
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

public extension NSAttributedString {
 
    func substring(from range: Range<String.Index>) -> String {
        return String(self.string[range])
    }
    
    func attributedSubstring(from range: Range<String.Index>) -> NSAttributedString {
        return attributedSubstring(from: NSRange(range, in: string))
    }
    
    subscript(range: Range<String.Index>) -> NSAttributedString {
        return attributedSubstring(from: range)
    }
    
}

public extension NSMutableAttributedString {
    
    func addAttribute(_ name: NSAttributedString.Key, value: Any, range: Range<String.Index>) {
        addAttribute(name, value: value, range: NSRange(range, in: string))
    }
    
}

/// Returns the second attributed string appended to the first.
public func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
    let result = NSMutableAttributedString(attributedString: lhs)
    result.append(rhs)
    return result
}

public extension Sequence where Iterator.Element == NSAttributedString {
    /// Interpose the `separator` between elements of `self`, then concatenate the result.
    func joined(separator: NSAttributedString) -> NSAttributedString {
        let result = NSMutableAttributedString()
        for (i, element) in self.enumerated() {
            if i > 0 {
                result.append(separator)
            }
            result.append(element)
        }
        return result
    }
}
