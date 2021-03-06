//
//  VariableOperandParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class VariableOperandParser {
    
    static func parse(_ code: inout String) throws -> VariableOperandFragment? {
        var tryCode = code
        
        guard let name = PatternedNameParser.parse(&tryCode)?.name else {
            return nil
        }
        
        guard let variable = FileParser.sharedCompound?.variableManager.findVariable(name) else {
            return nil
        }
        
        // parse the array bounds
        let subscripts: Arguments = Arguments.empty
        if (variable.type.isArray) {
            if (BracketParser.parse(&tryCode, expectedDirection: .open) != nil) {
                while(tryCode.count > 0) {
                    guard let operand = try ExpressionParser.parse(&tryCode)?.value else {
                        throw SyntaxError.Illegal_Expression()
                    }
                    
                    // check the type of expression
                    guard (operand.type.isRounded) else {
                        throw InvalidTypeError.Expected_Type_Of(typeName: "SHORT/INTEGER/LONG", something: "the subscripts of array")
                    }
                    
                    subscripts.arguments.append(operand)
                    
                    if (SymbolParser.parse(&tryCode, symbol: ",") != nil) {
                        // separator
                        continue
                    } else if (BracketParser.parse(&tryCode, expectedDirection: .close) != nil) {
                        // end of the bound declaration
                        break
                    }
                    
                    throw SyntaxError.Expected(syntax: ")")
                }
            }
        }
        
        code = tryCode
        return try VariableOperandFragment(variable: variable, subscripts: subscripts)
    }
}

