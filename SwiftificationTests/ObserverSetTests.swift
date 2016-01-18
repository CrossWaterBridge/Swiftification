//
// Original work Copyright (c) 2015, Michael Ash
// Modified work Copyright (c) 2016 Hilton Campbell
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of Michael Ash nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

import XCTest
@testable import Swiftification

class ObserverSetTests: XCTestCase {
    class TestObservee {
        let voidObservers = ObserverSet<Void>()
        let stringObservers = ObserverSet<String>()
        let twoStringObservers = ObserverSet<(String, String)>()
        let intObservers = ObserverSet<(Int, Int)>()
        let intAndStringObservers = ObserverSet<(Int, String)>()
        let namedParameterObservers = ObserverSet<(name: String, count: Int)>()
        
        func testNotify() {
            voidObservers.notify()
            stringObservers.notify("Sup")
            twoStringObservers.notify(("hello", "world"))
            intObservers.notify((42, 43))
            intAndStringObservers.notify((42, "hello"))
            namedParameterObservers.notify((name: "someName", count: 42))
        }
    }
    
    class TestObserver {
        init(observee: TestObservee) {
            observee.voidObservers.add(self, self.dynamicType.voidSent)
            observee.stringObservers.add(self, self.dynamicType.stringChanged)
            observee.twoStringObservers.add(self, self.dynamicType.twoStringChanged)
            observee.intObservers.add(self, self.dynamicType.intChanged)
            observee.intAndStringObservers.add(self, self.dynamicType.intAndStringChanged)
            observee.namedParameterObservers.add(self, self.dynamicType.namedParameterSent)
        }
        
        deinit {
            print("deinit!!!!")
        }
        
        func voidSent() {
            print("void sent")
        }
        
        func stringChanged(s: String) {
            print("stringChanged: " + s)
        }
        
        func twoStringChanged(s1: String, s2: String) {
            print("twoStringChanged: \(s1) \(s2)")
        }
        
        func intChanged(i: Int, j: Int) {
            print("intChanged: \(i) \(j)")
        }
        
        func intAndStringChanged(i: Int, s: String) {
            print("intAndStringChanged: \(i) \(s)")
        }
        
        func namedParameterSent(name: String, count: Int) {
            print("Named parameters: \(name) \(count)")
        }
    }
    
    func testBasics() {
        let observee = TestObservee()
        var obj: TestObserver? = TestObserver(observee: observee)
        
        let token = observee.intAndStringObservers.add{ print("int and string closure: \($0) \($1)") }
        print("intAndStringObservers: \(observee.intAndStringObservers.description)")
        
        observee.testNotify()
        obj = nil
        observee.testNotify()
        observee.intAndStringObservers.remove(token)
        observee.testNotify()
        
        print("intAndStringObservers: \(observee.intAndStringObservers.description)")
    }
    
}
