//
//  DecimalParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/21.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

let validDecimalsSet = ["0","1","2","3","4","5","6","7","8","9"]

class DecimalParser {
    
    static func parse(_ code: inout String, expectedType: Type? = nil) throws -> DecimalFragment? {
        
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
                offset += 1
                decimalClaimed = true
                continue
            } else if (char.uppercased() == "E") {
                // scientific notation
                if (scientificClaimed) {
                    break
                }
                offset += 1
                scientificClaimed = true
                continue
            } else if ((char == "+" || char == "-") && offset > 0 && code[offset - 1].uppercased() == "E") {
                // scientific notation
                offset += 1
                continue
            }
            
            break
        }
        
        let value = code[..<offset]
        
        // only expecting parses the short type
        if (expectedType == SHORTType) {
            if let int16 = Int16(value) {
                code = code[offset...]
                WhitespaceParser.parse(&code)
                return DecimalFragment(int16, type: SHORTType)
            }
            return nil
        }
        
        // parse integer
        if let int32 = Int32(value), (expectedType == nil || expectedType! == INTEGERType) {
            code = code[offset...]
            WhitespaceParser.parse(&code)
            return DecimalFragment(int32, type: INTEGERType)
        }
        
        // parse long
        if let int64 = Int64(value), (expectedType == nil || expectedType! == LONGType) {
            code = code[offset...]
            WhitespaceParser.parse(&code)
            return DecimalFragment(int64, type: LONGType)
        }
        
        // parse float
        if let float = Float(value), (expectedType == nil || expectedType! == SINGLEType) {
            code = code[offset...]
            WhitespaceParser.parse(&code)
            return DecimalFragment(float, type: SINGLEType)
        }
        
        // parse double
        if let double = Double(value), (expectedType == nil || expectedType! == DOUBLEType) {
            code = code[offset...]
            WhitespaceParser.parse(&code)
            return DecimalFragment(double, type: DOUBLEType)
        }
        
        return nil
    }
}
