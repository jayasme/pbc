//
//  PBI_EQV.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/6.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_EQV: PBI {
    init(opercode: Int8) {
        super.init(catecode: 0x29, opercode: opercode)
    }
    
    static func create(operand1: Operand, operand2: Operand) -> PBI_EQV? {
        let type = Type.mixType(type1: operand1.type.type, type2: operand2.type.type)
        if (type == BOOLEANType) {
            return PBI_EQV_B()
        } else if (type == SHORTType) {
            return PBI_EQV_S()
        } else if (type == INTEGERType) {
            return PBI_EQV_I()
        } else if (type == LONGType) {
            return PBI_EQV_L()
        } else if (type == SINGLEType) {
            return PBI_EQV_F()
        } else if (type == DOUBLEType) {
            return PBI_EQV_D()
        }
        
        return nil
    }
}

class PBI_EQV_B: PBI_EQV {
    init() {
        super.init(opercode: 0x1)
    }
}

class PBI_EQV_S: PBI_EQV {
    init() {
        super.init(opercode: 0x2)
    }
}

class PBI_EQV_I: PBI_EQV {
    init() {
        super.init(opercode: 0x3)
    }
}

class PBI_EQV_L: PBI_EQV {
    init() {
        super.init(opercode: 0x4)
    }
}


class PBI_EQV_F: PBI_EQV {
    init() {
        super.init(opercode: 0x5)
    }
}

class PBI_EQV_D: PBI_EQV {
    init() {
        super.init(opercode: 0x6)
    }
}

