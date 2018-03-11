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
    var newSubscripts: [ArraySubscript]
    
    init(variable: Variable, newSubscripts: [ArraySubscript]) {
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
        do {
            var redimensions: [VariableRedimension] = []
            
            let preserve = (KeywordParser.parse(&code, keyword: "PRESERVE") != nil)
            
            while (code.count > 0) {
                // parse the variable name
                guard let variable = CodeParser.sharedBlock?.variableManager.parse(&code) else {
                    // final of the statement
                    break
                }
                
                guard let arrayVariable = variable as? ArrayVariable else {
                    throw InvalidValueError("Variable '" + variable.name + "' is not an array.")
                }
                
                var varSubscripts: [ArraySubscript] = []
                // parse the array bounds
                if (BracketParser.parse(&code, expectedDirection: .open) != nil) {
                    var lowerBound: Int32 = 1
                    var upperBound: Int32 = 1
                    while(code.count > 0) {
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
                
                let redimension = VariableRedimension(variable: arrayVariable, newSubscripts: varSubscripts)
                redimensions.append(redimension)
                
                guard (SymbolParser.parse(&code, symbol: ",") != nil) else {
                    // separator
                    break
                }
            }
            
            guard (redimensions.count > 0) else {
                throw InvalidValueError("Redim statement requires least one valid name.")
            }
            
            return REDIMStatement(redimensions: redimensions, preserve: preserve)
        } catch let error {
            throw error
        }
    }
}
