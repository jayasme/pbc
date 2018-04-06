//
//  Loads.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/15.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_LOAD: PBI {
    var item: PBI_VARIABLE
    
    init(opercode: Int8, item: PBI_VARIABLE) {
        self.item = item
        super.init(catecode: 0x11, opercode: opercode)
    }
    
    static func select(variable: VariableOperand) -> PBI_LOAD? {
        guard let item = PBIConverter.POOL.element(byName: variable.variable.name) as? PBI_VARIABLE else {
            return nil
        }
        
        if (item.type == SHORTType || item.type == BOOLEANType) {
            return PBI_LOAD_S(item: item)
        } else if (item.type == INTEGERType) {
            return PBI_LOAD_I(item: item)
        } else if (item.type == LONGType) {
            return PBI_LOAD_L(item: item)
        } else if (item.type == SINGLEType) {
            return PBI_LOAD_F(item: item)
        } else if (item.type == DOUBLEType) {
            return PBI_LOAD_D(item: item)
        } else if (item.type == STRINGType) {
            return PBI_LOAD_T(item: item)
        }
        
        return PBI_LOAD_A(item: item)
    }
}

class PBI_LOAD_S: PBI_LOAD {
    init(item: PBI_VARIABLE) {
        super.init(opercode: 0x1, item: item)
    }
}

class PBI_LOAD_I: PBI_LOAD {
    init(item: PBI_VARIABLE) {
        super.init(opercode: 0x2, item: item)
    }
}

class PBI_LOAD_L: PBI_LOAD {
    init(item: PBI_VARIABLE) {
        super.init(opercode: 0x3, item: item)
    }
}

class PBI_LOAD_F: PBI_LOAD {
    init(item: PBI_VARIABLE) {
        super.init(opercode: 0x4, item: item)
    }
}

class PBI_LOAD_D: PBI_LOAD {
    init(item: PBI_VARIABLE) {
        super.init(opercode: 0x5, item: item)
    }
}

class PBI_LOAD_T: PBI_LOAD {
    init(item: PBI_VARIABLE) {
        super.init(opercode: 0x6, item: item)
    }
}

class PBI_LOAD_A: PBI_LOAD {
    init(item: PBI_VARIABLE) {
        super.init(opercode: 0x7, item: item)
    }
}
