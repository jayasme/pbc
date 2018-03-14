//
//  exp.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/3.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class OperandElement: BaseElement {
    var operand: Operand

    init(_ operand: Operand) {
        self.operand = operand
    }
}

class ExpressionElement: OperandElement {
    init(_ expression: Expression) throws {
        super.init(expression)
    }
}

class ExpressionParser {    
    // build expression list from the expression string
    private static func buildExpressionList(_ code: inout String) throws -> [ExpressionItem] {
        var tryCode = code
        var deepOfBracket = 0
        var list: [BaseElement] = []
        var couldBeOperand = true
        
        while(tryCode.count > 0) {
            do {
                if couldBeOperand, let const = try ConstantParser.parse(&tryCode) {
                    // constant
                    list.append(const.operand)
                    couldBeOperand = false
                } else if couldBeOperand, let variable = try VariableParser.parse(&tryCode) {
                    // variable
                    list.append(variable.operand)
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
    private static func convertToRPN(_ elements: [ExpressionItem]) -> [ExpressionItem] {
        let stack = Stack<ExpressionItem>()
        var result: [ExpressionItem] = []
        
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

