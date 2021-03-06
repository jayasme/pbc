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

class DOStatement: BaseStatement, CompoundStatement {
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
    
    var condition: OperandFragment?
    var loopType: LoopType
    
    init(_ condition: OperandFragment?, loopType: LoopType) {
        self.condition = condition
        self.loopType = loopType
    }
    
    static func endStatement(statement: BaseStatement) -> Bool {
        return statement is LOOPStatement
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
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
        
        // check the expression's type
        guard (condition == nil || condition.value.type == BOOLEANType) else {
            throw InvalidTypeError.Expected_Type_Of(typeName: "BOOLEAN", something: "the condition of 'DO' statement")
        }
        
        return DOStatement.init(condition, loopType: loopType)
    }
}
