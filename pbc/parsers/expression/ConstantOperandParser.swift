//
//  ConstantOperandParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class ConstantOperandParser {
    
    static func parse(_ code: inout String) throws -> OperandFragment? {
        // Check if it is a string
        if let string = try StringParser.parse(&code) {
            return ConstantOperandFragment(Constant(value: string.value, type: TypeTuple(STRINGType)))
        }
        
        // Check if it is a boolean
        if (KeywordParser.parse(&code, keyword: "TRUE") != nil) {
            return ConstantOperandFragment(Constant(value: true, type: TypeTuple(BOOLEANType)))
        }
        
        if (KeywordParser.parse(&code, keyword: "FALSE") != nil) {
            return ConstantOperandFragment(Constant(value: false, type: TypeTuple(BOOLEANType)))
        }
        
        // Check if it is an array
        if let array = try ArrayParser.parse(&code) {
            return array
        }
        
        // Check if it is a decimal
        if let decimal = try DecimalParser.parse(&code) {
            // the minimum parsable decimal type is integer
            return ConstantOperandFragment(Constant(value: decimal.value, type: TypeTuple(decimal.type)))
        }
        
        return nil
    }
}
