//
//  FunctionOperandFragment.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/15.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class FunctionOperand: Operand {
    var function: FunctionDeclare
    var arguments: Arguments
    
    fileprivate init(function: FunctionDeclare, arguments: Arguments) {
        self.function = function
        self.arguments = arguments
        
        super.init(type: function.returningType)
    }
}

class FunctionOperandFragment: OperandFragment {
    init(function: FunctionDeclare, arguments: Arguments) {
        super.init(FunctionOperand(function: function, arguments: arguments))
    }
}
