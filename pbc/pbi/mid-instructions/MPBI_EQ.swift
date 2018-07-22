//
//  MPBI_EQL.swift
//  pbc
//
//  Created by Scott Rong on 2018/7/21.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class MPBI_EQ: PBI {
    init(opercode: Int8) {
        super.init(catecode: 0, opercode: opercode)
    }
    
    static func create(operand1: Operand, operand2: Operand) -> MPBI_EQ? {
        let type = Type.mixType(type1: operand1.type.type, type2: operand2.type.type)
        if (type == BOOLEANType) {
            return MPBI_EQ_B()
        } else if (type == SHORTType) {
            return MPBI_EQ_S()
        } else if (type == INTEGERType) {
            return MPBI_EQ_I()
        } else if (type == LONGType) {
            return MPBI_EQ_L()
        } else if (type == SINGLEType) {
            return MPBI_EQ_F()
        } else if (type == DOUBLEType) {
            return MPBI_EQ_D()
        } else if (type == STRINGType) {
            return MPBI_EQ_T()
        }
        
        return nil
    }
}

class MPBI_EQ_B: MPBI_EQ {
    init() {
        super.init(opercode: 0x7)
    }
}

class MPBI_EQ_S: MPBI_EQ {
    init() {
        super.init(opercode: 0x8)
    }
}

class MPBI_EQ_I: MPBI_EQ {
    init() {
        super.init(opercode: 0x9)
    }
}

class MPBI_EQ_L: MPBI_EQ {
    init() {
        super.init(opercode: 0xA)
    }
}

class MPBI_EQ_F: MPBI_EQ {
    init() {
        super.init(opercode: 0xB)
    }
}

class MPBI_EQ_D: MPBI_EQ {
    init() {
        super.init(opercode: 0xC)
    }
}

class MPBI_EQ_T: MPBI_EQ {
    init() {
        super.init(opercode: 0xD)
    }
}
