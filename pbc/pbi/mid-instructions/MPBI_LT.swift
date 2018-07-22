//
//  MPBI_LT.swift
//  pbc
//
//  Created by Scott Rong on 2018/7/22.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class MPBI_LT: PBI {
    init(opercode: Int8) {
        super.init(catecode: 0, opercode: opercode)
    }
    
    static func create(operand1: Operand, operand2: Operand) -> MPBI_LT? {
        let type = Type.mixType(type1: operand1.type.type, type2: operand2.type.type)
        if (type == SHORTType) {
            return MPBI_LT_S()
        } else if (type == INTEGERType) {
            return MPBI_LT_I()
        } else if (type == LONGType) {
            return MPBI_LT_L()
        } else if (type == SINGLEType) {
            return MPBI_LT_F()
        } else if (type == DOUBLEType) {
            return MPBI_LT_D()
        }
        
        return nil
    }
}

class MPBI_LT_S: MPBI_LT {
    init() {
        super.init(opercode: 0x1F)
    }
}

class MPBI_LT_I: MPBI_LT {
    init() {
        super.init(opercode: 0x20)
    }
}

class MPBI_LT_L: MPBI_LT {
    init() {
        super.init(opercode: 0x21)
    }
}

class MPBI_LT_F: MPBI_LT {
    init() {
        super.init(opercode: 0x22)
    }
}

class MPBI_LT_D: MPBI_LT {
    init() {
        super.init(opercode: 0x23)
    }
}
