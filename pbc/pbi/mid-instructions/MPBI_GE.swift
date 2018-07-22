//
//  MPBI_GE.swift
//  pbc
//
//  Created by Scott Rong on 2018/7/22.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class MPBI_GE: PBI {
    init(opercode: Int8) {
        super.init(catecode: 0, opercode: opercode)
    }
    
    static func create(operand1: Operand, operand2: Operand) -> MPBI_GE? {
        let type = Type.mixType(type1: operand1.type.type, type2: operand2.type.type)
        if (type == SHORTType) {
            return MPBI_GE_S()
        } else if (type == INTEGERType) {
            return MPBI_GE_I()
        } else if (type == LONGType) {
            return MPBI_GE_L()
        } else if (type == SINGLEType) {
            return MPBI_GE_F()
        } else if (type == DOUBLEType) {
            return MPBI_GE_D()
        }
        
        return nil
    }
}

class MPBI_GE_S: MPBI_GE {
    init() {
        super.init(opercode: 0x1A)
    }
}

class MPBI_GE_I: MPBI_GE {
    init() {
        super.init(opercode: 0x1B)
    }
}

class MPBI_GE_L: MPBI_GE {
    init() {
        super.init(opercode: 0x1C)
    }
}

class MPBI_GE_F: MPBI_GE {
    init() {
        super.init(opercode: 0x1D)
    }
}

class MPBI_GE_D: MPBI_GE {
    init() {
        super.init(opercode: 0x1E)
    }
}
