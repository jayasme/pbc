//
//  Invoker.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/14.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class FunctionInvoker: Operand {
    var function: Declare
    var arguments: [Operand]
    
    init(_ function: Declare, arguments: [Operand] = []) throws {
        guard let returningType = function.returningType else {
            throw InvalidValueError("SUB cannot be a part of expression.")
        }
        self.function = function
        self.arguments = arguments
        super.init(type: returningType)
    }
}

