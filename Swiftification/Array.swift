//
//  Array.swift
//  Swiftification
//
//  Created by Hilton Campbell on 11/26/15.
//  Copyright © 2015 Hilton Campbell. All rights reserved.
//

import Foundation

public extension Array {
    
    subscript(safe index: Int) -> Element? {
        return (indices ~= index ? self[index] : nil)
    }
    
}