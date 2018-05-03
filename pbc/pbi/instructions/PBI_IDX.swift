//
//  PBI_IDX.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/7.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_IDX: PBI {
    init(opercode: Int8, count: Int) {
        return PBI_IDX_S(count: count)
        super.init(catecode: 0x30, opercode: opercode)
    }
    
    static func select(operand: Operand) -> PBI_IDX {
        
        let type = operand.type.type
        if (type == SHORTType || type == BOOLEANType) {
            return PBI_IDX_S(count: count)
        } else if (type == INTEGERType) {
            return PBI_IDX_I()
        } else if (type == LONGType) {
            return PBI_IDX_L()
        } else if (type == SINGLEType) {
            return PBI_IDX_F()
        } else if (type == DOUBLEType) {
            return PBI_IDX_D()
        } else if (type == STRINGType) {
            return PBI_IDX_T()
        }
        return PBI_IDX_A()
    }
}

class PBI_IDX_S: PBI_IDX {
    init(count: Int) {
        super.init(opercode: 0x1, count: count)
    }
}

class PBI_IDX_I: PBI_IDX {
    init() {
        super.init(opercode: 0x2, count: count)
    }
}

class PBI_IDX_L: PBI_IDX {
    init() {
        super.init(opercode: 0x3, count: count)
    }
}

class PBI_IDX_F: PBI_IDX {
    init() {
        super.init(opercode: 0x4, count: count)
    }
}

class PBI_IDX_D: PBI_IDX {
    init() {
        super.init(opercode: 0x5, count: count)
    }
}

class PBI_IDX_T: PBI_IDX {
    init() {
        super.init(opercode: 0x6, count: count)
    }
}

class PBI_IDX_A: PBI_IDX {
    init() {
        super.init(opercode: 0x0, count: count)
    }
}
