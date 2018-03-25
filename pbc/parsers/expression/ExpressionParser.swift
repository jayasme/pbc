//
//  exp.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/3.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class ExpressionParser {    

    private static func parseNextFragment(_ code: inout String, preferUnary: Bool) throws -> BaseFragment? {
        if let constant = try ConstantOperandParser.parse(&code) {
            // constant operand
            return constant
        } else if let variable = try VariableOperandParser.parse(&code) {
            // variable operand
            return variable
        } else if let function = try FunctionOperandParser.parse(&code) {
            // function operand
            return function
        } else if let oper = OperatorParser.parse(&code, preferUnary: preferUnary) {
            // operator
            return oper
        } else if let bracket = BracketParser.parse(&code), bracket.direction != .pair {
            return bracket
        } else {
            return nil
        }
    }
    
    static func parse(_ code: inout String) throws -> OperandFragment? {
        var tryCode = code
        let stack = Stack<BaseFragment>()
        var fragments: [BaseFragment] = []
        var couldBeOperand = true
        var deepOfBracket = 0
        
        while(tryCode.count > 0) {
            guard let fragment = try ExpressionParser.parseNextFragment(&tryCode, preferUnary: couldBeOperand) else {
                break
            }
            
            if let bracket = fragment as? BracketFragment {
                if (bracket.direction == .open) {
                    // open bracket
                    stack.push(bracket)
                    couldBeOperand = false
                    deepOfBracket += 1
                } else {
                    // close bracket
                    deepOfBracket -= 1
                    guard (deepOfBracket >= 0) else {
                        break
                    }
                    
                    while (
                        stack.count > 0 &&
                            (!(stack.top is BracketFragment) || (
                                stack.top is BracketFragment &&
                                    (stack.top as! BracketFragment).direction != .open))
                        ) {
                            fragments.append(stack.pop()!)
                    }
                    if (stack.count > 0) {
                        _ = stack.pop()
                    }
                    couldBeOperand = true
                }
            } else if let oper = (fragment as? OperatorFragment)?.operatorValue {
                while let topOper = (stack.top as? OperatorFragment)?.operatorValue, oper.piority <= topOper.piority {
                    fragments.append(stack.pop()!)
                }
                stack.push(fragment)
                couldBeOperand = true
            } else if fragment is OperandFragment {
                fragments.append(fragment)
                couldBeOperand = false
            }
            
            code = tryCode
        }
        
        while let top = stack.pop() {
            guard top is ExpressionSubFragment else {
                throw InvalidValueError("Unexpected expression")
            }
            fragments.append(top)
        }
        
        // if there is only one operand in the expression, extract it
        guard fragments.count > 1 else {
            // only one or none elements
            guard let operand = fragments.first as? OperandFragment else {
                throw SyntaxError("Invalid expression.")
            }
            return operand
        }
        
        return try ExpressionFragment(fragments as! [ExpressionSubFragment])
    }
}

