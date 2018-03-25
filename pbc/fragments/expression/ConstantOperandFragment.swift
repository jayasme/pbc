//
//  ConstantOperandFragment.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/21.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class ConstantOperand: Operand {
    var constant: Constant
    
    init(_ constant: Constant) {
        self.constant = constant

        super.init(type: constant.type)
    }
}

class ConstantOperandFragment: OperandFragment {
    init(_ constant: Constant) {
        super.init(ConstantOperand(constant))
    }
}

