//
//  VariableParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class VariableElement: OperandElement {
    var variable: Variable
    
    init(_ variable: Variable) {
        self.variable = variable
        super.init(variable.type)
    }
}

class VariableParser {
    
    static func parse(_ code: inout String) throws -> VariableElement? {
        var tryCode = code
        // check if the variable exists
        guard let variable = CodeParser.sharedBlock?.variableManager.parse(&tryCode) else {
            return nil
        }
        
        code = tryCode
        return VariableElement(variable)
    }
}

/*
 // Seek for the following character to determine it is a function / array or not
 while(currCode.hasPrefix("(") || currCode.hasPrefix(",") || currCode.hasPrefix(")")) {
 if (parameters == nil) {
 parameters = []
 }
 
 let subParser = ExpressionParser.init(currCode[1...])
 do {
 let subTuple = try subParser.parse()
 parameters!.append(subTuple.instructions)
 if (subTuple.rest.hasPrefix(")")) {
 // end of the function or array
 currCode = subTuple.rest[1...]
 break
 } else {
 currCode = subTuple.rest
 }
 } catch let error {
 throw error
 }
 }
 */

