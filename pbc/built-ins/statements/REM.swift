//
//  REM.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

// RemarkElement is for ' type remarks
// REMStatement is for REM type remarks
class REMStatement: BaseStatement {
    static var name: String {
        get {
            return "REM"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["REM"]
        }
    }
    
    var remark: String
    
    init(_ remark: String) {
        self.remark = remark
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        let endOfLine = EndOfLineParser.parse(&code)
        return REMStatement.init(endOfLine.restText)
    }
}
