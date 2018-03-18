//
//  exp.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/3.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class ExpressionParser {    
    // build expression list from the expression string
    private static func buildExpressionFragments(_ code: inout String) throws -> [ExpressionSubFragment] {
        var tryCode = code
        var deepOfBracket = 0
        var fragments: [ExpressionSubFragment] = []
        var couldBeOperand = true
        
        while(tryCode.count > 0) {
            do {
                if couldBeOperand, let constant = try ConstantParser.parse(&tryCode) {
                    // constant
                    fragments.append(constant)
                    couldBeOperand = false
                } else if couldBeOperand, let variable = try VariableParser.parse(&tryCode) {
                    // variable
                    fragments.append(variable)
                    couldBeOperand = false
                } else if couldBeOperand, let function = try FunctionInvokerParser.parse(&tryCode) {
                    // function invoker
                    fragments.append(function)
                    couldBeOperand = false
                } else if let oper = OperatorParser.parse(&tryCode, preferUnary: couldBeOperand) {
                    // operator
                    fragments.append(oper)
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
                        return fragments
                    }
                    // bracket
                    fragments.append(bracket)
                } else {
                    code = tryCode
                    return fragments
                }
            } catch let error {
                throw error
            }
        }
        
        code = tryCode
        return fragments
    }
    
    // convert to RPN
    private static func convertToRPN(_ fragments: [ExpressionSubFragment]) -> [ExpressionSubFragment] {
        let stack = Stack<ExpressionSubFragment>()
        var result: [ExpressionSubFragment] = []
        
        for fragment in fragments {
            if let bracket = fragment as? BracketFragment {
                if (bracket.direction == .open) {
                    // open bracket
                    stack.push(bracket)
                } else {
                    // close bracket
                    while (
                        stack.count > 0 &&
                        (!(stack.top is BracketFragment) || (
                        stack.top is BracketFragment &&
                        (stack.top as! BracketFragment).direction != .open))
                    ) {
                        result.append(stack.pop()!)
                    }
                    if (stack.count > 0) {
                        _ = stack.pop()
                    }
                }
            } else if let oper = fragment.operatorValue {
                while let topOper = stack.top?.operatorValue, oper.piority <= topOper.piority {
                    result.append(stack.pop()!)
                }
                stack.push(fragment)
            } else if fragment is OperandFragment {
                result.append(fragment)
            }
        }
        
        while let top = stack.pop() {
            result.append(top)
        }
        
        return result
    }

    static func parse(_ code: inout String) throws -> OperandFragment? {
        do {
            let fragments = try ExpressionParser.convertToRPN(ExpressionParser.buildExpressionFragments(&code))
            
            // if there is only one operand in the expression, extract it
            guard fragments.count > 1 else {
                // only one or none elements
                guard let operand = fragments.first as? OperandFragment else {
                    throw SyntaxError("Invalid expression.")
                }
                return operand
            }
            
            return try ExpressionFragment(fragments)
        } catch let error {
            throw error
        }
    }
}

