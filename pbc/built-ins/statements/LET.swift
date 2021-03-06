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
                throw SyntaxError.Expected_Pattern()
            }
            return nil
        }
        
        // parse the equality sign
        guard (SymbolParser.parse(&tryCode, symbol: "=") != nil) else {
            if (expectedStatement) {
                throw SyntaxError.Expected(syntax: "=")
            }
            return nil
        }
        
        // parse the expression
        guard let expression = try ExpressionParser.parse(&tryCode)?.value else {
            throw SyntaxError.Illegal_Expression()
        }
        
        // check the type of variable & expression
        
        guard (variable.type.isCompatibleWith(type: expression.type)) else {
            throw InvalidTypeError.Cannot_Convert_Type_From_To(fromType: expression.type.name, toType: variable.type.name)
        }
        
        code = tryCode
        return LETStatement(variable: variable, expression: expression)
    }
}
