//
//  FunctionOperandParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/7.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class FunctionOperandParser {
    
    static func parse(_ code: inout String) throws -> FunctionOperandFragment? {
        var tryCode = code
        
        guard let name = PatternedNameParser.parse(&tryCode)?.name else {
            return nil
        }
        
        guard let declare = FileParser.sharedDeclareManager.findDeclare(name) else {
            return nil
        }
        
        guard let function = declare as? FunctionDeclare else {
            throw SyntaxError.Function_Cannot_Be_Found(functionName: declare.name)
        }
        
        // parse the arguments
        guard (BracketParser.parse(&tryCode, expectedDirection: .open) != nil) else {
            throw SyntaxError.Expected(syntax: "(")
        }
        
        let arguments = Arguments.empty
        if (BracketParser.parse(&tryCode, expectedDirection: .close) == nil) {
            while(code.count > 0) {
                
                guard let operand = try ExpressionParser.parse(&tryCode)?.value else {
                    throw SyntaxError.Illegal_Expression()
                }
                
                arguments.arguments.append(operand)
                
                if (SymbolParser.parse(&tryCode, symbol: ",") != nil) {
                    // separator
                    continue
                } else if (BracketParser.parse(&tryCode, expectedDirection: .close) != nil) {
                    // end of the function declaration
                    break
                }
                
                throw SyntaxError.Expected(syntax: ")")
            }
        }
        
        // check the arguments
        guard (arguments.isConformWith(parameters: function.parameters)) else {
            throw ArgumentsError("Called function '" + function.name + "' it not mathced to its declaration.")
        }
        
        code = tryCode
        return FunctionOperandFragment(function: function, arguments: arguments)
    }
}
