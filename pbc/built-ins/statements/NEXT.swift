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
        do {
            // get the counter variable
            guard let counter = ((CodeParser.sharedBlock?.fragments.first as? StatementElement)?.statement as? FORStatement)?.counter else {
                throw InvalidValueError("Cannot find the counter variable.")
            }
            
            // parse the variable
            guard let nextName = PatternedNameParser.parse(&code)?.name else {
                return NEXTStatement(counter)
            }
            
            guard counter.name == nextName else {
                throw InvalidValueError("Mismatched loop counter '" + nextName + "'.")
            }
            
            return NEXTStatement(counter)
        } catch let error {
            throw error
        }
    }
}
