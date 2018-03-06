//
//  ExpConstantParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class ConstantElement: OperandElement {
    var value: Any
    
    init(_ value: Any, type: Type) {
        self.value = value
        super.init(type)
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
    
    var stringValue: String {
        return self.value as! String
    }
}

class ConstantParser {
    
    static func parse(_ code: inout String) throws -> ConstantElement? {
        
        do {
            // Check if it is a string
            if let string = try StringParser.parse(&code) {
                return ConstantElement(string.value, type: STRINGType)
            }
            
            // Check if it is a decimal
            if let decimal = try DecimalParser.parse(&code) {
                // the minimum parsable decimal type is integer
                return ConstantElement(decimal.value, type: decimal.type == SHORTType ? INTEGERType : decimal.type)
            }
            
            // Check if it is a boolean
            if (KeywordParser.parse(&code, keyword: "TRUE") != nil) {
                return ConstantElement(true, type: BOOLEANType)
            }
            
            if (KeywordParser.parse(&code, keyword: "FALSE") != nil) {
                return ConstantElement(false, type: BOOLEANType)
            }
            
            return nil
        } catch let error {
            throw error
        }
    }
}
