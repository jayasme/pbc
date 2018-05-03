//
//  PBI_SUB.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/6.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_SUB: PBI {
    init(opercode: Int8) {
        super.init(catecode: 0x21, opercode: opercode)
    }
    
    static func select(operand1: Operand, operand2: Operand) -> PBI_SUB? {
        let type = Type.mixType(type1: operand1.type.type, type2: operand2.type.type)
        if (type == SHORTType) {
            return PBI_SUB_S()
        } else if (type == INTEGERType) {
            return PBI_SUB_I()
        } else if (type == LONGType) {
            return PBI_SUB_L()
        } else if (type == SINGLEType) {
            return PBI_SUB_F()
        } else if (type == DOUBLEType) {
            return PBI_SUB_D()
        }
        
        return nil
    }
}

class PBI_SUB_S: PBI_SUB {
    init() {
        super.init(opercode: 0x1)
    }
}

class PBI_SUB_I: PBI_SUB {
    init() {
        super.init(opercode: 0x2)
    }
}

class PBI_SUB_L: PBI_SUB {
    init() {
        super.init(opercode: 0x3)
    }
}

class PBI_SUB_F: PBI_SUB {
    init() {
        super.init(opercode: 0x4)
    }
}

class PBI_SUB_D: PBI_SUB {
    init() {
        super.init(opercode: 0x5)
    }
}
