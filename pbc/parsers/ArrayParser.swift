//
//  ArrayParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/8.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class ArrayElement {
    var array: ArrayConstant
    
    init(_ array: ArrayConstant) {
        self.array = array
    }
}

class ArrayParser {
    
    static func parse(_ code: inout String) throws -> ArrayElement? {
        
        guard (SymbolParser.parse(&code, symbol: "{") != nil) else {
            return nil
        }
        
        var arrValue: [Operand] = []
        var arrType: Type! = nil
        var lastSubscripts: Subscripts! = nil
        if (SymbolParser.parse(&code, symbol: "}") == nil) {
            while(code.count > 0) {
                guard let operand = try ExpressionParser.parse(&code)?.operand else {
                    throw SyntaxError("Expected a valid expression.")
                }
                
                // keep the each type of elements must be the same
                guard (arrType == nil || operand.type.isCompatibileWith(type: arrType)) else {
                    throw InvalidValueError("Each type of elements in the array must be the same.")
                }
                
                let subscripts = (operand is ArrayOperand) ? (operand as? ArrayOperand)?.subscripts : Subscripts()
                // keep the each type of elements must be array or not be array at the same time
                guard (lastSubscripts == nil || subscripts == lastSubscripts) else {
                    throw InvalidValueError("Each type of elements in the array must be array or not be array at the same time.")
                }
                lastSubscripts = subscripts
                
                arrValue.append(operand)
                if (arrType == nil) {
                    arrType = operand.type
                } else if let mixedType = Type.mixType(type1: arrType, type2: operand.type) {
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
        
        let bounds = try Subscript(upperBound: arrValue.count)
        let subscripts = lastSubscripts == nil ? Subscripts(current: bounds) : Subscripts(current: bounds, parentSubscripts: lastSubscripts)
        let array = ArrayConstant(value: arrValue, type: arrType, subscripts: subscripts)

        return ArrayElement(array)
    }
}
