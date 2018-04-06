//
//  PBI_INTDIV.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/6.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_INTDIV: PBI {
    init(opercode: Int8) {
        super.init(catecode: 0x23, opercode: opercode)
    }
    
    static func select(operand1: Operand, operand2: Operand) -> PBI_INTDIV? {
        let type = Type.mixType(type1: operand1.type.type, type2: operand2.type.type)
        if type == SHORTType {
            return PBI_INTDIV_S()
        } else if type == INTEGERType {
            return PBI_INTDIV_I()
        } else if type == LONGType {
            return PBI_INTDIV_L()
        } else if type == SINGLEType {
            return PBI_INTDIV_F()
        } else if type == DOUBLEType {
            return PBI_INTDIV_D()
        }
        
        return nil
    }
}

class PBI_INTDIV_S: PBI_INTDIV {
    init() {
        super.init(opercode: 0x1)
    }
}

class PBI_INTDIV_I: PBI_INTDIV {
    init() {
        super.init(opercode: 0x2)
    }
}

class PBI_INTDIV_L: PBI_INTDIV {
    init() {
        super.init(opercode: 0x3)
    }
}

class PBI_INTDIV_F: PBI_INTDIV {
    init() {
        super.init(opercode: 0x4)
    }
}

class PBI_INTDIV_D: PBI_INTDIV {
    init() {
        super.init(opercode: 0x5)
    }
}

