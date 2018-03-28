//
//  SeparatorParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class SeparatorParser {
    
    static func parse(_ code: inout String) -> SeparatorFragment? {
        RemarkParser.parse(&code)
        
        if (NewLineParser.parse(&code) != nil) {
            // new line
            WhitespaceParser.parse(&code)
            RemarkParser.parse(&code)
            return SeparatorFragment(.newLine)
        }
        
        if (SymbolParser.parse(&code, symbol: ":") != nil) {
            // colon
            WhitespaceParser.parse(&code)
            RemarkParser.parse(&code)
            return SeparatorFragment(.colon)
        }
        
        return nil
    }
}

