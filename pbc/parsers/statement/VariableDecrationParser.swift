//
//  VariableDecrationParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/11.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class VariableDeclarationElement {
    var variable: Variable
    
    init(_ variable: Variable) {
        self.variable = variable
    }
}

class VariableDeclarationParser {
    
    static func parse(_ code: inout String) throws -> VariableDeclarationElement? {
        do {
            guard let varName = PatternedNameParser.parse(&code)?.name else {
                return nil
            }
            
            var varSubscripts: [ArraySubscript]! = nil
            // parse the array bounds
            if (BracketParser.parse(&code, expectedDirection: .open) != nil) {
                varSubscripts = []
                if (BracketParser.parse(&code, expectedDirection: .close) == nil) {
                    while(code.count > 0) {
                        var lowerBound: Int32 = 1
                        var upperBound: Int32 = 1
                        
                        guard let leftBound = try DecimalParser.parse(&code, expectedType: INTEGERType) else {
                            throw SyntaxError("Expected a valid array bound.")
                        }
                        
                        if (KeywordParser.parse(&code, keyword: "TO") != nil) {
                            // The second bound(upper bound) indicated
                            lowerBound = leftBound.integerValue
                            guard let rightBound = try DecimalParser.parse(&code, expectedType: INTEGERType) else {
                                throw SyntaxError("Expected a valid upper bound.")
                            }
                            upperBound = rightBound.integerValue
                        } else {
                            // The second bound not indicated
                            lowerBound = 1
                            upperBound = leftBound.integerValue
                        }
                        
                        guard lowerBound < upperBound else {
                            throw InvalidValueError("Invalid array bounds indicated.")
                        }
                        
                        varSubscripts.append(ArraySubscript(lowerBound: lowerBound, upperBound: upperBound))
                        
                        if (SymbolParser.parse(&code, symbol: ",") != nil) {
                            // separator
                            continue
                        } else if (BracketParser.parse(&code, expectedDirection: .close) != nil) {
                            // end of the bound declaration
                            break
                        }
                        
                        throw SyntaxError("Expected a close bracket.")
                    }
                }
            }
            
            // parse the type
            var varType: Type!
            if (KeywordParser.parse(&code, keyword: "AS") != nil) {
                guard let type = CodeParser.sharedBlock?.typeManager.parseType(&code) else {
                    throw SyntaxError("Expected a valid type.")
                }
                varType = type
            }
            
            // parse the initial value
            var varInital: OperandElement? = nil
            if (SymbolParser.parse(&code, symbol: "=") != nil) {
                guard let expression = try ExpressionParser.parse(&code) else {
                    throw SyntaxError("Expected a valid expression to be the initial value.")
                }
                varInital = expression
            }
            
            if (varType == nil) {
                if let initalValue = varInital {
                    // Determined by the inital value
                    varType = initalValue.type
                } else {
                    // integer by default
                    varType = INTEGERType
                }
            }
            
            // Proceed the initalization
            if let inital = varInital {
                // Check the type is matched with the inital value's type
                guard (inital.type == varType || (inital.type.isNumber && varType.isNumber)) else {
                    throw InvalidValueError("Cannot assign '" + inital.type.name + "' to a value of type '" + varType.name + "'")
                }
                
                guard ((inital.isArray && varSubscripts != nil) || (!inital.isArray && varSubscripts == nil)) else {
                    throw InvalidValueError("Cannot assign an array to a non-array variabel, on the contraty assign a non-array to an array variable is also not allowed.")
                }
            }
            
            if (varSubscripts == nil) {
                return VariableDeclarationElement(Variable(name: varName, type: varType, initialValue: varInital))
            }
            
            return VariableDeclarationElement(ArrayVariable(name: varName, type: varType, subscripts: varSubscripts, initialValue: varInital))
        } catch let error {
            throw error
        }
    }
}
