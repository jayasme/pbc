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
        return try CALLStatement.parse(&code, expectedStatement: true)
    }
    
    static func parse(_ code: inout String, expectedStatement: Bool) throws -> BaseStatement? {
        var tryCode = code
        
        guard let name = PatternedNameParser.parse(&tryCode)?.name else {
            if (expectedStatement) {
                throw SyntaxError.Expected_Pattern()
            }
            return nil
        }
        
        guard let procedure = FileParser.sharedDeclareManager.findDeclare(name) else {
            if (expectedStatement) {
                throw InvalidValueError.Cannot_Find_The_Declaration(declarationName: name)
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
        
        let arguments: Arguments = Arguments.empty
        while(code.count > 0) {
            guard let operand = try ExpressionParser.parse(&tryCode)?.value else {
                throw SyntaxError.Illegal_Expression()
            }
            
            arguments.arguments.append(operand)
            
            if (SymbolParser.parse(&tryCode, symbol: ",") != nil) {
                // separator
                continue
            }
            
            let hasCloseBracket = (BracketParser.parse(&tryCode, expectedDirection: .close) != nil)
            if (hasOpenBracket && !hasCloseBracket) {
                throw SyntaxError.Expected(syntax: ")")
            } else if (!hasOpenBracket && hasCloseBracket) {
                throw SyntaxError.Unexpected(syntax: ")")
            }
            
            break
        }
        
        // check the arguments
        guard (arguments.isConformWith(parameters: procedure.parameters)) else {
            throw InvalidTypeError.Invoker_Expected_Arguments(arguments: arguments.description, practicalArguments: procedure.parameters.description)
        }
        
        code = tryCode
        return CALLStatement(procedure: procedure, arguments: arguments)
    }
}
