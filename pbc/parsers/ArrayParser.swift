//
//  ArrayParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/8.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class ArrayParser {
    
    static func parse(_ code: inout String) throws -> ConstantOperandFragment? {
        
        guard (SymbolParser.parse(&code, symbol: "{") != nil) else {
            return nil
        }
        
        var arrValue: [Operand] = []
        var arrType: TypeTuple! = nil
        if (SymbolParser.parse(&code, symbol: "}") == nil) {
            while(code.count > 0) {
                guard let operand = try ExpressionParser.parse(&code)?.value else {
                    throw SyntaxError("Expected a valid expression.")
                }
                
                // keep the each type of elements must be the same
                guard (arrType == nil || operand.type.isCompatibleWith(type: arrType)) else {
                    throw InvalidValueError("Each type of elements in the array must be the same.")
                }
                
                arrValue.append(operand)
                if (arrType == nil) {
                    arrType = operand.type
                } else if let mixedType = TypeTuple.mixType(type1: arrType, type2: operand.type)  {
                    arrType = mixedType
                }
                
                if (SymbolParser.parse(&code, symbol: ",") != nil) {
                    // separator
                    continue
                } else if (SymbolParser.parse(&code, symbol: "}") != nil) {
                    // end of the function declaration
                    break
                }
                
                throw SyntaxError("Expected '}'.")
            }
        }
        
        let bounds = try Subscript(upperBound: Int32(arrValue.count))
        let subscripts = arrType.subscripts == nil ? Subscripts(current: bounds) : Subscripts(current: bounds, parentSubscripts: arrType.subscripts!)
        return ConstantOperandFragment(Constant(value: arrValue, type: TypeTuple(arrType.type, subscripts: subscripts)))
    }
}
