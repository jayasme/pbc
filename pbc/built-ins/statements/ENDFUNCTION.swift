//
//  ENDFUNCTION.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/3.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class ENDFUNCTIONStatement: BaseStatement {
    static var name: String {
        get {
            return "END FUNCTION"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["END", "FUNCTION"]
        }
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        return ENDFUNCTIONStatement()
    }
}
