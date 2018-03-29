//
//  exp.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/3.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class ExpressionParser {    

    private static func parseFragments(_ code: inout String) throws -> [BaseFragment] {
        var tryCode = code
        var fragments: [BaseFragment] = []
        var couldBeOperand = true
        var deepOfBracket = 0
        var lastType: TypeTuple? = nil
        
        while(tryCode.count > 0) {
            if couldBeOperand, let constant = try ConstantOperandParser.parse(&tryCode) {
                // constant operand
                couldBeOperand = false
                lastType = constant.value.type
                fragments.append(constant)
            } else if couldBeOperand, let variable = try VariableOperandParser.parse(&tryCode) {
                // variable operand
                couldBeOperand = false
                lastType = variable.value.type
                fragments.append(variable)
            } else if couldBeOperand, let function = try FunctionOperandParser.parse(&tryCode) {
                // function operand
                couldBeOperand = false
                lastType = function.value.type
                fragments.append(function)
            } else if let oper = OperatorParser.parse(&tryCode, preferUnary: couldBeOperand) {
                // operator
                couldBeOperand = true
                lastType = nil
                fragments.append(oper)
            } else if let bracket = BracketParser.parse(&tryCode), bracket.direction != .pair {
                if (bracket.direction == .open) {
                    deepOfBracket += 1
                    couldBeOperand = true
                } else if (bracket.direction == .close) {
                    deepOfBracket -= 1
                    couldBeOperand = false
                    guard (deepOfBracket >= 0) else {
                        break
                    }
                }
                lastType = nil
                fragments.append(bracket)
            } else if let parentType = lastType?.type, let members = try MemberOperandParser.parse(&tryCode, parentType: parentType) {
                lastType = members.value.type
                couldBeOperand = false
                fragments += [OperatorFragment(.dot), members]
            } else {
                break
            }
            
            code = tryCode
        }
        
        return fragments
    }
    
    static func parse(_ code: inout String) throws -> OperandFragment? {
        let stack = Stack<BaseFragment>()
        let fragments: [BaseFragment] = try ExpressionParser.parseFragments(&code)
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
                            result.append(stack.pop() as! ExpressionSubFragment)
                    }
                    if (stack.count > 0) {
                        _ = stack.pop()
                    }
                }
            } else if let oper = (fragment as? OperatorFragment)?.operatorValue {
                while let topOper = (stack.top as? OperatorFragment)?.operatorValue, oper.piority <= topOper.piority {
                    result.append(stack.pop() as! ExpressionSubFragment)
                }
                stack.push(fragment)
            } else if let operand = fragment as? OperandFragment {
                result.append(operand)
            }
        }
        
        while let top = stack.pop() {
            guard let fragment = top as? ExpressionSubFragment else {
                throw SyntaxError.Illegal_Expression()
            }
            result.append(fragment)
        }
        
        // if there is only one operand in the expression, extract it
        guard result.count > 1 else {
            // only one or none fragments
            guard let operand = result.first as? OperandFragment else {
                throw SyntaxError.Illegal_Expression()
            }
            return operand
        }
        
        return try ExpressionFragment(result)
    }
}

