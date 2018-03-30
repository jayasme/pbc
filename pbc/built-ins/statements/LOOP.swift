//
//  WHILE.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class LOOPStatement: BaseStatement {
    static var name: String {
        get {
            return "LOOP"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["LOOP"]
        }
    }
    
    var condition: OperandFragment?
    var loopType: LoopType
    
    init(_ condition: OperandFragment?, loopType: LoopType) {
        self.condition = condition
        self.loopType = loopType
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        // check the matched DO statment
        guard let doStatement = (FileParser.sharedCompound?.firstStatement as? DOStatement) else {
            throw SyntaxError.Cannot_Find_The_Matched_Statement(statement: "DO")
        }
        
        // parse the type
        var loopType: LoopType = .none
        if (KeywordParser.parse(&code, keyword: "WHILE") != nil) {
            loopType = .loopWhile
        } else if (KeywordParser.parse(&code, keyword: "UNTIL") != nil) {
            loopType = .loopUntil
        }
        
        // parse the expression
        var condition: OperandFragment! = nil
        if (loopType != .none) {
            guard let expression = try ExpressionParser.parse(&code) else {
                throw SyntaxError.Illegal_Expression_After(syntax: (loopType == .loopWhile ? "WHILE" : "UNTILE"))
            }
            condition = expression
        }
        
        // check there must and only be one condition between the LOOP and its matched DO statements.
        guard ((doStatement.loopType == .none && loopType != .none) || (doStatement.loopType != .none && loopType == .none)) else {
            throw SyntaxError.Loop_Only_One_Condition()
        }
        
        // check the condition's type
        guard (condition == nil || condition.value.type == BOOLEANType) else {
            throw InvalidTypeError("DO statement only excepts a boolean as its condition.")
        }
        
        return LOOPStatement.init(condition, loopType: loopType)
    }
}
