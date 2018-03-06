//
//  DO.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

enum LoopType {
    case none
    case loopWhile
    case loopUntil
}

class DOStatement: BaseStatement, GroupedStatement {
    static var name: String {
        get {
            return "DO"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["DO"]
        }
    }
    
    var condition: ExpressionElement?
    var loopType: LoopType
    
    init(_ condition: ExpressionElement?, loopType: LoopType) {
        self.condition = condition
        self.loopType = loopType
    }
    
    static func endStatement(statement: BaseStatement) -> Bool {
        return statement is LOOPStatement
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        do {
            // parse the type
            var loopType: LoopType = .none
            if (KeywordParser.parse(&code, keyword: "WHILE") != nil) {
                loopType = .loopWhile
            } else if (KeywordParser.parse(&code, keyword: "UNTIL") != nil) {
                loopType = .loopUntil
            }
            
            // parse the expression
            var condition: ExpressionElement? = nil
            if (loopType != .none) {
                guard let expression = try ExpressionParser.parse(&code) else {
                    throw SyntaxError("Expected a valid expression")
                }
                condition = expression
            }
            
            // check the expression's type
            guard (condition == nil || condition!.type == BOOLEANType) else {
                throw InvalidValueError("DO statement only excepts a boolean as its condition.")
            }
            
            return DOStatement.init(condition, loopType: loopType)
        } catch let error {
            throw error
        }
    }
}
