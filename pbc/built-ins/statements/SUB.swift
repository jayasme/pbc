//
//  SUB.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class SUBStatement: BaseStatement, CompoundStatement {
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
    
    static var compoundIncludesBeginStatement: Bool {
        get {
            return false
        }
    }
    
    static var compoundIncludesEndStatement: Bool {
        get {
            return false
        }
    }

    var sub: Sub
    
    init(_ sub: Sub) {
        self.sub = sub
    }
    
    func beginStatement(compound: CompoundStatementFragment) throws {
        do {
            for variable in self.sub.parameters.parameters {
                try compound.variableManager.registerVariable(variable)
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
            
            // parse the parameters bracket
            let parameters = Parameters.empty
            if (BracketParser.parse(&code, expectedDirection: .close) == nil) {
                while(code.count > 0) {
                    guard let argument = try VariableDeclarationParser.parse(&code, needDimensions: false)?.variable else {
                        throw SyntaxError("Expected a valid argument.")
                    }

                    parameters.parameters.append(argument)
                    
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
            guard let declare = FileParser.sharedDeclareManager.findDeclare(subName) else {
                throw NotFoundError("Sub '" + subName + "' not declared")
            }
            guard (declare.module == nil) else {
                throw NotFoundError("Cannot implement the declare '" + subName + "' due to it's a external one.")
            }
            guard (declare.procedure == nil) else {
                throw NotFoundError("Reimplementation of the sub '" + subName + "'.")
            }
            guard (declare.parameters == parameters) else {
                throw NotFoundError("Sub '" + subName + "' dismatches its declaration.")
            }
            
            let sub = Sub(name: subName, parameters: parameters)
            declare.procedure = sub
            
            return SUBStatement(sub)
        } catch let error {
            throw error
        }
    }
}
