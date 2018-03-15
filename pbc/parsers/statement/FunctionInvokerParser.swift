//
//  FunctionInvokerParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/7.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class FunctionInvokerParser {
    
    static func parse(_ code: inout String) throws -> FunctionInvokerFragment? {
        do {
            var tryCode = code
            
            guard let name = PatternedNameParser.parse(&tryCode)?.name else {
                return nil
            }
            
            guard let function = CodeParser.sharedDeclareManager.findDeclare(name) else {
                return nil
            }
            
            // parse the arguments
            guard (BracketParser.parse(&tryCode, expectedDirection: .open) != nil) else {
                throw SyntaxError("Expected '('.")
            }
            
            var funcArguments: [Operand] = []
            if (BracketParser.parse(&tryCode, expectedDirection: .close) == nil) {
                while(code.count > 0) {
                    guard funcArguments.count < function.arguments.arguments.count else {
                        throw InvalidValueError("Function '" + function.name + "' only recieves " + String( function.arguments.arguments.count) + " arguments.")
                    }
                    
                    guard let expression = try ExpressionParser.parse(&tryCode) else {
                        throw SyntaxError("Expected a valid expression.")
                    }
                    
                    let decArg = function.arguments.arguments[funcArguments.count]
                    
                    // check if the expression's type is matched with function's declaration
                    guard (expression.operand.isCompatibleWith(decArg)) else {
                        throw SyntaxError("The type of argument " + String(funcArguments.count + 1) + " is not matched to its declaration.")
                    }
                    
                    // TODO check if the expression and the arguments are both array or not.
                    
                    funcArguments.append(expression)
                    
                    if (SymbolParser.parse(&tryCode, symbol: ",") != nil) {
                        // separator
                        continue
                    } else if (BracketParser.parse(&tryCode, expectedDirection: .close) != nil) {
                        // end of the function declaration
                        break
                    }
                    
                    throw SyntaxError("Expected a close bracket.")
                }
            }
            
            code = tryCode
            return try FunctionInvokerFragment(function, arguments: funcArguments)
        } catch let error {
            throw error
        }
    }
}
