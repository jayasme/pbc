//
//  FunctionInvokerFragment.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/15.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class FunctionInvoker: Operand {
    var function: Function
    var arguments: Arguments
    
    fileprivate init(function: Function, arguments: Arguments) throws {
        self.function = function
        self.arguments = arguments
        
        super.init(type: function.returningType)
    }
}

class ArrayFunctionInvoker: FunctionInvoker, ArrayOperand {
    var subscripts: Subscripts
    
    fileprivate override init(function: Function, arguments: Arguments) throws {
        guard let subscripts = function.returningSubscripts else {
            throw InvalidValueError("No returning subscripts found.")
        }
        
        self.subscripts = subscripts
        try super.init(function: function, arguments: arguments)
    }
}

class FunctionInvokerFragment: OperandFragment {
    init(function: Function, arguments: Arguments) throws {
        var operand: Operand! = nil;
        if (function.returningSubscripts != nil) {
            operand = try ArrayFunctionInvoker(function: function, arguments: arguments)
        } else {
            operand = try FunctionInvoker(function: function, arguments: arguments)
        }
        super.init(operand)
    }
}
