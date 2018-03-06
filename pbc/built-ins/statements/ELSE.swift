//
//  ELSE.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation


class ELSEStatement: BaseStatement {
    static var name: String {
        get {
            return "ELSE"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["ELSE"]
        }
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        return ELSEStatement()
    }
}
