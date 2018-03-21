//
//  SpaceParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class WhitespaceElement: BaseElement {
    var spaceCount: Int
    
    init(spaceCount: Int) {
        self.spaceCount = spaceCount
    }
}

class WhitespaceParser {
    
    @discardableResult
    static func parse(_ code: inout String) -> WhitespaceElement {
        
        var offset = 0
        while(offset < code.count && (code[offset] == " " || code[offset] == "\t")) {
            offset += 1
        }
        if (offset > 0) {
            code = code[offset...]
        }
        return WhitespaceElement(spaceCount: offset)
    }
}
