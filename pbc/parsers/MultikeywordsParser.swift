//
//  MultipleKeywordParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/3.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class MultikeywordsParser {
    
    static func parse(_ code: inout String, keywords: [String]) -> MultikeywordsFragment? {
        var tryCode = code
        
        for keyword in keywords {
            guard KeywordParser.parse(&tryCode, keyword: keyword) != nil else {
                return nil
            }
            
            WhitespaceParser.parse(&tryCode)
        }

        code = tryCode
        return MultikeywordsFragment(keywords: keywords)
    }
}
