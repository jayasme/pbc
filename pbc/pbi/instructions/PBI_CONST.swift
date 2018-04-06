//
//  Constants.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/15.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_CONST: PBI {
    var operand: Any
    
    init(opercode: Int8, operand: Any) {
        self.operand = operand
        super.init(catecode: 0x10, opercode: opercode)
    }
    
    static func select(constant: ConstantOperand) -> PBI_CONST? {
        if let short = constant.constant.shortValue {
            return PBI_CONST_S(operand: short)
        } else if let integer = constant.constant.integerValue {
            return PBI_CONST_I(operand: integer)
        } else if let long = constant.constant.longValue {
            return PBI_CONST_L(operand: long)
        } else if let float = constant.constant.floatValue {
            return PBI_CONST_F(operand: float)
        } else if let double = constant.constant.doubleValue {
            return PBI_CONST_D(operand: double)
        } else if let string = constant.constant.stringValue {
            return PBI_CONST_T(operand: string)
        } else if let boolean = constant.constant.booleanValue {
            let value = boolean ? Int16(1) : Int16(0)
            return PBI_CONST_S(operand: value)
        }
        
        return nil
    }
}

class PBI_CONST_S: PBI_CONST {
    init(operand :Int16) {
        super.init(opercode: 0x1, operand: operand)
    }
}

class PBI_CONST_I: PBI_CONST {
    init(operand: Int32) {
        super.init(opercode: 0x2, operand: operand)
    }
}

class PBI_CONST_L: PBI_CONST {
    init(operand: Int64) {
        super.init(opercode: 0x3, operand: operand)
    }
}

class PBI_CONST_F: PBI_CONST {
    init(operand: Float) {
        super.init(opercode: 0x4, operand: operand)
    }
}

class PBI_CONST_D: PBI_CONST {
    init(operand: Double) {
        super.init(opercode: 0x5, operand: operand)
    }
}

class PBI_CONST_T: PBI_CONST {
    init(operand: String) {
        super.init(opercode: 0x6, operand: operand)
    }
}
