//
//  VariableParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class VariableParser {
    
    static func parse(_ code: inout String) throws -> OperandFragment? {
        var tryCode = code
        
        guard let name = PatternedNameParser.parse(&tryCode)?.name else {
            return nil
        }
        
        guard let variable = CodeParser.sharedBlock?.variableManager.findVariable(name) else {
            return nil
        }
        
        // parse the array bounds
        /* var varSubscripts: [OperandElement] = []
        if let arrayVariable = variable as? ArrayVariable {
            guard (BracketParser.parse(&tryCode, expectedDirection: .open) != nil) else {
                throw SyntaxError("'" + variable.name + "' is an array, must specify the subscript.")
            }
            while(code.count > 0) {
                guard let expression = try ExpressionParser.parse(&tryCode) else {
                    throw SyntaxError("Expected a valid expression.")
                }
                
                // check the expression's type
                guard (expression.type.isRounded) else {
                    throw SyntaxError("The subscripts of array only expects rounded numbers.")
                }
                
                varSubscripts.append(expression)
                
                if (varSubscripts.count == arrayVariable.subscripts.count) {
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
        } */
        
        // code = tryCode
        return OperandFragment(variable)
    }
}

