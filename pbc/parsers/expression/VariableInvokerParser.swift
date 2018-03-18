//
//  VariableInvokerParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class VariableInvokerParser {
    
    static func parse(_ code: inout String) throws -> VariableInvokerFragment? {
        var tryCode = code
        
        guard let name = PatternedNameParser.parse(&tryCode)?.name else {
            return nil
        }
        
        guard let variable = CodeParser.sharedBlock?.variableManager.findVariable(name) else {
            return nil
        }
        
        // parse the array bounds
        let subscripts: Arguments = Arguments.empty
        if (variable.isArray) {
            guard (BracketParser.parse(&tryCode, expectedDirection: .open) != nil) else {
                throw SyntaxError("'" + variable.name + "' is an array, must specify the subscripts.")
            }
            while(code.count > 0) {
                guard let operand = try ExpressionParser.parse(&tryCode)?.value else {
                    throw SyntaxError("Expected a valid expression.")
                }
                
                // check the expression's type
                guard (operand.type.isRounded) else {
                    throw SyntaxError("The subscripts of array only expects rounded numbers.")
                }
                
                subscripts.arguments.append(operand)
                
                if (SymbolParser.parse(&tryCode, symbol: ",") != nil) {
                    // separator
                    continue
                } else if (BracketParser.parse(&tryCode, expectedDirection: .close) != nil) {
                    // end of the bound declaration
                    break
                }
                
                throw SyntaxError("Expected a close bracket.")
            }
        }
        
        code = tryCode
        if let array = variable as? ArrayVariable {
            return try VariableInvokerFragment(variable: array, subscripts: subscripts)
        } else {
            return try VariableInvokerFragment(variable: variable)
        }
    }
}

