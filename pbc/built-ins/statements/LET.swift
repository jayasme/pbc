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
    
    var variable: Variable
    
    var expression: ExpressionElement
    
    init(variable: Variable, expression: ExpressionElement) {
        self.variable = variable
        self.expression = expression
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        do {
            return try LETStatement.parse(&code)
        } catch let error {
            throw error
        }
    }
    
    static func parse(_ code: inout String, expectedStatement: Bool) throws -> BaseStatement? {
        do {
            var tryCode = code
            
            // parse the variable
            guard let variable = try VariableParser.parse(&tryCode)?.variable else {
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
            guard let expression = try ExpressionParser.parse(&tryCode) else {
                throw InvalidValueError("Expected an valid expression")
            }
            
            // if assignment type is dismatched, only decimals can pass the check
            guard (variable.type == expression.type || (variable.type.isNumber && expression.type.isNumber)) else {
                throw InvalidValueError("Cannot assign '" + expression.type.name + "' to a variable of type '" + variable.type.name + "'.")
            }
            
            code = tryCode
            return LETStatement(variable: variable, expression: expression)
        } catch let error {
            throw error
        }
    }
}
