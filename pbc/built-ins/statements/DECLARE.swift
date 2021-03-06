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
        // DECLARE FUNCTION|SUB name [ALIAS alias] [MODULE module](parameters...) [AS returnType[()]]
        
        // parse FUNCTION / SUB
        var isFunction: Bool? = nil
        if (KeywordParser.parse(&code, keyword: "FUNCTION") != nil) {
            isFunction = true
        } else if (KeywordParser.parse(&code, keyword: "SUB") != nil) {
            isFunction = false
        }
        
        guard (isFunction != nil) else {
            throw SyntaxError.Declare_Expected_Function_Or_Sub()
        }
        
        // parse the name
        guard let declareName = PatternedNameParser.parse(&code)?.name else {
            throw InvalidNameError.Invalid_Name_Of(name: "DECLARE")
        }
        
        // parse the alias
        var aliasName: String? = nil
        if (KeywordParser.parse(&code, keyword: "ALIAS") != nil) {
            guard let alias = PatternedNameParser.parse(&code) else {
                throw InvalidNameError.Invalid_Name_Of(name: "ALIAS")
            }
            aliasName = alias.name
        }
        
        // parse the lib
        var moduleName: String? = nil
        if (KeywordParser.parse(&code, keyword: "MODULE") != nil) {
            guard let module = try StringParser.parse(&code) else {
                throw InvalidNameError.Invalid_Name_Of(name: "MODULE")
            }
            moduleName = module.value
        }
        
        // parse the parameters
        let parameters = Parameters.empty
        if (BracketParser.parse(&code, expectedDirection: .open) != nil) {
            // parse the parameters bracket
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
        
        var declare: Declare! = nil
        
        // parse the returning type
        if (isFunction == true) {
            var returnType: Type! = nil
            if (KeywordParser.parse(&code, keyword: "AS") != nil) {
                guard let type = try FileParser.sharedCompound?.typeManager.parseType(&code) else {
                    throw SyntaxError.Expected_Type()
                }
                returnType = type
            } else {
                returnType = INTEGERType
            }
            
            declare = FunctionDeclare(
                name: declareName,
                alias: aliasName,
                module: moduleName,
                parameters: parameters,
                returnType: TypeTuple(returnType))
        } else {
            
            declare = SubDeclare(
                name: declareName,
                alias: aliasName,
                module: moduleName,
                parameters: parameters)
        }
        
        try FileParser.sharedDeclareManager.registerDeclare(declare)
        
        return DECLAREStatement(declare)
    }
}
