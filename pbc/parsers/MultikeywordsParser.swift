//
//  MultipleKeywordParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/3.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class MultikeywordsElement: BaseElement {
    var keywords: [String]
    
    init(keywords: [String]) {
        self.keywords = keywords
    }
}

class MultikeywordsParser {
    
    static func parse(_ code: inout String, keywords: [String]) -> MultikeywordsElement? {
        var tryCode = code
        
        for keyword in keywords {
            guard KeywordParser.parse(&tryCode, keyword: keyword) != nil else {
                return nil
            }
            
            WhitespaceParser.parse(&tryCode)
        }

        code = tryCode
        return MultikeywordsElement(keywords: keywords)
    }
}
