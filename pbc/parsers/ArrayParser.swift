//
//  ArrayParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/8.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class ArrayElement {
    var value: [OperandElement]
    var type: Type?
    
    var bounds: [Int] {
        get {
            var maxSubBounds: [Int] = []
            for operand in self.value {
                if (operand.isArray) {
                    maxSubBounds = ArrayElement.mixBounds(bounds1: maxSubBounds, bounds2: operand.bounds)
                }
            }
            return [self.value.count] + maxSubBounds
        }
    }
    
    static func mixBounds(bounds1: [Int], bounds2: [Int]) -> [Int] {
        var result: [Int] = []
        for i in 0..<min(bounds1.count, bounds2.count) {
            result.append(max(bounds1[i], bounds2[i]))
        }

        if (bounds1.count < bounds2.count) {
            result += bounds2[bounds1.count...]
        } else if (bounds1.count > bounds2.count) {
            result += bounds1[bounds2.count...]
        }
        
        return result
    }
    
    init(_ value: [OperandElement], type: Type?) {
        self.value = value
        self.type = type
    }
}

class ArrayParser {
    
    static func parse(_ code: inout String) throws -> ArrayElement? {
        
        guard (SymbolParser.parse(&code, symbol: "{") != nil) else {
            return nil
        }
        
        var arrValue: [OperandElement] = []
        var arrType: Type! = nil
        var isSubArray: Bool! = nil
        if (SymbolParser.parse(&code, symbol: "}") == nil) {
            while(code.count > 0) {
                guard let expression = try ExpressionParser.parse(&code) else {
                    throw SyntaxError("Expected a valid expression.")
                }
                
                // keep the each type of elements must be the same
                guard (arrType == nil || expression.type == arrType || (expression.type.isNumber && arrType.isNumber)) else {
                    throw InvalidValueError("Each type of elements in the array must be the same.")
                }
                
                // keep the each type of elements must be array or not be array at the same time
                guard (isSubArray == nil || expression.isArray == isSubArray) else {
                    throw InvalidValueError("Each type of elements in the array must be array or not be array at the same time.")
                }
                
                arrValue.append(expression)
                if (arrType == nil) {
                    arrType = expression.type
                } else if let mixedType = Type.mixType(type1: arrType, type2: expression.type) {
                    arrType = mixedType
                }
                isSubArray = expression.isArray
                
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
        
        return ArrayElement(arrValue, type: arrType)
    }
}
