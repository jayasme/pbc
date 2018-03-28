//
//  RemarkParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class RemarkParser {
    
    @discardableResult
    static func parse(_ code: inout String) -> RemarkFragment? {
        guard (SymbolParser.parse(&code, symbol: "'") != nil) else {
            return nil
        }
        
        // Seek for the end of the line
        let endOfLine = EndOfLineParser.parse(&code)
        return RemarkFragment(endOfLine.restText)
    }
}

