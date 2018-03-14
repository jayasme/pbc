//
//  ExpConstantParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class ConstantElement: OperandElement {
    init(_ constant: Constant) {
        super.init(constant)
    }
}

class ConstantParser {
    
    static func parse(_ code: inout String) throws -> ConstantElement? {
        
        do {
            // Check if it is a string
            if let string = try StringParser.parse(&code) {
                return ConstantElement(Constant(value: string.value, type: STRINGType))
            }
            
            // Check if it is a boolean
            if (KeywordParser.parse(&code, keyword: "TRUE") != nil) {
                return ConstantElement(Constant(value: true, type: BOOLEANType))
            }
            
            if (KeywordParser.parse(&code, keyword: "FALSE") != nil) {
                return ConstantElement(Constant(value: false, type: BOOLEANType))
            }
            
            // Check if it is an array
            if let array = try ArrayParser.parse(&code) {
                return ConstantElement(ArrayConstant(value: array.value, type: array.type, subscripts: array.subscripts))
            }
            
            // Check if it is a decimal
            if let decimal = try DecimalParser.parse(&code) {
                // the minimum parsable decimal type is integer
                let type = decimal.type == SHORTType ? INTEGERType : decimal.type
                return ConstantElement(Constant(value: decimal.value, type: type))
            }
            
            return nil
        } catch let error {
            throw error
        }
    }
}
