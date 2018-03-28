//
//  LET.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/16.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class LETStatement: BaseStatement {
    static var name: String {
        get {
            return "LET"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["LET"]
        }
    }
    
    var variable: VariableOperand
    
    var expression: Operand
    
    init(variable: VariableOperand, expression: Operand) {
        self.variable = variable
        self.expression = expression
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        return try LETStatement.parse(&code)
    }
    
    static func parse(_ code: inout String, expectedStatement: Bool) throws -> BaseStatement? {
        var tryCode = code
        
        // parse the variable
        guard let variable = try VariableOperandParser.parse(&tryCode)?.variableOperand else {
            if (expectedStatement) {
                throw InvalidValueError("Expected a valid variable.")
            }
            return nil
        }
        
        // parse the equality sign
        guard (SymbolParser.parse(&tryCode, symbol: "=") != nil) else {
            if (expectedStatement) {
                throw InvalidValueError("Expected an equality symbol")
            }
            return nil
        }
        
        // parse the expression
        guard let expression = try ExpressionParser.parse(&tryCode)?.value else {
            throw InvalidValueError("Expected an valid expression")
        }
        
        // check the type of variable & expression
        
        guard (variable.type.isCompatibleWith(type: expression.type)) else {
            throw InvalidValueError("Cannot assign '" + expression.type.name + "' to a variable of type '" + variable.type.name + "'.")
        }
        
        code = tryCode
        return LETStatement(variable: variable, expression: expression)
    }
}
