//
//  exp.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/3.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

fileprivate var decimalList = [SHORTType, INTEGERType, LONGType, SINGLEType, DOUBLEType]

class OperandElement: BaseElement {
    var type: Type
    
    init(_ type: Type) {
        self.type = type
    }
}

class ExpressionElement: OperandElement {
    var elements: [BaseElement] = []
    var predictionValue: ConstantElement? {
        get {
            guard elements.count == 1, let constant = self.elements.first as? ConstantElement else {
                return nil
            }
            return constant
        }
    }
    
    private static func getBinaryType(type1: Type, type2: Type, oper: OperatorElement) throws -> Type {
        if (oper.category == .mathematics) {
            // mathematics
            guard (type1 != BOOLEANType && type2 != BOOLEANType) else {
                throw InvalidValueError("Boolean cannot be the one of the operands in a mathematical calculation.")
            }
            
            if (type1 == STRINGType && type2 == STRINGType && oper.type == .addition) {
                return STRINGType
            } else if (type1.isDecimal && type2.isDecimal) {
                return decimalList[max(decimalList.index(of: type1)!, decimalList.index(of: type2)!)]
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
            guard (type1 == type2 || (type1.isDecimal && type2.isDecimal)) else {
                throw InvalidValueError("Only the values of identical type or numbers can be the operands of a comparational calculation.")
            }
            return BOOLEANType
        }
        
        // comparation
        guard (type1.isDecimal && type2.isDecimal) else {
            throw InvalidValueError("Only numbers can be the operands of a comparational calculation.")
        }
            
        return BOOLEANType
    }
    
    static func predictType(_ elements: [BaseElement]) throws -> Type {
        let stack = Stack<Type>()
        
        for element in elements {
            if let operand = element as? OperandElement {
                stack.push(operand.type)
            } else if let oper = element as? OperatorElement {
                if (oper.operands == .unary) {
                    // do nothing
                } else {
                    guard let type1 = stack.pop() else {
                        throw SyntaxError("Not enough operand")
                    }
                    guard let type2 = stack.pop() else {
                        throw SyntaxError("Not enough operand")
                    }
                    
                    try stack.push(ExpressionElement.getBinaryType(type1: type1, type2: type2, oper: oper))
                }
            }
        }
        
        guard let result = stack.top else {
            throw InvalidValueError("Only Boolean can be the operand in a logical calculation.")
        }
        
        return result
    }
    
    init(_ elements: [BaseElement]) throws {
        do {
            self.elements = elements
            let type = try ExpressionElement.predictType(self.elements)
            super.init(type)
        } catch let error {
            throw error
        }
    }
    
}

class ExpressionParser {    
    // build expression list from the expression string
    private static func buildExpressionList(_ code: inout String) throws -> [BaseElement] {
        var deepOfBracket = 0
        var list: [BaseElement] = []
        var couldBeOperand = true
        
        while(code.count > 0) {
            do {
                if couldBeOperand, let const = try ConstantParser.parse(&code) {
                    // constant
                    list.append(const)
                    couldBeOperand = false
                    continue
                }
                if couldBeOperand, let variable = try VariableParser.parse(&code) {
                    // variable
                    list.append(variable)
                    couldBeOperand = false
                    continue
                }
                if let oper = OperatorParser.parse(&code, preferUnary: couldBeOperand) {
                    // operator
                    list.append(oper)
                    couldBeOperand = true
                    continue
                }
                if let bracket = BracketParser.parse(&code) {
                    if (bracket.direction == .open) {
                        deepOfBracket += 1
                        couldBeOperand = true
                    } else if (bracket.direction == .close) {
                        deepOfBracket -= 1
                        couldBeOperand = false
                    }
                    if (deepOfBracket < 0) {
                        // Out of effective area
                        return list
                    }
                    // bracket
                    list.append(bracket)
                    continue
                }
                return list
            } catch let error {
                throw error
            }
        }
        
        return list
    }
    
    // convert to RPN
    private static func convertToRPN(_ elements: [BaseElement]) -> [BaseElement] {
        let stack = Stack<BaseElement>()
        var result: [BaseElement] = []
        
        for element in elements {
            if let bracket = element as? BracketElement {
                if (bracket.direction == .open) {
                    // open bracket
                    stack.push(bracket)
                } else {
                    // close bracket
                    while (
                        stack.count > 0 &&
                        (!(stack.top is BracketElement) || (
                        stack.top is BracketElement &&
                        (stack.top as! BracketElement).direction != .open))
                    ) {
                        result.append(stack.pop()!)
                    }
                    if (stack.count > 0) {
                        _ = stack.pop()
                    }
                }
            } else if let oper = element as? OperatorElement {
                while(
                    stack.count > 0 &&
                    stack.top! is OperatorElement &&
                        oper.piority <= (stack.top as! OperatorElement).piority
                    ) {
                        result.append(stack.pop()!)
                }
                stack.push(oper);
            } else if let operand = element as? OperandElement {
                result.append(operand)
            }
        }
        
        while let top = stack.pop() {
            result.append(top)
        }
        
        return result
    }

    static func parse(_ code: inout String) throws -> ExpressionElement? {
        do {
            let expression = try ExpressionParser.buildExpressionList(&code)
            let elements = ExpressionParser.convertToRPN(expression)
            
            return try ExpressionElement(elements)
        } catch let error {
            throw error
        }
    }
}

