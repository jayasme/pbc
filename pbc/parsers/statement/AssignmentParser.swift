//
//  AnonymouseStatement.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/1.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

// AssignmentParser is for anonymouse assignment(without LET)
// LETStatement is for normal assignment(with LET)
class AssignmentParser {
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        do {
            return try LETStatement.parse(&code, expectedStatement: false)
        } catch let error {
            throw error
        }
    }
}
