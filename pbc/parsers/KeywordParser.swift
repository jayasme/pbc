//
//  KeywordParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/26.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

fileprivate let validKeywordContent = ["A","B","C","D","E","F","G","H","I","J","K", "L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k", "l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8","9"]

class KeywordElement: BaseElement {
    var keyword: String
    
    init(keyword: String) {
        self.keyword = keyword
    }
}

class KeywordParser {
    
    static func parse(_ code: inout String, keyword: String) -> KeywordElement? {
        guard (code.hasPrefix(keyword, caseSensitive: ConfigurationManager.shared.caseSensitive)) else {
            return nil
        }
        
        // If the next character of keyword is a valid keyword content, it means the acutal keyword is not finished yet
        guard (code.count - keyword.count == 0 || !validKeywordContent.contains(code[keyword.count])) else {
            return nil
        }
        
        code = code[keyword.count...]
        WhitespaceParser.parse(&code)
        return KeywordElement(keyword: keyword)
    }
}

