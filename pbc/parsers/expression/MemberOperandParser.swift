//
//  MemberOperandParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class MemberOperandParser {
    
    static func parse(_ code: inout String, parentType: Type) throws -> MemberOperandFragment? {
        var tryCode = code
        
        guard SymbolParser.parse(&tryCode, symbol: ".") != nil else {
            return nil
        }
        
        guard let name = PatternedNameParser.parse(&tryCode)?.name else {
            throw InvalidValueError("Expected a valid field name")
        }
        
        code = tryCode
        
        return try MemberOperandFragment(MemberOperand(name, parent: parentType))
    }
}
