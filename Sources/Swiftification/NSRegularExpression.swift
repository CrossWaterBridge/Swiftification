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

public extension NSRegularExpression {
    
    func stringByReplacingMatches(in string: String, options: NSRegularExpression.MatchingOptions = [], range: Range<String.Index>? = nil, withReplacer replacer: (NSTextCheckingResult, String) -> String?) -> String {
        var string = string
        var offset = 0
        
        for match in matches(in: string, options: options, range: range) {
            let original = replacementString(for: match, in: string, offset: offset, template: "$0")
            let nsRange = NSRange(location: match.range(at: 0).location + offset, length: match.range(at: 0).length)
            
            guard let replaced = replacer(match, original), let range = Range<String.Index>(nsRange, in: string) else { continue }
            
            string.replaceSubrange(range, with: replaced)
            offset += (replaced.nsRange.length - nsRange.length)
        }
        
        return string
    }
    
    func stringByReplacingMatches(in string: String, options: NSRegularExpression.MatchingOptions = [], range: Range<String.Index>? = nil, withTemplate template: String) -> String {
        let nsRange = range.flatMap { NSRange($0, in: string) } ?? string.nsRange
        return stringByReplacingMatches(in: string, options: options, range: nsRange, withTemplate: template)
    }
    
    func firstMatch(in string: String, options: NSRegularExpression.MatchingOptions = [], range: Range<String.Index>? = nil) -> NSTextCheckingResult? {
        let nsRange = range.flatMap { NSRange($0, in: string) } ?? string.nsRange
        
        return firstMatch(in: string, options: options, range: nsRange)
    }
    
    func matches(in string: String, options: NSRegularExpression.MatchingOptions = [], range: Range<String.Index>? = nil) -> [NSTextCheckingResult] {
        let nsRange = range.flatMap { NSRange($0, in: string) } ?? string.nsRange
        
        return matches(in: string, options: options, range: nsRange)
    }
    
    func numberOfMatches(in string: String, options: NSRegularExpression.MatchingOptions = [], range: Range<String.Index>? = nil) -> Int {
        let nsRange = range.flatMap { NSRange($0, in: string) } ?? string.nsRange
        
        return numberOfMatches(in: string, options: options, range: nsRange)
    }
    
}
