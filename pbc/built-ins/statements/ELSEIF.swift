//
//  ELSEIF.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class ELSEIFStatement: BaseStatement {
    static var name: String {
        get {
            return "ELSEIF"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["ELSEIF"]
        }
    }
    
    var condition: Operand
    
    init(_ condition: Operand) {
        self.condition = condition
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        // check the matched IF statment
        guard ((FileParser.sharedCompound?.firstStatement as? IFStatement) != nil) else {
            throw SyntaxError.Cannot_Find_The_Matched_Statement(statement: "IF")
        }
        
        // parse the condition
        guard let condition = try ExpressionParser.parse(&code)?.value else {
            throw SyntaxError.Illegal_Expression_After(syntax: "ELSEIF")
        }
        
        // check the expression's type
        guard condition.type == BOOLEANType else {
            throw InvalidTypeError.Expected_Type_Of(typeName: "BOOLEAN", something: "the condition of 'ELSEIF' statement")
        }
        
        // parse the THEN
        guard KeywordParser.parse(&code, keyword: "THEN") != nil else {
            throw SyntaxError.Expected(syntax: "THEN")
        }
        
        return ELSEIFStatement(condition)
    }
}
