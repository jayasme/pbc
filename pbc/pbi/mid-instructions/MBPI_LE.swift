//
//  MBPI_LE.swift
//  pbc
//
//  Created by Scott Rong on 2018/7/22.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class MPBI_LE: PBI {
    init(opercode: Int8) {
        super.init(catecode: 0, opercode: opercode)
    }
    
    static func create(operand1: Operand, operand2: Operand) -> MPBI_LE? {
        let type = Type.mixType(type1: operand1.type.type, type2: operand2.type.type)
        if (type == SHORTType) {
            return MPBI_LE_S()
        } else if (type == INTEGERType) {
            return MPBI_LE_I()
        } else if (type == LONGType) {
            return MPBI_LE_L()
        } else if (type == SINGLEType) {
            return MPBI_LE_F()
        } else if (type == DOUBLEType) {
            return MPBI_LE_D()
        }
        
        return nil
    }
}

class MPBI_LE_S: MPBI_LE {
    init() {
        super.init(opercode: 0x24)
    }
}

class MPBI_LE_I: MPBI_LE {
    init() {
        super.init(opercode: 0x25)
    }
}

class MPBI_LE_L: MPBI_LE {
    init() {
        super.init(opercode: 0x26)
    }
}

class MPBI_LE_F: MPBI_LE {
    init() {
        super.init(opercode: 0x27)
    }
}

class MPBI_LE_D: MPBI_LE {
    init() {
        super.init(opercode: 0x28)
    }
}
