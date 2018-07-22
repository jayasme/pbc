//
//  MPBI_GT.swift
//  pbc
//
//  Created by Scott Rong on 2018/7/22.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class MPBI_GT: PBI {
    init(opercode: Int8) {
        super.init(catecode: 0, opercode: opercode)
    }
    
    static func create(operand1: Operand, operand2: Operand) -> MPBI_GT? {
        let type = Type.mixType(type1: operand1.type.type, type2: operand2.type.type)
        if (type == SHORTType) {
            return MPBI_GT_S()
        } else if (type == INTEGERType) {
            return MPBI_GT_I()
        } else if (type == LONGType) {
            return MPBI_GT_L()
        } else if (type == SINGLEType) {
            return MPBI_GT_F()
        } else if (type == DOUBLEType) {
            return MPBI_GT_D()
        }
        
        return nil
    }
}

class MPBI_GT_S: MPBI_GT {
    init() {
        super.init(opercode: 0x15)
    }
}

class MPBI_GT_I: MPBI_GT {
    init() {
        super.init(opercode: 0x16)
    }
}

class MPBI_GT_L: MPBI_GT {
    init() {
        super.init(opercode: 0x17)
    }
}

class MPBI_GT_F: MPBI_GT {
    init() {
        super.init(opercode: 0x18)
    }
}

class MPBI_GT_D: MPBI_GT {
    init() {
        super.init(opercode: 0x19)
    }
}
