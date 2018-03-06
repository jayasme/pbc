//
//  ENDSUB.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class ENDSUBStatement: BaseStatement {
    static var name: String {
        get {
            return "END SUB"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["END", "SUB"]
        }
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        return ENDSUBStatement()
    }
}
