//
//  String+Extensions.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/3.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

extension String {
    
    private subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    public subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    public subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    public subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
    public subscript (bounds: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        return String(self[start...])
    }
    
    public subscript (bounds: PartialRangeThrough<Int>) -> String {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[...end])
    }
    
    public subscript (bounds: PartialRangeUpTo<Int>) -> String {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[..<end])
    }
    
    
    public func hasPrefix(_ prefix: String, caseSensitive: Bool) -> Bool {
        guard (prefix.count <= self.count) else {
            return false
        }
        
        if (caseSensitive) {
            return self[..<prefix.count].hasPrefix(prefix)
        }
        
        return self[..<prefix.count].uppercased().hasPrefix(prefix.uppercased())
    }
    
    public func emptyToNil() -> String? {
        return self == "" ? nil : self
    }
    
    public func blankToNil() -> String? {
        return self.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? nil : self
    }
}
