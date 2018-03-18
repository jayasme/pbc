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
            let arguments = Arguments.empty
            while(code.count > 0) {
                guard let argument = try ExpressionParser.parse(&code)?.value else {
                    break
                }
                
                arguments.arguments.append(argument)
                
                guard (SymbolParser.parse(&code, symbol: ";") != nil) else {
                    break
                }
            }
            
            return CALLStatement(procedure: BuiltInDeclares.PRINTDeclare, arguments: arguments)
        } catch let error {
            throw error
        }
    }
}
