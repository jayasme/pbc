//
//  MPBI_NEQ.swift
//  pbc
//
//  Created by Scott Rong on 2018/7/22.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class MPBI_NEQ: PBI {
    init(opercode: Int8) {
        super.init(catecode: 0, opercode: opercode)
    }
    
    static func create(operand1: Operand, operand2: Operand) -> MPBI_NEQ? {
        let type = Type.mixType(type1: operand1.type.type, type2: operand2.type.type)
        if (type == BOOLEANType) {
            return MPBI_NEQ_B()
        } else if (type == SHORTType) {
            return MPBI_NEQ_S()
        } else if (type == INTEGERType) {
            return MPBI_NEQ_I()
        } else if (type == LONGType) {
            return MPBI_NEQ_L()
        } else if (type == SINGLEType) {
            return MPBI_NEQ_F()
        } else if (type == DOUBLEType) {
            return MPBI_NEQ_D()
        } else if (type == STRINGType) {
            return MPBI_NEQ_T()
        }
        
        return nil
    }
}

class MPBI_NEQ_B: MPBI_NEQ {
    init() {
        super.init(opercode: 0xE)
    }
}

class MPBI_NEQ_S: MPBI_NEQ {
    init() {
        super.init(opercode: 0xF)
    }
}

class MPBI_NEQ_I: MPBI_NEQ {
    init() {
        super.init(opercode: 0x10)
    }
}

class MPBI_NEQ_L: MPBI_NEQ {
    init() {
        super.init(opercode: 0x11)
    }
}

class MPBI_NEQ_F: MPBI_NEQ {
    init() {
        super.init(opercode: 0x12)
    }
}

class MPBI_NEQ_D: MPBI_NEQ {
    init() {
        super.init(opercode: 0x13)
    }
}

class MPBI_NEQ_T: MPBI_NEQ {
    init() {
        super.init(opercode: 0x14)
    }
}
