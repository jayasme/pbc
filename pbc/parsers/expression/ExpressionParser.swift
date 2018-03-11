//
//  exp.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/3.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class OperandElement: BaseElement {
    var type: Type
    var bounds: [Int]
    
    var isArray: Bool {
        get {
            return bounds.count > 0
        }
    }
    
    var arrayDimension: Int {
        get {
            guard (self.isArray) else {
                return 0
            }
            
            return self.bounds.count
        }
    }
    
    func isSameWith(_ operand: OperandElement) -> Bool {
        return self.type == operand.type && self.arrayDimension == operand.arrayDimension
    }
    
    func isCompatibleWith(_ operand: OperandElement) -> Bool {
        return (self.type == operand.type || self.type.isNumber || operand.type.isNumber) && self.arrayDimension == operand.arrayDimension
    }
    
    init(_ type: Type, bounds: [Int] = []) {
        self.type = type
        self.bounds = bounds
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
    
    // get the type of the result of caclculations with binary operation.
    private static func getBinaryType(type1: Type, type2: Type, oper: OperatorElement) throws -> Type {
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
            guard (type1 == type2 || (type1.isNumber && type2.isNumber)) else {
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
    
    static func predictType(_ elements: [BaseElement]) throws -> Type {
        let stack = Stack<(type: Type, isArray: Bool)>()
        
        for element in elements {
            if let operand = element as? OperandElement {
                stack.push((type: operand.type, isArray: operand.isArray))
            } else if let oper = element as? OperatorElement {
                if (oper.operands == .unary) {
                    // do nothing
                } else {
                    guard let operand1 = stack.pop() else {
                        throw SyntaxError("Not enough operand")
                    }
                    guard let operand2 = stack.pop() else {
                        throw SyntaxError("Not enough operand")
                    }
                    
                    if (operand1.isArray || operand2.isArray) {
                        throw InvalidValueError("Arrays cannot be applied for '" + oper.type.rawValue + "' operations.")
                    }
                    
                    try stack.push((type: ExpressionElement.getBinaryType(type1: operand1.type, type2: operand2.type, oper: oper), isArray: false))
                }
            }
        }
        
        guard stack.count == 1, let result = stack.top else {
            throw InvalidValueError("Expression is illegal, please check it.")
        }
        
        return result.type
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
        var tryCode = code
        var deepOfBracket = 0
        var list: [BaseElement] = []
        var couldBeOperand = true
        
        while(tryCode.count > 0) {
            do {
                if couldBeOperand, let const = try ConstantParser.parse(&tryCode) {
                    // constant
                    list.append(const)
                    couldBeOperand = false
                } else if couldBeOperand, let variable = try VariableParser.parse(&tryCode) {
                    // variable
                    list.append(variable)
                    couldBeOperand = false
                } else if couldBeOperand, let function = try FunctionInvokerParser.parse(&tryCode) {
                    // function invoker
                    list.append(function)
                    couldBeOperand = false
                } else if let oper = OperatorParser.parse(&tryCode, preferUnary: couldBeOperand) {
                    // operator
                    list.append(oper)
                    couldBeOperand = true
                } else if let bracket = BracketParser.parse(&tryCode) {
                    if (bracket.direction == .open) {
                        deepOfBracket += 1
                        couldBeOperand = true
                    } else if (bracket.direction == .close) {
                        deepOfBracket -= 1
                        couldBeOperand = false
                    }
                    if (deepOfBracket < 0) {
                        // Out of effective area
                        code = code[(code.count - tryCode.count - 1)...]
                        return list
                    }
                    // bracket
                    list.append(bracket)
                } else {
                    code = tryCode
                    return list
                }
            } catch let error {
                throw error
            }
        }
        
        code = tryCode
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

    static func parse(_ code: inout String) throws -> OperandElement? {
        do {
            let expression = try ExpressionParser.buildExpressionList(&code)
            let elements = ExpressionParser.convertToRPN(expression)
            
            // if there is only one operand in the expression, extract it
            guard elements.count > 1 else {
                // only one or none elements
                guard let operand = elements.first as? OperandElement else {
                    throw SyntaxError("Invalid expression.")
                }
                return operand
            }
            
            return try ExpressionElement(elements)
        } catch let error {
            throw error
        }
    }
}

