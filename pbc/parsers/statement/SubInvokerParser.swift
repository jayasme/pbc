//
//  SubInvokerParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/8.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

// SubInvokerParser is for anonymouse sub invoker(without CALL)
// CALLStatement is for normal assignment(with CALL)
class SubInvokerParser {
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        return try CALLStatement.parse(&code, expectedStatement: false)
    }
}
