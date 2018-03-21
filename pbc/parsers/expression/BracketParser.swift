//
//  BracketParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

enum BracketDirection:Int {
    case open
    case close
    case pair
}

class BracketFragment: BaseFragment {
    var direction: BracketDirection

    init(_ direction: BracketDirection, skippedSpaceCount: Int) {
        self.direction = direction
    }
}

class BracketParser {
    
    static func parse(_ code: inout String, expectedDirection: BracketDirection? = nil) -> BracketFragment? {
        if (code.hasPrefix("(") && (expectedDirection == nil || expectedDirection == .open)) {
            code = code[1...]
            return BracketFragment(.open, skippedSpaceCount: WhitespaceParser.parse(&code).spaceCount)
        }
        
        if (code.hasPrefix(")") && (expectedDirection == nil || expectedDirection == .close)) {
            code = code[1...]
            WhitespaceParser.parse(&code)
            return BracketFragment(.close, skippedSpaceCount: WhitespaceParser.parse(&code).spaceCount)
        }
        
        // enter the paired bracket parser zone
        guard (expectedDirection == nil || expectedDirection == .pair) else {
            return nil
        }
        
        var tryCode = code
        if (BracketParser.parse(&tryCode, expectedDirection: .open) != nil && BracketParser.parse(&tryCode, expectedDirection: .close) != nil) {
            code = tryCode
            return BracketFragment(.pair, skippedSpaceCount: WhitespaceParser.parse(&code).spaceCount)
        }
        
        return nil
    }
}
