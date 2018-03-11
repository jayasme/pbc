//
//  Constant.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/11.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation


class ArraySubscript {
    var lowerBound: Int32
    var upperBound: Int32
    
    init(lowerBound: Int32 = 1, upperBound: Int32) {
        self.lowerBound = lowerBound
        self.upperBound = upperBound
    }
}

class Variable: BaseManagerContent {
    var type: Type
    var initialValue: OperandElement
    
    var isArray: Bool {
        return self is ArrayVariable
    }
    
    init(name: String, type: Type, initialValue: OperandElement? = nil) {
        self.type = type
        self.initialValue = initialValue != nil ? initialValue! : ConstantElement(type.defaultValue, type: type)
        super.init(name)
    }
}

class ArrayVariable: Variable {
    var subscripts: [ArraySubscript]
    
    init(name: String, type: Type, subscripts: [ArraySubscript] = [], initialValue: OperandElement? = nil) {
        self.subscripts = subscripts
        super.init(name: name, type: type, initialValue: initialValue)
    }
}
