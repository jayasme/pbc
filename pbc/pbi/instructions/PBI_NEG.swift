//
//  PBI_NEG.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/7.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_NEG: PBI {
    init(opercode: Int8) {
        super.init(catecode: 0x2A, opercode: opercode)
    }
    
    static func select(operand: Operand) -> PBI_NEG? {
        let type = operand.type.type
        if (type == SHORTType) {
            return PBI_NEG_S()
        } else if (type == INTEGERType) {
            return PBI_NEG_I()
        } else if (type == LONGType) {
            return PBI_NEG_L()
        } else if (type == SINGLEType) {
            return PBI_NEG_F()
        } else if (type == DOUBLEType) {
            return PBI_NEG_D()
        }
        
        return nil
    }
}

class PBI_NEG_S: PBI_NEG {
    init() {
        super.init(opercode: 0x1)
    }
}

class PBI_NEG_I: PBI_NEG {
    init() {
        super.init(opercode: 0x2)
    }
}

class PBI_NEG_L: PBI_NEG {
    init() {
        super.init(opercode: 0x3)
    }
}

class PBI_NEG_F: PBI_NEG {
    init() {
        super.init(opercode: 0x4)
    }
}

class PBI_NEG_D: PBI_NEG {
    init() {
        super.init(opercode: 0x5)
    }
}
