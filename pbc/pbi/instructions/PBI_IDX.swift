//
//  PBI_IDX.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/7.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_IDX: PBI {
    let dimensions: Int
    
    init(opercode: Int8, dimensions: Int) {
        self.dimensions = dimensions
        super.init(catecode: 0x30, opercode: opercode)
    }
    
    static func select(operand: Operand) -> PBI_IDX {
        let type = operand.type.type
        let dimensions = operand.type.subscripts?.dimensions ?? 0
        if (type == SHORTType || type == BOOLEANType) {
            return PBI_IDX_S(dimensions: dimensions)
        } else if (type == INTEGERType) {
            return PBI_IDX_I(dimensions: dimensions)
        } else if (type == LONGType) {
            return PBI_IDX_L(dimensions: dimensions)
        } else if (type == SINGLEType) {
            return PBI_IDX_F(dimensions: dimensions)
        } else if (type == DOUBLEType) {
            return PBI_IDX_D(dimensions: dimensions)
        } else if (type == STRINGType) {
            return PBI_IDX_T(dimensions: dimensions)
        }
        return PBI_IDX_A(dimensions: dimensions)
    }
}

class PBI_IDX_S: PBI_IDX {
    init(dimensions: Int) {
        super.init(opercode: 0x1, dimensions: dimensions)
    }
}

class PBI_IDX_I: PBI_IDX {
    init(dimensions: Int) {
        super.init(opercode: 0x2, dimensions: dimensions)
    }
}

class PBI_IDX_L: PBI_IDX {
    init(dimensions: Int) {
        super.init(opercode: 0x3, dimensions: dimensions)
    }
}

class PBI_IDX_F: PBI_IDX {
    init(dimensions: Int) {
        super.init(opercode: 0x4, dimensions: dimensions)
    }
}

class PBI_IDX_D: PBI_IDX {
    init(dimensions: Int) {
        super.init(opercode: 0x5, dimensions: dimensions)
    }
}

class PBI_IDX_T: PBI_IDX {
    init(dimensions: Int) {
        super.init(opercode: 0x6, dimensions: dimensions)
    }
}

class PBI_IDX_A: PBI_IDX {
    init(dimensions: Int) {
        super.init(opercode: 0x0, dimensions: dimensions)
    }
}
