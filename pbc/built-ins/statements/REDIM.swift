//
//  REDIM.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class VariableRedimension {
    var variable: Variable
    var newSubscripts: Subscripts
    
    init(variable: Variable, newSubscripts: Subscripts) {
        self.variable = variable
        self.newSubscripts = newSubscripts
    }
}

class REDIMStatement: BaseStatement {
    static var name: String {
        get {
            return "REDIM"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["REDIM"]
        }
    }
    
    var redimensions: [VariableRedimension] = []
    var preserve: Bool
    init(redimensions: [VariableRedimension], preserve: Bool) {
        self.redimensions = redimensions
        self.preserve = preserve
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        var redimensions: [VariableRedimension] = []
        
        let preserve = (KeywordParser.parse(&code, keyword: "PRESERVE") != nil)
        
        while (code.count > 0) {
            // parse the variable name
            guard let variable = FileParser.sharedCompound?.variableManager.parse(&code) else {
                // quit of the statement
                break
            }
            
            guard (variable.type.isArray) else {
                throw SyntaxError.Redim_Expected_Array_Variable(variableName: variable.name)
            }
            
            var subscripts = Subscripts.empty
            // parse the array bounds
            if (BracketParser.parse(&code, expectedDirection: .open) != nil) {
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
                            subscripts = try Subscripts(baseSubscripts: subscripts, attached: Subscript(lowerBound: lowerBound, upperBound: upperBound))
                        } else {
                            // The second bound not indicated
                            let upperBound: Int32 = leftBound.integerValue
                            subscripts = try Subscripts(baseSubscripts: subscripts, attached: Subscript(upperBound: upperBound))
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
            
            let redimension = VariableRedimension(variable: variable, newSubscripts: subscripts)
            redimensions.append(redimension)
            
            guard (SymbolParser.parse(&code, symbol: ",") != nil) else {
                // separator
                break
            }
        }
        
        guard (redimensions.count > 0) else {
            throw SyntaxError.Redim_Expected_At_Least_One_Argument()
        }
        
        return REDIMStatement(redimensions: redimensions, preserve: preserve)
    }
}
