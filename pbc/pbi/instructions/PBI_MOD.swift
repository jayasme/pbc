//
//  PBI_MOD.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/6.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_MOD: PBI {
    init(opercode: Int8) {
        super.init(catecode: 0x23, opercode: opercode)
    }
    
    static func select(operand1: Operand, operand2: Operand) -> PBI_MOD? {
        let type = Type.mixType(type1: operand1.type.type, type2: operand2.type.type)
        if type == SHORTType {
            return PBI_MOD_S()
        } else if type == INTEGERType {
            return PBI_MOD_I()
        } else if type == LONGType {
            return PBI_MOD_L()
        } else if type == SINGLEType {
            return PBI_MOD_F()
        } else if type == DOUBLEType {
            return PBI_MOD_D()
        }
        
        return nil
    }
}

class PBI_MOD_S: PBI_MOD {
    init() {
        super.init(opercode: 0x1)
    }
}

class PBI_MOD_I: PBI_MOD {
    init() {
        super.init(opercode: 0x2)
    }
}

class PBI_MOD_L: PBI_MOD {
    init() {
        super.init(opercode: 0x3)
    }
}

class PBI_MOD_F: PBI_MOD {
    init() {
        super.init(opercode: 0x4)
    }
}

class PBI_MOD_D: PBI_MOD {
    init() {
        super.init(opercode: 0x5)
    }
}
