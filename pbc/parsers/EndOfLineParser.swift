//
//  NewlineParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class EndOfLineElement: BaseElement {
    var restText: String
    
    init(restText: String) {
        self.restText = restText
    }
}

class EndOfLineParser {
    
    @discardableResult
    static func parse(_ code: inout String) -> EndOfLineElement {
        
        var offset = 0
        while(offset < code.count && code[offset] != "\n" && code[offset] != "\r") {
            offset += 1
        }
        
        let restText = code[..<offset]
        code = code[offset...]
        return EndOfLineElement(restText: restText)
    }
}

