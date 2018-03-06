//
//  DIM.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/21.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class DIMStatement: BaseStatement {
    static var name: String {
        get {
            return "DIM"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["DIM"]
        }
    }
    
    var variables: [Variable] = []
    
    init(variables: [Variable]) {
        self.variables = variables
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        do {
            var variables: [Variable] = []
            
            while (code.count > 0) {
                // parse the variable name
                guard let varName = PatternedNameParser.parse(&code)?.name else {
                    guard (variables.count > 0) else {
                        throw InvalidValueError("Decration requires least one valid name.")
                    }
                    // final of the statement
                    break
                }
                
                var varBounds: [VariableArrayBound] = []
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
                        
                        varBounds.append(VariableArrayBound(lowerBound: lowerBound, upperBound: upperBound))
                        
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
                
                // parse the type
                var varType: Type? = nil
                if (KeywordParser.parse(&code, keyword: "AS") != nil) {
                    guard let type = CodeParser.sharedBlock?.typeManager.parseType(&code) else {
                        throw SyntaxError("Expected a valid type.")
                    }
                    varType = type
                }
                
                // parse the initial value
                var varInital: ExpressionElement? = nil
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
                
                let variable = Variable.init(name: varName, type: varType!, bounds: varBounds, initialValue: varInital)
                variables.append(variable)
                
                // Register the variable
                try CodeParser.sharedBlock?.variableManager.registerVariable(variable)
                
                guard (SymbolParser.parse(&code, symbol: ",") != nil) else {
                    // separator
                    break
                }
            }

            return DIMStatement(variables: variables)
        } catch let error {
            throw error
        }
    }
}
