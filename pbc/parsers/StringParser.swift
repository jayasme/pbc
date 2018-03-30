//
//  StringParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/21.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class StringParser {
    
    static func parse(_ code: inout String) throws -> StringFragment? {
        
        guard (SymbolParser.parse(&code, symbol: "\"") != nil) else {
            return nil
        }
        
        var offset: Int = 0
        var endOfQuote: Bool = false
        
        while(offset < code.count) {
            if (code[offset] == "\"") {
                endOfQuote = true
                break
            }
            offset += 1
        }
        
        guard endOfQuote else {
            throw SyntaxError.Illegal_Expression()
        }
        
        let string = code[..<offset]
        code = code[(offset + 1)...]
        WhitespaceParser.parse(&code)
        return StringFragment(string)
    }
}
