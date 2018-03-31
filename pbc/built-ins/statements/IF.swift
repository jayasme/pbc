//
//  IF.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class IFStatement: BaseStatement, CompoundStatement {
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
    
    var condition: Operand
    
    init(_ condition: Operand) {
        self.condition = condition
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        // parse the condition
        guard let condition = try ExpressionParser.parse(&code)?.value else {
            throw SyntaxError.Illegal_Expression_After(syntax: "IF")
        }
        
        // check the expression's type
        guard condition.type == BOOLEANType else {
            throw InvalidTypeError.Expected_Type_Of(typeName: "BOOLEAN", something: "the condition of 'IF' statement")
        }
        
        // parse the THEN
        guard KeywordParser.parse(&code, keyword: "THEN") != nil else {
            throw SyntaxError.Expected(syntax: "THEN")
        }
        
        return IFStatement(condition)
    }
}
