//
//  SymbolParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/1.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class SymbolElement: BaseElement {
    var symbol: String
    
    init(symbol: String) {
        self.symbol = symbol
    }
}

class SymbolParser {
    
    static func parse(_ code: inout String, symbol: String) -> SymbolElement? {
        guard (code.hasPrefix(symbol)) else {
            return nil
        }
        
        code = code[symbol.count...]
        WhitespaceParser.parse(&code)
        return SymbolElement(symbol: symbol)
    }
}
