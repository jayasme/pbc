//
//  PBI_ADD.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/2.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_ADD: PBI {
    init(opercode: Int8) {
        super.init(catecode: 0x20, opercode: opercode)
    }
    
    static func select(operand1: Operand, operand2: Operand) -> PBI_ADD? {
        let type = Type.mixType(type1: operand1.type.type, type2: operand2.type.type)
        if type == SHORTType {
            return PBI_ADD_S()
        } else if type == INTEGERType {
            return PBI_ADD_I()
        } else if type == LONGType {
            return PBI_ADD_L()
        } else if type == SINGLEType {
            return PBI_ADD_F()
        } else if type == DOUBLEType {
            return PBI_ADD_D()
        } else if type == STRINGType {
            return PBI_ADD_T()
        } else if type == BOOLEANType {
            return PBI_ADD_B()
        }
        
        return nil
    }
}

class PBI_ADD_S: PBI_ADD {
    init() {
        super.init(opercode: 0x1)
    }
}

class PBI_ADD_I: PBI_ADD {
    init() {
        super.init(opercode: 0x2)
    }
}

class PBI_ADD_L: PBI_ADD {
    init() {
        super.init(opercode: 0x3)
    }
}

class PBI_ADD_F: PBI_ADD {
    init() {
        super.init(opercode: 0x4)
    }
}

class PBI_ADD_D: PBI_ADD {
    init() {
        super.init(opercode: 0x5)
    }
}

class PBI_ADD_T: PBI_ADD {
    init() {
        super.init(opercode: 0x6)
    }
}

class PBI_ADD_B: PBI_ADD {
    init() {
        super.init(opercode: 0x7)
    }
}
