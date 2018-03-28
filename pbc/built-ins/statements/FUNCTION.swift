//
//  FUNCTION.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/20.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class FUNCTIONStatement: BaseStatement, CompoundStatement {
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

    
    var function: Function
    
    init(_ function: Function) {
        self.function = function
    }
    
    func beginStatement(compound: CompoundStatementFragment) throws {
        for variable in self.function.parameters.parameters {
            try compound.variableManager.registerVariable(variable)
        }
        let returningVariable = Variable(name: self.function.name, type: self.function.returningType)
        try compound.variableManager.registerVariable(returningVariable)
    }
    
    static func endStatement(statement: BaseStatement) -> Bool {
        return statement is ENDFUNCTIONStatement
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        // parse the name
        guard let funcName = PatternedNameParser.parse(&code)?.name else {
            throw InvalidValueError("Function requires a valid name.")
        }
        
        // parse the open bracket
        guard (BracketParser.parse(&code, expectedDirection: .open) != nil) else {
            throw SyntaxError("Function requires a bracket following the function name.")
        }
        
        // parse the parameter bracket
        let parameters = Parameters.empty
        if (BracketParser.parse(&code, expectedDirection: .close) == nil) {
            while(code.count > 0) {
                guard let parameter = try VariableDeclarationParser.parse(&code, needDimensions: false)?.variable else {
                    throw SyntaxError("Expected a valid argument.")
                }
                
                parameters.parameters.append(parameter)
                
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
            guard let type = FileParser.sharedCompound?.typeManager.parseType(&code) else {
                throw SyntaxError("The returning expected a valid type.")
            }
            returningType = type
        }
        
        // TODO parse the returning subscripts
        let returningSubscripts: Subscripts? = nil
        
        // Find the check declare registeration
        guard let declare = FileParser.sharedDeclareManager.findDeclare(funcName) as? FunctionDeclare else {
            throw NotFoundError("Function '" + funcName + "' not declared")
        }
        guard (declare.module == nil) else {
            throw NotFoundError("Cannot implement the declare '" + funcName + "' due to it's a external one.")
        }
        guard (declare.procedure == nil) else {
            throw NotFoundError("Reimplementation of the function '" + funcName + "'.")
        }
        guard (declare.parameters == parameters && declare.returningType == returningType) else {
            throw NotFoundError("Function '" + funcName + "' dismatches its declaration.")
        }
        
        let function = Function(name: funcName, parameters: parameters, returningType: TypeTuple(returningType, subscripts: returningSubscripts))
        declare.function = function
        
        return FUNCTIONStatement(function)
    }
}
