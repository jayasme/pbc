//
//  VariableParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class VariableElement: OperandElement {
    var variable: Variable
    var subscripts: [OperandElement]
    
    init(_ variable: Variable, subscripts: [ExpressionElement] = []) {
        self.variable = variable
        self.subscripts = subscripts
        super.init(variable.type)
    }
}

class VariableParser {
    
    static func parse(_ code: inout String) throws -> VariableElement? {
        var tryCode = code
        
        guard let name = PatternedNameParser.parse(&tryCode)?.name else {
            return nil
        }
        
        guard let variable = CodeParser.sharedBlock?.variableManager.findVariable(name) else {
            return nil
        }
        
        // parse the array bounds
        var varSubscripts: [ExpressionElement] = []
        if (variable.subscripts.count > 0) {
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
                
                if (varSubscripts.count == variable.subscripts.count) {
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
        }
        
        code = tryCode
        return VariableElement(variable, subscripts: varSubscripts)
    }
}

/*
 // Seek for the following character to determine it is a function / array or not
 while(currCode.hasPrefix("(") || currCode.hasPrefix(",") || currCode.hasPrefix(")")) {
 if (parameters == nil) {
 parameters = []
 }
 
 let subParser = ExpressionParser.init(currCode[1...])
 do {
 let subTuple = try subParser.parse()
 parameters!.append(subTuple.instructions)
 if (subTuple.rest.hasPrefix(")")) {
 // end of the function or array
 currCode = subTuple.rest[1...]
 break
 } else {
 currCode = subTuple.rest
 }
 } catch let error {
 throw error
 }
 }
 */

