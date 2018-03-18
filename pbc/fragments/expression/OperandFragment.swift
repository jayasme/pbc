//
//  ConstantFragment.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/14.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class OperandFragment: ExpressionSubFragment {
    var value: Operand
    
    init(_ value: Operand) {
        self.value = value
    }
    
    var variable: Variable? {
        return self.value as? Variable
    }
    
    var constant: Constant? {
        return self.value as? Constant
    }
    
    var functionInvoker: FunctionInvoker? {
        return self.value as? FunctionInvoker
    }
    
    var variableInvoker: VariableInvoker? {
        return self.value as? VariableInvoker
    }
}
