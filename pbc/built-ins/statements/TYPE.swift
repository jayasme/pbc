//
//  TYPE.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class TYPEStatement: BaseStatement, CompoundStatement {
    static var name: String {
        get {
            return "TYPE"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["TYPE"]
        }
    }
    
    static func endStatement(statement: BaseStatement) -> Bool {
        return statement is ENDTYPEStatement
    }
    
    static var compoundIncludesBeginStatement: Bool {
        get {
            return false
        }
    }
    
    static var compoundIncludesEndStatement: Bool {
        get {
            return false
        }
    }
    
    var typeName: String
    
    init(_ typeName: String) {
        self.typeName = typeName
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        // parse the name
        guard let typeName = PatternedNameParser.parse(&code)?.name else {
            throw InvalidNameError.Invalid_Name_Of(name: "TYPE")
        }
        
        return TYPEStatement(typeName)
    }
}
