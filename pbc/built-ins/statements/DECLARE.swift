//
//  DECLARE.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/1.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class DECLAREStatement: BaseStatement {
    static var name: String {
        get {
            return "DECLARE"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["DECLARE"]
        }
    }
    
    var declare: Declare
    
    init(_ declare: Declare) {
        self.declare = declare
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        // DECLARE FUNCTION|SUB name [ALIAS alias] [MODULE module](parameters...) [AS returningType]
        
        do {
            // parse FUNCTION / SUB
            var isFunction: Bool? = nil
            if (KeywordParser.parse(&code, keyword: "FUNCTION") != nil) {
                isFunction = true
            } else if (KeywordParser.parse(&code, keyword: "SUB") != nil) {
                isFunction = false
            }
            
            guard (isFunction != nil) else {
                throw SyntaxError("Expected keyword 'FUNCTION' or 'SUB'")
            }
            
            // parse the name
            guard let declareName = PatternedNameParser.parse(&code)?.name else {
                throw InvalidValueError("Declare requires a valid name.")
            }
            
            // parse the alias
            var aliasName: String? = nil
            if (KeywordParser.parse(&code, keyword: "ALIAS") != nil) {
                guard let alias = PatternedNameParser.parse(&code) else {
                    throw InvalidValueError("Invalid alias name.")
                }
                aliasName = alias.name
            }
            
            // parse the lib
            var moduleName: String? = nil
            if (KeywordParser.parse(&code, keyword: "MODULE") != nil) {
                guard let module = try StringParser.parse(&code) else {
                    throw InvalidValueError("Invalid module name.")
                }
                moduleName = module.value
            }
            
            // parse the open bracket
            guard (BracketParser.parse(&code, expectedDirection: .open) != nil) else {
                throw SyntaxError("Declare requires a bracket following the declaration name.")
            }
            
            // parse the argument bracket
            let arguments = ArgumentList()
            if (BracketParser.parse(&code, expectedDirection: .close) == nil) {
                while(code.count > 0) {
                    guard let argument = try VariableDeclarationParser.parse(&code)?.variable else {
                        throw SyntaxError("Expected a valid argument.")
                    }

                    arguments.arguments.append(argument)
                    
                    if (SymbolParser.parse(&code, symbol: ",") != nil) {
                        // separator
                        continue
                    } else if (BracketParser.parse(&code, expectedDirection: .close) != nil) {
                        // end of the function declaration
                        break
                    }
                    
                    throw SyntaxError("Expected a close bracket.")
                }
            }
            
            // parse the returning type
            var returningType: Type? = nil
            if (isFunction == true) {
                if (KeywordParser.parse(&code, keyword: "AS") != nil) {
                    guard let type = CodeParser.sharedBlock?.typeManager.parseType(&code) else {
                        throw SyntaxError("The returning expected a valid type.")
                    }
                    returningType = type
                } else {
                    returningType = INTEGERType
                }
            }
            
            let declare = Declare(
                name: declareName,
                alias: aliasName,
                module: moduleName,
                arguments: arguments,
                returningType: returningType)
            try CodeParser.sharedDeclareManager.registerDeclare(declare)
            
            return DECLAREStatement(declare)
        } catch let error {
            throw error
        }
    }
}
