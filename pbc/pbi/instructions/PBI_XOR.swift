//
//  PBI_XOR.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/6.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_XOR: PBI {
    init(opercode: Int8) {
        super.init(catecode: 0x28, opercode: opercode)
    }
    
    static func create(operand1: Operand, operand2: Operand) -> PBI_XOR? {
        let type = Type.mixType(type1: operand1.type.type, type2: operand2.type.type)
        if (type == BOOLEANType) {
            return PBI_XOR_B()
        } else if (type == SHORTType) {
            return PBI_XOR_S()
        } else if (type == INTEGERType) {
            return PBI_XOR_I()
        } else if (type == LONGType) {
            return PBI_XOR_L()
        } else if (type == SINGLEType) {
            return PBI_XOR_F()
        } else if (type == DOUBLEType) {
            return PBI_XOR_D()
        }
        
        return nil
    }
}

class PBI_XOR_B: PBI_XOR {
    init() {
        super.init(opercode: 0x1)
    }
}

class PBI_XOR_S: PBI_XOR {
    init() {
        super.init(opercode: 0x2)
    }
}

class PBI_XOR_I: PBI_XOR {
    init() {
        super.init(opercode: 0x3)
    }
}

class PBI_XOR_L: PBI_XOR {
    init() {
        super.init(opercode: 0x4)
    }
}


class PBI_XOR_F: PBI_XOR {
    init() {
        super.init(opercode: 0x5)
    }
}

class PBI_XOR_D: PBI_XOR {
    init() {
        super.init(opercode: 0x6)
    }
}

