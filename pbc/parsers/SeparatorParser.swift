//
//  SeparatorParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

enum SeparatorType {
    case colon
    case newLine
}

class SeparatorElement: BaseElement {
    var separatorType: SeparatorType
    
    init(_ separatorType: SeparatorType) {
        self.separatorType = separatorType
    }
}

class SeparatorParser {
    
    static func parse(_ code: inout String) -> SeparatorElement? {
        RemarkParser.parse(&code)
        
        if (NewLineParser.parse(&code) != nil) {
            // new line
            WhitespaceParser.parse(&code)
            RemarkParser.parse(&code)
            return SeparatorElement(.newLine)
        }
        
        if (SymbolParser.parse(&code, symbol: ":") != nil) {
            // colon
            WhitespaceParser.parse(&code)
            RemarkParser.parse(&code)
            return SeparatorElement(.colon)
        }
        
        return nil
    }
}

