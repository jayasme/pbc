//
//  ConstantFragment.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/14.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class OperandFragment: ExpressionSubFragment {
    var operand: Operand
    
    init(_ operand: Operand) {
        self.operand = operand
    }
    
    var variable: Variable? {
        return self.operand as? Variable
    }
    
    var constant: Constant? {
        return self.operand as? Constant
    }
}
