//
//  VariableFragment.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/18.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class VariableOperand: Operand {
    var variable: Variable
    var subscripts: Arguments

    init(_ variable: Variable, subscripts: Arguments) throws {
        self.variable = variable
        self.subscripts = subscripts
        
        // check the subscripts
        if let varSubscripts = variable.type.subscripts {
            guard (varSubscripts.dimensions == subscripts.arguments.count || varSubscripts.isDynamic || subscripts.isEmpty) else {
                throw InvalidValueError("Variable '" + variable.name + "' expected providing " + String(varSubscripts.dimensions) + " subscripts")
            }
            
            if (subscripts.isEmpty) {
                // ref the array itself
                super.init(type: variable.type)
            } else {
                super.init(type: TypeTuple(variable.type.type))
            }
        } else {
            guard (subscripts.isEmpty) else {
                throw InvalidValueError("Variable '" + variable.name + "' is not an array")
            }
            
            super.init(type: variable.type)
        }
    }
}

class VariableOperandFragment: OperandFragment {
    init(variable: Variable, subscripts: Arguments = Arguments.empty) throws {
        try super.init(VariableOperand(variable, subscripts: subscripts))
    }
}
