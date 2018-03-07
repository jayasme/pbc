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
            // parse the variable
            guard let variable = try VariableParser.parse(&code)?.variable else {
                throw InvalidValueError("Expected a valid variable.")
            }
            
            // parse the equality sign
            guard (SymbolParser.parse(&code, symbol: "=") != nil) else {
                throw InvalidValueError("Expected an equality symbol")
            }
            
            // parse the expression
            guard let expression = try ExpressionParser.parse(&code) else {
                throw InvalidValueError("Expected an valid expression")
            }
            
            // if assignment type is dismatched, only decimals can pass the check
            guard (variable.type == expression.type || (variable.type.isNumber && expression.type.isNumber)) else {
                throw InvalidValueError("Cannot assign '" + expression.type.name + "' to a variable of type '" + variable.type.name + "'.")
            }

            return LETStatement(variable: variable, expression: expression)
        } catch let error {
            throw error
        }
    }
}
