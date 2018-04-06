//
//  PBI_DIV.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/6.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_DIV: PBI {
    init(opercode: Int8) {
        super.init(catecode: 0x23, opercode: opercode)
    }
    
    static func select(operand1: Operand, operand2: Operand) -> PBI_DIV? {
        let type = Type.mixType(type1: operand1.type.type, type2: operand2.type.type)
        if type == SHORTType {
            return PBI_DIV_S()
        } else if type == INTEGERType {
            return PBI_DIV_I()
        } else if type == LONGType {
            return PBI_DIV_L()
        } else if type == SINGLEType {
            return PBI_DIV_F()
        } else if type == DOUBLEType {
            return PBI_DIV_D()
        }
        
        return nil
    }
}

class PBI_DIV_S: PBI_DIV {
    init() {
        super.init(opercode: 0x1)
    }
}

class PBI_DIV_I: PBI_DIV {
    init() {
        super.init(opercode: 0x2)
    }
}

class PBI_DIV_L: PBI_DIV {
    init() {
        super.init(opercode: 0x3)
    }
}

class PBI_DIV_F: PBI_DIV {
    init() {
        super.init(opercode: 0x4)
    }
}

class PBI_DIV_D: PBI_DIV {
    init() {
        super.init(opercode: 0x5)
    }
}
