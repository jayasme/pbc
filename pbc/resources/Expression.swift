//
//  Expression.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/13.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

protocol ExpressionItem { }

class Expression: Operand, ExpressionItem {
    var items: [ExpressionItem]
    
    // get the type of the result of caclculations with binary operation.
    private static func getBinaryType(type1: Type, type2: Type, oper: Operator) throws -> Type {
        if (oper.category == .mathematics) {
            // mathematics
            guard (type1 != BOOLEANType && type2 != BOOLEANType) else {
                throw InvalidValueError("Boolean cannot be the one of the operands in a mathematical calculation.")
            }
            
            if (type1 == STRINGType && type2 == STRINGType && oper.type == .addition) {
                return STRINGType
            } else if let mixedType = Type.mixType(type1: type1, type2: type2), mixedType.isNumber {
                return mixedType
            } else {
                throw InvalidValueError("'" + type1.name + "' and '" + type2.name + "' cannot be the operands in a mathematical calculation.")
            }
        } else if (oper.category == .logic) {
            // logic
            guard (type1 == BOOLEANType && type2 == BOOLEANType) else {
                throw InvalidValueError("Only Boolean can be the operands in a logical calculation.")
            }
            return BOOLEANType
        } else if (oper.category == .equality) {
            // equality
            guard type1.isCompatibileWith(type: type2) else {
                throw InvalidValueError("Only the values of identical type or numbers can be the operands of a comparational calculation.")
            }
            return BOOLEANType
        }
        
        // comparation
        guard (type1.isNumber && type2.isNumber) else {
            throw InvalidValueError("Only numbers can be the operands of a comparational calculation.")
        }
        
        return BOOLEANType
    }
    
    static func predictType(_ items: [ExpressionItem]) throws -> Type {
        let stack = Stack<(type: Type, dimensions: Int)>()
        
        for item in items {
            if let operand = item as? Operand {
                stack.push((type: operand.type, dimensions: operand.dimensions))
            } else if let oper = item as? Operator {
                if (oper.operands == .unary) {
                    // do nothing
                } else {
                    guard let operand1 = stack.pop() else {
                        throw SyntaxError("Not enough operand")
                    }
                    guard let operand2 = stack.pop() else {
                        throw SyntaxError("Not enough operand")
                    }
                    
                    if (operand1.dimensions > 0 || operand2.dimensions > 0) {
                        throw InvalidValueError("Arrays cannot be applied for '" + oper.type.rawValue + "' operations.")
                    }
                    
                    try stack.push((type: Expression.getBinaryType(type1: operand1.type, type2: operand2.type, oper: oper), dimensions: 0))
                }
            }
        }
        
        guard stack.count == 1, let result = stack.top else {
            throw InvalidValueError("Expression is illegal, please check it.")
        }
        
        return result.type
    }
    
    init(_ items: [ExpressionItem]) throws {
        self.items = items
        let type = try Expression.predictType(items)
        super.init(type: type)
    }
}
