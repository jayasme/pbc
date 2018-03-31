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
        for variable in self.sub.parameters.parameters {
            try compound.variableManager.registerVariable(variable)
        }
    }
    
    static func endStatement(statement: BaseStatement) -> Bool {
        return statement is ENDSUBStatement
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        // parse the name
        guard let subName = PatternedNameParser.parse(&code)?.name else {
            throw InvalidNameError.Invalid_Name_Of(name: "SUB")
        }
        
        // parse the parameters
        let parameters = Parameters.empty
        if (BracketParser.parse(&code, expectedDirection: .open) != nil) {
            if (BracketParser.parse(&code, expectedDirection: .close) == nil) {
                while(code.count > 0) {
                    guard let argument = try VariableDeclarationParser.parse(&code, needDimensions: false)?.variable else {
                        throw SyntaxError.Excepted_Argument()
                    }
                    
                    parameters.parameters.append(argument)
                    
                    if (SymbolParser.parse(&code, symbol: ",") != nil) {
                        // separator
                        continue
                    } else if (BracketParser.parse(&code, expectedDirection: .close) != nil) {
                        // end of the sub declaration
                        break
                    }
                    
                    throw SyntaxError.Expected(syntax: ")")
                }
            }
        }
        
        // Find the check declare registeration
        guard let declare = FileParser.sharedDeclareManager.findDeclare(subName) else {
            throw SyntaxError.Sub_Declare_Not_Found(subName: subName)
        }
        guard (declare.module == nil) else {
            throw SyntaxError.Sub_Cannot_Implement_External(subName: subName)
        }
        guard (declare.procedure == nil) else {
            throw SyntaxError.Sub_Reimplement(subName: subName)
        }
        guard (declare.parameters == parameters) else {
            throw ArgumentsError("Sub '" + subName + "' dismatches its declaration.")
        }
        
        let sub = Sub(name: subName, parameters: parameters)
        declare.procedure = sub
        
        return SUBStatement(sub)
    }
}
