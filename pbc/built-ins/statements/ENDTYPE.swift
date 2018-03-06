//
//  ENDTYPE.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class ENDTYPEStatement: BaseStatement {
    static var name: String {
        get {
            return "END TYPE"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["END", "TYPE"]
        }
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        return ENDTYPEStatement()
    }
}
