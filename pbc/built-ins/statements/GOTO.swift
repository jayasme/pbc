//
//  GOTO.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class GOTOStatement: BaseStatement {
    static var name: String {
        get {
            return "GOTO"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["GOTO"]
        }
    }
    
    var tag: String
    
    init(_ tag: String) {
        self.tag = tag
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        // parse the line tag
        guard let tag = TagParser.parse(&code)?.tag else {
            throw InvalidValueError("Expected a tag name.")
        }
        
        return GOTOStatement(tag)
    }
}
