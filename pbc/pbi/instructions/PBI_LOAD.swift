//
//  PBI_LOAD.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/15.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_LOAD: PBI {
    var index: Int
    
    fileprivate init(opercode: Int8, index: Int) {
        self.index = index
        super.init(catecode: 0x11, opercode: opercode)
    }
    
    static func create(type: Type, index: Int) -> PBI_LOAD? {
        if (type == BOOLEANType) {
            return PBI_LOAD_B(index: index)
        } else if (type == SHORTType) {
            return PBI_LOAD_S(index: index)
        } else if (type == INTEGERType) {
            return PBI_LOAD_I(index: index)
        } else if (type == LONGType) {
            return PBI_LOAD_L(index: index)
        } else if (type == SINGLEType) {
            return PBI_LOAD_F(index: index)
        } else if (type == DOUBLEType) {
            return PBI_LOAD_D(index: index)
        } else if (type == STRINGType) {
            return PBI_LOAD_T(index: index)
        }
        
        return PBI_LOAD_A(index: index)
    }
}

fileprivate class PBI_LOAD_B: PBI_LOAD {
    init(index: Int) {
        super.init(opercode: 0x1, index: index)
    }
}

fileprivate class PBI_LOAD_S: PBI_LOAD {
    init(index: Int) {
        super.init(opercode: 0x2, index: index)
    }
}

fileprivate class PBI_LOAD_I: PBI_LOAD {
    init(index: Int) {
        super.init(opercode: 0x3, index: index)
    }
}

class PBI_LOAD_L: PBI_LOAD {
    init(index: Int) {
        super.init(opercode: 0x4, index: index)
    }
}

class PBI_LOAD_F: PBI_LOAD {
    init(index: Int) {
        super.init(opercode: 0x5, index: index)
    }
}

class PBI_LOAD_D: PBI_LOAD {
    init(index: Int) {
        super.init(opercode: 0x6, index: index)
    }
}

class PBI_LOAD_T: PBI_LOAD {
    init(index: Int) {
        super.init(opercode: 0x7, index: index)
    }
}

class PBI_LOAD_A: PBI_LOAD {
    init(index: Int) {
        super.init(opercode: 0x8, index: index)
    }
}
