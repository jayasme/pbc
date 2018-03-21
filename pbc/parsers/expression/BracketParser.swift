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

    init(_ direction: BracketDirection) {
        self.direction = direction
    }
}

class BracketParser {
    
    static func parse(_ code: inout String, expectedDirection: BracketDirection? = nil) -> BracketFragment? {
        if (code.hasPrefix("(") && (expectedDirection == nil || expectedDirection == .open)) {
            code = code[1...]
            WhitespaceParser.parse(&code)
            return BracketFragment(.open)
        }
        
        if (code.hasPrefix(")") && (expectedDirection == nil || expectedDirection == .close)) {
            code = code[1...]
            WhitespaceParser.parse(&code)
            return BracketFragment(.close)
        }
        
        // enter the paired bracket parser zone
        guard (expectedDirection == nil || expectedDirection == .pair) else {
            return nil
        }
        
        var tryCode = code
        if (BracketParser.parse(&tryCode, expectedDirection: .open) != nil && BracketParser.parse(&tryCode, expectedDirection: .close) != nil) {
            code = tryCode
            WhitespaceParser.parse(&code)
            return BracketFragment(.pair)
        }
        
        return nil
    }
}
