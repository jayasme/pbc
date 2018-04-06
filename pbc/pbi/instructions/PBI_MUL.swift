//
//  PBI_MUL.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/6.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_MUL: PBI {
    init(opercode: Int8) {
        super.init(catecode: 0x22, opercode: opercode)
    }
    
    static func select(operand1: Operand, operand2: Operand) -> PBI_MUL? {
        let type = Type.mixType(type1: operand1.type.type, type2: operand2.type.type)
        if type == SHORTType {
            return PBI_MUL_S()
        } else if type == INTEGERType {
            return PBI_MUL_I()
        } else if type == LONGType {
            return PBI_MUL_L()
        } else if type == SINGLEType {
            return PBI_MUL_F()
        } else if type == DOUBLEType {
            return PBI_MUL_D()
        }
        
        return nil
    }
}

class PBI_MUL_S: PBI_MUL {
    init() {
        super.init(opercode: 0x1)
    }
}

class PBI_MUL_I: PBI_MUL {
    init() {
        super.init(opercode: 0x2)
    }
}

class PBI_MUL_L: PBI_MUL {
    init() {
        super.init(opercode: 0x3)
    }
}

class PBI_MUL_F: PBI_MUL {
    init() {
        super.init(opercode: 0x4)
    }
}

class PBI_MUL_D: PBI_MUL {
    init() {
        super.init(opercode: 0x5)
    }
}
