//
//  IF.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class IFStatement: BaseStatement, GroupedStatement {
    static var name: String {
        get {
            return "IF"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["IF"]
        }
    }
    
    static var blockIncludesEndStatement: Bool {
        get {
            return false
        }
    }
    
    static func endStatement(statement: BaseStatement) -> Bool {
        return statement is ENDIFStatement
    }
    
    var condition: OperandElement
    
    init(_ condition: OperandElement) {
        self.condition = condition
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        do {
            // parse the condition
            guard let condition = try ExpressionParser.parse(&code) else {
                throw SyntaxError("Requires a valid expression")
            }
            
            // check the expression's type
            guard condition.type == BOOLEANType else {
                throw SyntaxError("IF statement only excepts a boolean as its condition.")
            }
            
            // parse the THEN
            guard KeywordParser.parse(&code, keyword: "THEN") != nil else {
                throw SyntaxError("Requires the keyword 'THEN'")
            }
            
            return IFStatement(condition)
        } catch let error {
            throw error
        }
    }
}
