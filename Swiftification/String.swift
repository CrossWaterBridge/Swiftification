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
import CommonCrypto

public extension StringProtocol {
    
    /// Safely access the character at the given index, returning `nil` if `index` is out of bounds
    /// This should be used in conjunction with indexes `advancedBy(_:limit)` to avoid crashes
    subscript(safe index: Index) -> Character? {
        return index < endIndex ? self[index] : nil
    }
    
    /// Strips whitespaces from both the beginning and the end of self.
    func trimmed() -> String {
        return String(self).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Returns random string of length with specified characters.
    static func random(_ length: Int = Int.random(8..<65), characters: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz012345789") -> String {
        if characters.isEmpty { return "" }
        
        var result = String()
        for _ in 0..<length {
            result.append(characters[characters.index(characters.startIndex, offsetBy: Int.random(0..<characters.count))])
        }
        return result
    }
    
    /// Returns a value with string inserted at index.
    func inserting(_ string: String, at i: String.IndexDistance) -> String {
        var str = String(self)
        let index = str.index(str.startIndex, offsetBy: i, limitedBy: str.endIndex) ?? str.endIndex
        str.insert(contentsOf: string, at: index)
        return str
    }
    
    func md5() -> String {
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, String(self), CC_LONG(lengthOfBytes(using: .utf8)))
        CC_MD5_Final(&digest, context)
        context.deallocate()
        return digest.map { String(format:"%02x", $0) }.joined()
    }
    
    var range: Range<String.Index> {
        return startIndex..<endIndex
    }
    
    var nsRange: NSRange {
        return NSRange(range, in: self)
    }
    
}

public func + (lhs: String?, rhs: String?) -> String? {
    guard let lhs = lhs else { return rhs }
    guard let rhs = rhs else { return lhs }
    return lhs + rhs
}
