//
//  FUNCTION.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/20.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class FUNCTIONStatement: GroupedStatement, BaseStatement {
    static var name: String {
        get {
            return "FUNCTION"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["FUNCTION"]
        }
    }
    
    static var blockIncludesBeginStatement: Bool {
        get {
            return false
        }
    }
    
    static var blockIncludesEndStatement: Bool {
        get {
            return false
        }
    }

    
    var function: Procedure
    
    init(_ function: Procedure) {
        self.function = function
    }
    
    func beginStatement(block: BlockElement) throws {
        do {
            for argument in self.function.arguments.arguments {
                try block.variableManager.registerVariable(argument)
            }
            try block.variableManager.registerVariable(Variable(name: self.function.name, type: self.function.returningType!))
        } catch let error {
            throw error
        }
    }
    
    static func endStatement(statement: BaseStatement) -> Bool {
        return statement is ENDFUNCTIONStatement
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        do {
            // parse the name
            guard let funcName = PatternedNameParser.parse(&code)?.name else {
                throw InvalidValueError("Function requires a valid name.")
            }
            
            // parse the open bracket
            guard (BracketParser.parse(&code, expectedDirection: .open) != nil) else {
                throw SyntaxError("Function requires a bracket following the function name.")
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
            var returningType: Type = INTEGERType
            if (KeywordParser.parse(&code, keyword: "AS") != nil) {
                guard let type = CodeParser.sharedBlock?.typeManager.parseType(&code) else {
                    throw SyntaxError("The returning expected a valid type.")
                }
                returningType = type
            }
            
            // Find the check declare registeration
            guard let declare = CodeParser.sharedDeclareManager.findDeclare(funcName) else {
                throw NotFoundError("Function '" + funcName + "' not declared")
            }
            guard (declare.module == nil) else {
                throw NotFoundError("Cannot implement the declare '" + funcName + "' due to it's a external one.")
            }
            guard (declare.procedure == nil) else {
                throw NotFoundError("Reimplementation of the function '" + funcName + "'.")
            }
            guard (declare.arguments == arguments && declare.returningType == returningType) else {
                throw NotFoundError("Function '" + funcName + "' dismatches its declaration.")
            }
            
            let function = Procedure(name: funcName, arguments: arguments, returningType: returningType)
            declare.procedure = function
            
            return FUNCTIONStatement(function)
        } catch let error {
            throw error
        }
    }
}
