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
    
    static func create(type: Type, index: Int) -> PBI_LOAD {
        if (type == BOOLEANType) {
            return PBI_BLOAD(index: index)
        } else if (type == SHORTType) {
            return PBI_SLOAD(index: index)
        } else if (type == INTEGERType) {
            return PBI_ILOAD(index: index)
        } else if (type == LONGType) {
            return PBI_LLOAD(index: index)
        } else if (type == SINGLEType) {
            return PBI_FLOAD(index: index)
        } else if (type == DOUBLEType) {
            return PBI_DLOAD(index: index)
        } else if (type == STRINGType) {
            return PBI_TLOAD(index: index)
        }
        
        return PBI_ALOAD(index: index)
    }
}

fileprivate class PBI_BLOAD: PBI_LOAD {
    init(index: Int) {
        super.init(opercode: 0x1, index: index)
    }
}

fileprivate class PBI_SLOAD: PBI_LOAD {
    init(index: Int) {
        super.init(opercode: 0x2, index: index)
    }
}

fileprivate class PBI_ILOAD: PBI_LOAD {
    init(index: Int) {
        super.init(opercode: 0x3, index: index)
    }
}

fileprivate class PBI_LLOAD: PBI_LOAD {
    init(index: Int) {
        super.init(opercode: 0x4, index: index)
    }
}

fileprivate class PBI_FLOAD: PBI_LOAD {
    init(index: Int) {
        super.init(opercode: 0x5, index: index)
    }
}

fileprivate class PBI_DLOAD: PBI_LOAD {
    init(index: Int) {
        super.init(opercode: 0x6, index: index)
    }
}

fileprivate class PBI_TLOAD: PBI_LOAD {
    init(index: Int) {
        super.init(opercode: 0x7, index: index)
    }
}

fileprivate class PBI_ALOAD: PBI_LOAD {
    init(index: Int) {
        super.init(opercode: 0x8, index: index)
    }
}
