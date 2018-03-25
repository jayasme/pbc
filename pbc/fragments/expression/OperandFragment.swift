//
//  ConstantFragment.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/14.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class Operand {
    var type: TypeTuple
    
    init(type: TypeTuple) {
        self.type = type
    }
}

class OperandFragment: ExpressionSubFragment {
    var value: Operand
    
    init(_ value: Operand) {
        self.value = value
    }
    
    var constantOperand: ConstantOperand? {
        return self.value as? ConstantOperand
    }
    
    var functionOperand: FunctionOperand? {
        return self.value as? FunctionOperand
    }
    
    var variableOperand: VariableOperand? {
        return self.value as? VariableOperand
    }
}
