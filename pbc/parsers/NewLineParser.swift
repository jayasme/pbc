//
//  NewLineParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class NewLineParser {
    
    @discardableResult
    static func parse(_ code: inout String) -> NewLineFragment? {
        guard (code.count > 0 && (code[0] == "\n" || code[0] == "\r")) else {
            return nil
        }
        
        code = code[1...]
        WhitespaceParser.parse(&code)
        return NewLineFragment()
    }
}

