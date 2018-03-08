//
//  RemarkParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

// RemarkElement is for ' type remarks
// REMStatement is for REM type remarks
class RemarkElement: BaseElement {
    var remark: String

    init(_ remark: String) {
        self.remark = remark
    }
}

class RemarkParser {
    
    @discardableResult
    static func parse(_ code: inout String) -> RemarkElement? {
        guard (SymbolParser.parse(&code, symbol: "'") != nil) else {
            return nil
        }
        
        // Seek for the end of the line
        let endOfLine = EndOfLineParser.parse(&code)
        return RemarkElement(endOfLine.restText)
    }
}

