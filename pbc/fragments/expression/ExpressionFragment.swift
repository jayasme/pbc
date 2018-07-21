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
    private static func getBinaryType(type1: TypeTuple, type2: TypeTuple, oper: Operator) throws -> TypeTuple {
        guard (type1.subscripts == nil && type2.subscripts == nil) else {
            throw InvalidTypeError.Operator_Cannot_Be_Applied_Between(oper: oper.symbol, type1: type1.name, type2: type2.name)
        }
        
        if (oper.category == .mathematics) {
            // mathematics
            guard (type1 != BOOLEANType && type2 != BOOLEANType) else {
                throw InvalidTypeError.Operator_Cannot_Be_Applied_Between(oper: oper.symbol, type1: type1.name, type2: type2.name)
            }
            
            if (type1 == STRINGType && type2 == STRINGType && oper == .addition) {
                return TypeTuple(STRINGType)
            } else if let mixedType = TypeTuple.mixType(type1: type1, type2: type2), mixedType.isNumber {
                return mixedType
            } else {
                throw InvalidTypeError.Operator_Cannot_Be_Applied_Between(oper: oper.symbol, type1: type1.name, type2: type2.name)
            }
        } else if (oper.category == .logic) {
            // logic
            guard (type1 == BOOLEANType && type2 == BOOLEANType) else {
                throw InvalidTypeError.Operator_Cannot_Be_Applied_Between(oper: oper.symbol, type1: type1.name, type2: type2.name)
            }
            return TypeTuple(BOOLEANType)
        } else if (oper.category == .equality) {
            // equality
            guard type1.isCompatibleWith(type: type2) else {
                throw InvalidTypeError.Operator_Cannot_Be_Applied_Between(oper: oper.symbol, type1: type1.name, type2: type2.name)
            }
            return TypeTuple(BOOLEANType)
        } else if (oper.category == .comparation) {
            // comparation
            guard (type1.isNumber && type2.isNumber) else {
                throw InvalidTypeError.Operator_Cannot_Be_Applied_Between(oper: oper.symbol, type1: type1.name, type2: type2.name)
            }
            
            return TypeTuple(BOOLEANType)
        } else if (oper == .dot) {
            return type2
        }
        
        throw InvalidTypeError.Operator_Cannot_Be_Applied_Between(oper: oper.symbol, type1: type1.name, type2: type2.name)
    }
    
    static func predictType(_ fragments: [ExpressionSubFragment]) throws -> TypeTuple {
        let stack = Stack<TypeTuple>()
        
        for fragment in fragments {
            if let operand = fragment.operandValue?.type {
                stack.push(operand)
            } else if let oper = fragment.operatorValue {
                if (oper.operands == .unary) {
                    // do nothing
                } else {
                    guard let operand2 = stack.pop() else {
                        throw SyntaxError.Illegal_Expression()
                    }
                    guard let operand1 = stack.pop() else {
                        throw SyntaxError.Illegal_Expression()
                    }
                    
                    let type = try ExpressionFragment.getBinaryType(type1: operand1, type2: operand2, oper: oper)
                    stack.push(type)
                }
            }
        }
        
        guard stack.count == 1, let result = stack.top else {
            throw SyntaxError.Illegal_Expression()
        }
        
        return result
    }
    
    init(_ fragments: [ExpressionSubFragment]) throws {
        self.fragments = fragments
        let type = try ExpressionFragment.predictType(fragments)
        let operand = Operand(type: type)
        super.init(operand)
    }
}
