//
//  PRINT.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PRINTStatement: BaseStatement {
    static var name: String {
        get {
            return "PRINT"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["PRINT"]
        }
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        do {
            // parse the arguments
            var arguments: [ExpressionElement] = []
            while(code.count > 0) {
                guard let argument = try ExpressionParser.parse(&code) else {
                    break
                }
                
                arguments.append(argument)
                
                guard (SymbolParser.parse(&code, symbol: ";") != nil) else {
                    break
                }
            }
            
            return CALLStatement(sub: PRINTProcedure, arguments: arguments)
        } catch let error {
            throw error
        }
    }
}
