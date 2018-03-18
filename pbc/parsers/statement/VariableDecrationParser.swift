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
    
    init(_ variable: Variable) {
        self.variable = variable
    }
}

class VariableDeclarationParser {
    
    static func parse(_ code: inout String) throws -> VariableDeclarationFragment? {
        do {
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
                            throw SyntaxError("Expected a valid array bound.")
                        }
                        
                        if (KeywordParser.parse(&code, keyword: "TO") != nil) {
                            // The second bound(upper bound) indicated
                            let lowerBound: Int32 = leftBound.integerValue
                            guard let rightBound = try DecimalParser.parse(&code, expectedType: INTEGERType) else {
                                throw SyntaxError("Expected a valid upper bound.")
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
            
            if (varSubscripts != nil) {
                return VariableDeclarationFragment(ArrayVariable(name: varName, type: varType, subscripts: varSubscripts))
            }
            
            return VariableDeclarationFragment(Variable(name: varName, type: varType))
            
        } catch let error {
            throw error
        }
    }
}
