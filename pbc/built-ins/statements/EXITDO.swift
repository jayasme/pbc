//
//  EXITDO.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/6.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class EXITDOStatement: BaseStatement {
    static var name: String {
        get {
            return "EXIT DO"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["EXIT", "DO"]
        }
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        guard ((FileParser.sharedCompound?.firstStatement as? DOStatement) != nil) else {
            throw SyntaxError("EXIT DO statement can only contained in a DO loop.")
        }
        return EXITFORStatement()
    }
}
