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
                // parse the variable declaration
                guard let variable = try VariableDeclarationParser.parse(&code)?.variable else {
                    guard (variables.count > 0) else {
                        throw InvalidValueError("Decration requires least one valid name.")
                    }
                    // final of the statement
                    break
                }
                
                variables.append(variable)
                
                // Register the variable
                try FileParser.sharedCompound?.variableManager.registerVariable(variable)
                
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
