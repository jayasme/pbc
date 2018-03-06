//
//  CALL.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class CALLStatement: BaseStatement {
    static var name: String {
        get {
            return "CALL"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["CALL"]
        }
    }
    
    var sub: Procedure
    var arguments: [ExpressionElement]
    
    init(sub: Procedure, arguments: [ExpressionElement]) {
        self.sub = sub
        self.arguments = arguments
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        do {
            // parse the procedure
            guard let declare = CodeParser.sharedDeclareManager.parse(&code) else {
                throw NotFoundError("Sub not found.")
            }
            guard let procedure = declare.procedure else {
                throw InvalidValueError("Declaration not implemented.")
            }
            guard procedure.isSub else {
                throw InvalidValueError("Cannot call a function.")
            }
            
            // parse the argument list
            var arguments: [ExpressionElement] = []
            while(code.count > 0) {
                guard let argument = try ExpressionParser.parse(&code) else {
                    break
                }
                
                arguments.append(argument)
                
                guard (SymbolParser.parse(&code, symbol: ",") != nil) else {
                    break
                }
            }
            
            // TODO: Validate the arugments between call & declaration
            
            return CALLStatement(sub: PRINTProcedure, arguments: arguments)
        } catch let error {
            throw error
        }
    }
}
