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
            
            guard let declare = CodeParser.sharedDeclareManager.findDeclare(name) else {
                return nil
            }
            
            guard let function = declare as? FunctionDeclare else {
                throw SyntaxError("Only function could be a part of expression.")
            }
            
            // parse the arguments
            guard (BracketParser.parse(&tryCode, expectedDirection: .open) != nil) else {
                throw SyntaxError("Expected '('.")
            }
            
            let arguments = Arguments.empty
            if (BracketParser.parse(&tryCode, expectedDirection: .close) == nil) {
                while(code.count > 0) {
                    
                    guard let operand = try ExpressionParser.parse(&tryCode)?.value else {
                        throw SyntaxError("Expected a valid operand.")
                    }
                    
                    arguments.arguments.append(operand)
                    
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
            
            // check the arguments
            guard (arguments == function.parameters) else {
                throw InvalidValueError("Called function '" + function.name + "' it not mathced to its declaration.")
            }
            
            code = tryCode
            return try FunctionInvokerFragment(function: function, arguments: arguments)
        } catch let error {
            throw error
        }
    }
}
