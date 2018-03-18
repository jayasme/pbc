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
    
    var procedure: Declare
    var arguments: Arguments
    
    init(procedure: Declare, arguments: Arguments) {
        self.procedure = procedure
        self.arguments = arguments
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        do {
            return try CALLStatement.parse(&code, expectedStatement: true)
        } catch let error {
            throw error
        }
    }
    
    static func parse(_ code: inout String, expectedStatement: Bool) throws -> BaseStatement? {
        do {
            var tryCode = code
            
            guard let name = PatternedNameParser.parse(&tryCode)?.name else {
                if (expectedStatement) {
                    throw SyntaxError("Expected a valid name.")
                }
                return nil
            }
            
            guard let procedure = CodeParser.sharedDeclareManager.findDeclare(name) else {
                if (expectedStatement) {
                    throw SyntaxError("Cannot find the declaration.")
                }
                return nil
            }
            
            // To exclude the situation that no arguments invoved and brackets used
            if (BracketParser.parse(&tryCode, expectedDirection: .pair) != nil) {
                // paired brackets
                code = tryCode
                return CALLStatement(procedure: procedure, arguments: Arguments.empty)
            }
            
            // parse the arguments
            // Bracket is optional
            let hasOpenBracket = (BracketParser.parse(&tryCode, expectedDirection: .open) != nil)
            
            var arguments: Arguments = Arguments.empty
            while(code.count > 0) {
                guard let operand = try ExpressionParser.parse(&tryCode)?.value else {
                    throw SyntaxError("Expected a valid expression.")
                }
                
                arguments.arguments.append(operand)
                
                if (SymbolParser.parse(&tryCode, symbol: ",") != nil) {
                    // separator
                    continue
                }
                
                let hasCloseBracket = (BracketParser.parse(&tryCode, expectedDirection: .close) != nil)
                if (hasOpenBracket && !hasCloseBracket) {
                    throw SyntaxError("Expected a close bracket.")
                } else if (!hasOpenBracket && hasCloseBracket) {
                    throw SyntaxError("Unexpected the close bracket.")
                }
                
                break
            }
            
            // check the arguments
            guard (arguments == procedure.parameters) else {
                throw InvalidValueError("Called function '" + procedure.name + "' it not mathced to its declaration.")
            }
            
            code = tryCode
            return CALLStatement(procedure: procedure, arguments: arguments)
        } catch let error {
            throw error
        }
    }
}
