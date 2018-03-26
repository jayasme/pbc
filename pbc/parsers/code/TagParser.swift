//
//  TagParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/3.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class TagParser {
    
    static func parse(_ code: inout String) -> TagFragment? {
        guard let tag = PatternedNameParser.parse(&code)?.name else {
            return nil
        }
        
        return TagFragment(tag)
    }
}

class TagDeclarationParser {
    
    static func parse(_ code: inout String) -> TagFragment? {
        var tryCode = code
        
        guard let tag = PatternedNameParser.parse(&tryCode)?.name else {
            return nil
        }
        
        guard (SymbolParser.parse(&tryCode, symbol: ":") != nil) else {
            return nil
        }
        
        code = tryCode
        return TagFragment(tag)
    }
}

