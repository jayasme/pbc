//
//  VariableDecrationParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/11.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class VariableDeclarationFragment {
    var variable: Variable
    var initialValue: Operand?
    
    init(_ variable: Variable, initialValue: Operand?) {
        self.variable = variable
        self.initialValue = initialValue
    }
}

class VariableDeclarationParser {
    
    static func parse(_ code: inout String, needDimensions: Bool = true) throws -> VariableDeclarationFragment? {
        guard let varName = PatternedNameParser.parse(&code)?.name else {
            return nil
        }
        
        var varSubscripts: Subscripts! = nil
        // parse the array bounds
        if (BracketParser.parse(&code, expectedDirection: .open) != nil) {
            varSubscripts = Subscripts.empty
            if (BracketParser.parse(&code, expectedDirection: .close) == nil) {
                while(code.count > 0) {
                    guard let leftBound = try DecimalParser.parse(&code, expectedType: INTEGERType) else {
                        throw SyntaxError.Expected_Valid_Bound()
                    }
                    
                    if (KeywordParser.parse(&code, keyword: "TO") != nil) {
                        // The second bound(upper bound) indicated
                        let lowerBound: Int32 = leftBound.integerValue
                        guard let rightBound = try DecimalParser.parse(&code, expectedType: INTEGERType) else {
                            throw SyntaxError.Expected_Valid_Upper_Bound()
                        }
                        let upperBound: Int32 = rightBound.integerValue
                        varSubscripts = try Subscripts(baseSubscripts: varSubscripts, attached: Subscript(lowerBound: lowerBound, upperBound: upperBound))
                    } else {
                        // The second bound not indicated
                        let upperBound: Int32 = leftBound.integerValue
                        varSubscripts = try Subscripts(baseSubscripts: varSubscripts, attached: Subscript(upperBound: upperBound))
                    }
                    
                    if (SymbolParser.parse(&code, symbol: ",") != nil) {
                        // separator
                        continue
                    } else if (BracketParser.parse(&code, expectedDirection: .close) != nil) {
                        // end of the bound declaration
                        break
                    }
                    
                    throw SyntaxError.Expected(syntax: ")")
                }
            }
        }
        
        // parse the type
        var varType: Type!
        if (KeywordParser.parse(&code, keyword: "AS") != nil) {
            guard let type = FileParser.sharedCompound?.typeManager.parseType(&code) else {
                throw InvalidTypeError("Expected a valid type.")
            }
            varType = type
        }
        
        // parse the '='
        var initialValue: Operand? = nil
        if (SymbolParser.parse(&code, symbol: "=") != nil) {
            guard let operand = try ExpressionParser.parse(&code)?.value else {
                throw SyntaxError.Illegal_Expression_After(syntax: "=")
            }
            
            initialValue = operand
        }
        
        var type: TypeTuple!
        if let initialValue = initialValue {
            if (varType == nil) {
                // type inferred by the initial value
                varType = initialValue.type.type
            }

            if (varSubscripts != nil && varSubscripts.isDynamic) {
                // subscripts inferred by the inital value
                varSubscripts = initialValue.type.subscripts
            }
            
            type = TypeTuple(varType, subscripts: varSubscripts)
        } else {
            if let varType = varType {
                type = TypeTuple(varType, subscripts: varSubscripts)
            } else {
                // the default type is int
                type = TypeTuple(INTEGERType, subscripts: varSubscripts)
            }
            
            guard (!needDimensions || varSubscripts == nil || !varSubscripts.isDynamic) else {
                throw InvalidTypeError("Must specify the dimensions for the variable '" + varName + "'.")
            }
        }
        
        // check the type
        guard (initialValue == nil || initialValue!.type.isCompatibleWith(type: type)) else {
            throw InvalidTypeError("The type of initial value '" + initialValue!.type.name + "' dismatches to '" + type.name + "'")
        }
        
        return VariableDeclarationFragment(Variable(name: varName, type: type), initialValue: initialValue)
    }
}
