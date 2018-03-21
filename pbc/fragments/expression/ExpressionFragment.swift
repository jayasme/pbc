//
//  ExpressionFragment.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/14.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class ExpressionSubFragment: BaseFragment {
    var operandValue: Operand? {
        return (self as? OperandFragment)?.value
    }

    var operatorValue: Operator? {
        return (self as? OperatorFragment)?.value
    }
}

class ExpressionFragment: OperandFragment {
    var fragments: [ExpressionSubFragment]
    
    // get the type of the result of caclculations with binary operation.
    private static func getBinaryType(type1: Type, type2: Type, oper: Operator) throws -> Type {
        if (oper.category == .mathematics) {
            // mathematics
            guard (type1 != BOOLEANType && type2 != BOOLEANType) else {
                throw InvalidValueError("Boolean cannot be the one of the operands in a mathematical calculation.")
            }
            
            if (type1 == STRINGType && type2 == STRINGType && oper == .addition) {
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
            guard type1.isCompatibleWith(type: type2) else {
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
    
    static func predictType(_ fragments: [ExpressionSubFragment]) throws -> Type {
        let stack = Stack<(type: Type, subscripts: Subscripts)>()
        
        for fragment in fragments {
            if let operand = fragment.operandValue, let array = operand as? ArrayOperand {
                stack.push((type: operand.type, subscripts: array.subscripts))
            } else if let operand = fragment.operandValue {
                stack.push((type: operand.type, subscripts: Subscripts.empty))
            } else if let oper = fragment.operatorValue {
                if (oper.operands == .unary) {
                    // do nothing
                } else {
                    guard let operand1 = stack.pop() else {
                        throw SyntaxError("Not enough operand")
                    }
                    guard let operand2 = stack.pop() else {
                        throw SyntaxError("Not enough operand")
                    }
                    
                    if (!operand1.subscripts.isEmpty || !operand2.subscripts.isEmpty) {
                        throw InvalidValueError("Arrays cannot be applied for '" + oper.rawValue + "' operations.")
                    }
                    
                    let type = try ExpressionFragment.getBinaryType(type1: operand1.type, type2: operand2.type, oper: oper)
                    stack.push((type: type, subscripts: Subscripts.empty))
                }
            }
        }
        
        guard stack.count == 1, let result = stack.top else {
            throw InvalidValueError("Expression is illegal, please check it.")
        }
        
        return result.type
    }
    
    init(_ fragments: [ExpressionSubFragment]) throws {
        self.fragments = fragments
        let type = try ExpressionFragment.predictType(fragments)
        let operand = Operand(type: type)
        super.init(operand)
    }
}
