//
//  VariableFragment.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/18.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class VariableInvoker: Operand {
    var variable: Variable

    fileprivate init(variable: Variable) {
        self.variable = variable
        
        super.init(type: variable.type)
    }
}

class ArrayVariableInvoker: VariableInvoker {
    var subscripts: Arguments
    
    fileprivate init(variable: Variable, subscripts: Arguments) {
        self.subscripts = subscripts
        
        super.init(variable: variable)
    }
}

class VariableInvokerFragment: OperandFragment {
    init(variable: Variable) throws {
        guard (!variable.isArray) else {
            throw InvalidValueError("Cannot construct the variable invoker.")
        }
        
        let operand = VariableInvoker(variable: variable)
        super.init(operand)
    }
    
    init(variable: ArrayVariable, subscripts: Arguments) throws {
        guard variable.subscripts.dimensions == subscripts.arguments.count else {
            throw InvalidValueError("Count of subscripts dismatched with the variable itself.")
        }
        
        let operand = ArrayVariableInvoker(variable: variable, subscripts: subscripts)
        super.init(operand)
    }
}
