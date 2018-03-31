//
//  NEXT.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class NEXTStatement: BaseStatement {
    static var name: String {
        get {
            return "NEXT"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["NEXT"]
        }
    }
    
    var counter: Variable
    
    init(_ counter: Variable) {
        self.counter = counter
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        // check the matched FOR statment
        guard let forStatement = (FileParser.sharedCompound?.firstStatement as? FORStatement) else {
            throw SyntaxError.Cannot_Find_The_Matched_Statement(statement: "FOR")
        }
        
        // parse the variable
        guard let nextName = PatternedNameParser.parse(&code)?.name else {
            return NEXTStatement(forStatement.counter)
        }
        
        guard forStatement.counter.name == nextName else {
            throw InvalidNameError.Next_Dismatch_For()
        }
        
        return NEXTStatement(forStatement.counter)
    }
}
