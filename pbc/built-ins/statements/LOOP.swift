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
    
    var condition: OperandElement?
    var loopType: LoopType
    
    init(_ condition: OperandElement?, loopType: LoopType) {
        self.condition = condition
        self.loopType = loopType
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        do {
            // check the matched DO statment
            guard let doStatement = (CodeParser.sharedBlock?.firstStatement as? DOStatement) else {
                throw SyntaxError("Cannot find the matched DO statement for this LOOP statment.")
            }
            
            // parse the type
            var loopType: LoopType = .none
            if (KeywordParser.parse(&code, keyword: "WHILE") != nil) {
                loopType = .loopWhile
            } else if (KeywordParser.parse(&code, keyword: "UNTIL") != nil) {
                loopType = .loopUntil
            }

            // parse the expression
            var condition: OperandElement? = nil
            if (loopType != .none) {
                guard let expression = try ExpressionParser.parse(&code) else {
                    throw SyntaxError("Expected a valid expression")
                }
                condition = expression
            }
            
            // check there must and only be one condition between the LOOP and its matched DO statements.
            guard ((doStatement.loopType == .none && loopType != .none) || (doStatement.loopType != .none && loopType == .none)) else {
                throw InvalidValueError("There must and only be one condition between the LOOP and its matched DO statements.")
            }
            
            // check the condition's type
            guard (condition == nil || condition!.type == BOOLEANType) else {
                throw InvalidValueError("DO statement only excepts a boolean as its condition.")
            }
            
            return LOOPStatement.init(condition, loopType: loopType)
        } catch let error {
            throw error
        }
    }
}
