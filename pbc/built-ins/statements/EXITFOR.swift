//
//  EXITFOR.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/6.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class EXITFORStatement: BaseStatement {
    static var name: String {
        get {
            return "EXIT FOR"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["EXIT", "FOR"]
        }
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        guard ((CodeParser.sharedBlock?.firstStatement as? FORStatement) != nil) else {
            throw SyntaxError("EXIT FOR statement can only contained in a FOR loop.")
        }
        return EXITFORStatement()
    }
}