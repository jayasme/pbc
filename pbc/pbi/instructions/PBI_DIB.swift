//
//  PBI_DIB.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/6.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_DIB: PBI {
    init(opercode: Int8) {
        super.init(catecode: 0x24, opercode: opercode)
    }
    
    static func select(operand1: Operand, operand2: Operand) -> PBI_DIB? {
        let type = Type.mixType(type1: operand1.type.type, type2: operand2.type.type)
        if (type == SHORTType) {
            return PBI_DIB_S()
        } else if (type == INTEGERType) {
            return PBI_DIB_I()
        } else if (type == LONGType) {
            return PBI_DIB_L()
        }
        
        return nil
    }
}

class PBI_DIB_S: PBI_DIB {
    init() {
        super.init(opercode: 0x1)
    }
}

class PBI_DIB_I: PBI_DIB {
    init() {
        super.init(opercode: 0x2)
    }
}

class PBI_DIB_L: PBI_DIB {
    init() {
        super.init(opercode: 0x3)
    }
}
