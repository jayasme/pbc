//
//  PBI_POW.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/6.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_POW: PBI {
    init(opercode: Int8) {
        super.init(catecode: 0x25, opercode: opercode)
    }
    
    static func select(operand1: Operand, operand2: Operand) -> PBI_POW? {
        let type = Type.mixType(type1: operand1.type.type, type2: operand2.type.type)
        if (type == SHORTType) {
            return PBI_POW_S()
        } else if (type == INTEGERType) {
            return PBI_POW_I()
        } else if (type == LONGType) {
            return PBI_POW_L()
        } else if (type == SINGLEType) {
            return PBI_POW_F()
        } else if (type == DOUBLEType) {
            return PBI_POW_D()
        }
        
        return nil
    }
}

class PBI_POW_S: PBI_POW {
    init() {
        super.init(opercode: 0x1)
    }
}

class PBI_POW_I: PBI_POW {
    init() {
        super.init(opercode: 0x2)
    }
}

class PBI_POW_L: PBI_POW {
    init() {
        super.init(opercode: 0x3)
    }
}

class PBI_POW_F: PBI_POW {
    init() {
        super.init(opercode: 0x4)
    }
}

class PBI_POW_D: PBI_POW {
    init() {
        super.init(opercode: 0x5)
    }
}
