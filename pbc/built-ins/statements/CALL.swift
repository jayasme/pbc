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
    
    var sub: Declare
    var arguments: [ExpressionElement]
    
    init(sub: Declare, arguments: [ExpressionElement]) {
        self.sub = sub
        self.arguments = arguments
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        do {
            var tryCode = code
            
            guard let name = PatternedNameParser.parse(&tryCode)?.name else {
                throw SyntaxError("Expected a valid name.")
            }
            
            guard let sub = CodeParser.sharedDeclareManager.findDeclare(name) else {
                throw SyntaxError("Cannot find the declaration.")
            }
            
            // To exclude the situation that no arguments invoved and brackets used
            if (BracketParser.parse(&tryCode, expectedDirection: .pair) != nil) {
                // paired brackets
                code = tryCode
                return CALLStatement(sub: sub, arguments: [])
            }
            
            // parse the arguments
            // Bracket is optional
            let hasOpenBracket = (BracketParser.parse(&tryCode, expectedDirection: .open) != nil)
            
            var subArguments: [ExpressionElement] = []
            while(code.count > 0) {
                guard subArguments.count < sub.arguments.arguments.count else {
                    throw InvalidValueError("Sub '" + sub.name + "' only recieves " + String(sub.arguments.arguments.count) + " arguments.")
                }
                
                guard let expression = try ExpressionParser.parse(&tryCode) else {
                    throw SyntaxError("Expected a valid expression.")
                }
                
                let decArg = sub.arguments.arguments[subArguments.count]
                
                // check if the expression's type is matched with function's declaration
                guard (expression.type == decArg.type || (expression.type.isNumber && decArg.type.isNumber)) else {
                    throw SyntaxError("The type of argument " + String(subArguments.count + 1) + " is not matched to its declaration.")
                }
                
                // TODO check if the expression and the arguments are both array or not.
                
                subArguments.append(expression)
                
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
            
            code = tryCode
            return CALLStatement(sub: sub, arguments: subArguments)
        } catch let error {
            throw error
        }
    }
}
