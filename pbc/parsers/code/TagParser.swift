//
//  TagParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/3.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

fileprivate let validNameInitalsSet = ["_","A","B","C","D","E","F","G","H","I","J","K", "L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k", "l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]

fileprivate let validNameCharacterSet = ["_","A","B","C","D","E","F","G","H","I","J","K", "L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k", "l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8","9"]

class TagElement: FragmentElement {
    var tag: String
    
    init(_ tag: String) {
        self.tag = tag
    }
}

class TagParser {
    
    static func parse(_ code: inout String) -> TagElement? {
        guard (code.count > 0 && validNameInitalsSet.contains(code[0])) else {
            return nil
        }
        
        var offset: Int = 1
        
        while(offset < code.count) {
            let char = code[offset]
            
            if (validNameCharacterSet.contains(char)) {
                // valid name character
                offset += 1
                continue
            }
            
            break
        }
        
        guard (offset < code.count - 1 && code[offset] == ":") else {
            return nil
        }
        
        let tag = code[..<offset]
        code = code[(offset + 1)...]
        WhitespaceParser.parse(&code)
        return TagElement(tag)
    }
}
