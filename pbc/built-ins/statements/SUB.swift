//
//  SUB.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class SUBStatement: GroupedStatement, BaseStatement {
    static var name: String {
        get {
            return "SUB"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["SUB"]
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

    var sub: Procedure
    
    init(_ sub: Procedure) {
        self.sub = sub
    }
    
    func beginStatement(block: BlockElement) throws {
        do {
            for argument in self.sub.arguments.arguments {
                try block.variableManager.registerVariable(argument)
            }
        } catch let error {
            throw error
        }
    }
    
    static func endStatement(statement: BaseStatement) -> Bool {
        return statement is ENDSUBStatement
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        do {
            // parse the name
            guard let subName = PatternedNameParser.parse(&code)?.name else {
                throw InvalidValueError("Sub requires a valid name.")
            }
            
            // parse the open bracket
            guard (BracketParser.parse(&code, expectedDirection: .open) != nil) else {
                throw SyntaxError("Sub requires a bracket following the sub name.")
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
                        // end of the sub declaration
                        break
                    }
                    
                    throw SyntaxError("Expected a close bracket.")
                }
            }
            
            // Find the check declare registeration
            guard let declare = CodeParser.sharedDeclareManager.findDeclare(subName) else {
                throw NotFoundError("Sub '" + subName + "' not declared")
            }
            guard (declare.module == nil) else {
                throw NotFoundError("Cannot implement the declare '" + subName + "' due to it's a external one.")
            }
            guard (declare.procedure == nil) else {
                throw NotFoundError("Reimplementation of the sub '" + subName + "'.")
            }
            guard (declare.arguments == arguments) else {
                throw NotFoundError("Sub '" + subName + "' dismatches its declaration.")
            }
            
            let sub = Procedure(name: subName, arguments: arguments)
            declare.procedure = sub
            
            return SUBStatement(sub)
        } catch let error {
            throw error
        }
    }
}
