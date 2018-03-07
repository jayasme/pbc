//
//  FunctionInvokerParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/7.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class FunctionElement: OperandElement {
    var function: Declare
    var arguments: [ExpressionElement]
    
    init(_ function: Declare, arguments: [ExpressionElement] = []) throws {
        guard let returningType = function.returningType else {
            throw InvalidValueError("SUB cannot be a part of expression.")
        }
        self.function = function
        self.arguments = arguments
        super.init(returningType)
    }
}

class FunctionParser {
    
    static func parse(_ code: inout String) throws -> FunctionElement? {
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
            
            var funArguments: [ExpressionElement] = []
            while(code.count > 0) {
                guard let expression = try ExpressionParser.parse(&tryCode) else {
                    throw SyntaxError("Expected a valid expression.")
                }
                
                let decArg = function.arguments.arguments[funArguments.count]
                
                // check if the expression's type is matched with function's declaration
                guard (expression.type == decArg.type || (expression.type.isNumber && decArg.type.isNumber)) else {
                    throw SyntaxError("The type of argument " + String(funArguments.count) + " is not matched to its declaration.")
                }
                
                funArguments.append(expression)
                
                if (funArguments.count == function.arguments.arguments.count) {
                    break
                }
                
                guard (SymbolParser.parse(&tryCode, symbol: ",") != nil) else {
                    // separator
                    throw SyntaxError("Expected ','.")
                }
            }
            
            guard (SymbolParser.parse(&tryCode, symbol: ")") != nil) else {
                // separator
                throw SyntaxError("Expected ')'.")
            }
            
            code = tryCode
            return try FunctionElement(function, arguments: funArguments)
        } catch let error {
            throw error
        }
    }
}
