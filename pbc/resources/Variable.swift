//
//  Variable.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/21.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class Variable: Operand, BaseManagerContent {
    var name: String
    
    init(name: String, type: Type) {
        self.name = name
        super.init(type: type)
    }
}

class ArrayVariable: Variable, ArrayOperand {
    var subscripts: Subscripts
    
    init(name: String, type: Type, subscripts: Subscripts) {
        self.subscripts = subscripts
        super.init(name: name, type: type)
    }
}
