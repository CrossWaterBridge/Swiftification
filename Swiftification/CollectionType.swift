//
//  Find.swift
//  Swiftification
//
//  Created by Hilton Campbell on 11/26/15.
//  Copyright © 2015 Hilton Campbell. All rights reserved.
//

import Foundation

public extension CollectionType {
    
    func mapFilter<T>(@noescape transform: Generator.Element throws -> T?) rethrows -> [T] {
        var results = [T]()
        for element in self {
            if let result = try transform(element) {
                results.append(result)
            }
        }
        return results
    }
    
    func takeFirst(@noescape test: Generator.Element throws -> Bool) rethrows -> Generator.Element? {
        for element in self where try test(element) {
            return element
        }
        return nil
    }
    
}