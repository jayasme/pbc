//
//  FunctionInvokerFragment.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/15.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class FunctionInvokerFragment: OperandFragment {
    var function: Declare
    var arguments: [Operand]
    
    init(_ function: Declare, arguments: [Operand] = []) throws {
        guard let returningType = function.returningType else {
            throw InvalidValueError("SUB cannot be a part of expression.")
        }
        self.function = function
        self.arguments = arguments
        var operand: Operand! = nil;
        if let subscripts = function.subscripts {
            operand = ArrayOperand(type: returningType, subscripts: subscripts)
        } else {
            operand = Operand(type: returningType)
        }
        super.init(operand)
    }
}
