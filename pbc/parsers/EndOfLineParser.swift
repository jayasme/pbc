//
//  NewlineParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class EndOfLineParser {
    
    @discardableResult
    static func parse(_ code: inout String) -> EndOfLineFragment {
        
        var offset = 0
        while(offset < code.count && code[offset] != "\n" && code[offset] != "\r") {
            offset += 1
        }
        
        let restText = code[..<offset]
        code = code[offset...]
        return EndOfLineFragment(restText: restText)
    }
}

