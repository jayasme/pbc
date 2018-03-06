//
//  Variable.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/21.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class VariableArrayBound {
    var lowerBound: Int32
    var upperBound: Int32
    
    init(lowerBound: Int32 = 1, upperBound: Int32) {
        self.lowerBound = lowerBound
        self.upperBound = upperBound
    }
}

class Variable: BaseManagerContent {
    var type: Type
    var bounds: [VariableArrayBound]?
    var initialValue: OperandElement?
    
    init(name: String, type: Type, bounds: [VariableArrayBound]? = nil, initialValue: OperandElement? = nil) {
        self.type = type
        self.bounds = bounds
        self.initialValue = initialValue
        super.init(name)
    }
}