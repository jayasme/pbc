//
//  SymbolParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/1.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class SymbolParser {
    
    static func parse(_ code: inout String, symbol: String) -> SymbolFragment? {
        guard (code.hasPrefix(symbol)) else {
            return nil
        }
        
        code = code[symbol.count...]
        WhitespaceParser.parse(&code)
        return SymbolFragment(symbol: symbol)
    }
}
