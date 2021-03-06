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
        let returnVariable = Variable(name: self.function.name, type: self.function.returnType)
        try compound.variableManager.registerVariable(returnVariable)
    }
    
    static func endStatement(statement: BaseStatement) -> Bool {
        return statement is ENDFUNCTIONStatement
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        // parse the name
        guard let funcName = PatternedNameParser.parse(&code)?.name else {
            throw InvalidNameError.Invalid_Name_Of(name: "FUNCTION")
        }
        
        // parse the parameters
        let parameters = Parameters.empty
        if (BracketParser.parse(&code, expectedDirection: .open) != nil) {
            if (BracketParser.parse(&code, expectedDirection: .close) == nil) {
                while(code.count > 0) {
                    guard let parameter = try VariableDeclarationParser.parse(&code, needDimensions: false)?.variable else {
                        throw SyntaxError.Expected_Parameter()
                    }
                    
                    parameters.parameters.append(parameter)
                    
                    if (SymbolParser.parse(&code, symbol: ",") != nil) {
                        // separator
                        continue
                    } else if (BracketParser.parse(&code, expectedDirection: .close) != nil) {
                        // end of the function declaration
                        break
                    }
                    
                    throw SyntaxError.Expected(syntax: ")")
                }
            }
        }
        
        // parse the return type
        var returnType: Type = INTEGERType
        if (KeywordParser.parse(&code, keyword: "AS") != nil) {
            guard let type = try FileParser.sharedCompound?.typeManager.parseType(&code) else {
                throw SyntaxError.Expected_Type()
            }
            returnType = type
        }
        
        // TODO parse the returning subscripts
        let returnSubscripts: Subscripts? = nil
        
        // Find the check declare registeration
        guard let declare = FileParser.sharedDeclareManager.findDeclare(funcName) as? FunctionDeclare else {
            throw SyntaxError.Function_Declare_Not_Found(functionName: funcName)
        }
        guard (declare.module == nil) else {
            throw SyntaxError.Function_Cannot_Implement_External(functionName: funcName)
        }
        guard (declare.procedure == nil) else {
            throw SyntaxError.Function_Reimplement(functionName: funcName)
        }
        guard (declare.parameters == parameters) else {
            throw InvalidTypeError.Implement_Expected_Arguments(arguments: parameters.description, practicalArguments: declare.parameters.description)
        }
        
        guard (declare.returnType == returnType) else {
            throw InvalidTypeError.Implement_Expected_Return_Type(typeName: returnType.name, practicalTypeName: declare.returnType.name)
        }
        
        let function = Function(name: funcName, parameters: parameters, returnType: TypeTuple(returnType, subscripts: returnSubscripts))
        declare.function = function
        
        return FUNCTIONStatement(function)
    }
}
