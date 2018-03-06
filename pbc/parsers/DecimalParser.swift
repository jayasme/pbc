//
//  DecimalParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/21.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

let validDecimalsSet = ["0","1","2","3","4","5","6","7","8","9"]

struct DecimalElement {
    var value: Any
    var type: Type
    
    init(_ value: Any, type: Type) {
        self.value = value
        self.type = type
    }
    
    var shortValue: Int16 {
        return self.value as! Int16
    }
    
    var integerValue: Int32 {
        return self.value as! Int32
    }
    
    var longValue: Int64 {
        return self.value as! Int64
    }
    
    var floatValue: Float {
        return self.value as! Float
    }
    
    var doubleValue: Double {
        return self.value as! Double
    }
}

class DecimalParser {
    
    static func parse(_ code: inout String, expectedType: Type? = nil) throws -> DecimalElement? {
        
        var offset: Int = 0
        // must check during the loop
        var scientificClaimed = false
        var decimalClaimed = false
        
        if (code[offset] == "-" || code[offset] == "+") {
            offset += 1
        }
        
        while(offset < code.count) {
            let char = code[offset]
            
            if (validDecimalsSet.contains(char)) {
                // a digital acquired, next loop
                offset += 1
                continue
            } else if (char == ".") {
                if (decimalClaimed) {
                    // decimal point appeared repeatly
                    break
                }
                decimalClaimed = true
                continue
            } else if (char.uppercased() == "E") {
                // scientific notation
                if (scientificClaimed) {
                    break
                }
                scientificClaimed = true
                continue
            } else if ((char == "+" || char == "-") && offset > 0 && code[offset - 1].uppercased() == "E") {
                // scientific notation
                continue
            }
            
            break
        }
        
        let value = code[..<offset]
        
        // parse short
        if let int16 = Int16(value), (expectedType == nil || expectedType! == SHORTType) {
            code = code[offset...]
            WhitespaceParser.parse(&code)
            return DecimalElement(int16, type: SHORTType)
        }
        
        // parse integer
        if let int32 = Int32(value), (expectedType == nil || expectedType! == INTEGERType) {
            code = code[offset...]
            WhitespaceParser.parse(&code)
            return DecimalElement(int32, type: INTEGERType)
        }
        
        // parse long
        if let int64 = Int64(value), (expectedType == nil || expectedType! == LONGType) {
            code = code[offset...]
            WhitespaceParser.parse(&code)
            return DecimalElement(int64, type: LONGType)
        }
        
        // parse float
        if let float = Float(value), (expectedType == nil || expectedType! == SINGLEType) {
            code = code[offset...]
            WhitespaceParser.parse(&code)
            return DecimalElement(float, type: SINGLEType)
        }
        
        // parse double
        if let double = Double(value), (expectedType == nil || expectedType! == DOUBLEType) {
            code = code[offset...]
            WhitespaceParser.parse(&code)
            return DecimalElement(double, type: DOUBLEType)
        }
        
        return nil
    }
}
