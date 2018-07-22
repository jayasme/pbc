//
//  PBI_LOADX.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/7.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_LOADX: PBI {
    let index: Int
    let dimensions: Int
    
    init(opercode: Int8, index: Int, dimensions: Int) {
        self.index = index
        self.dimensions = dimensions
        super.init(catecode: 0x30, opercode: opercode)
    }
    
    static func create(type: Type, index: Int, dimensions: Int) -> PBI_LOADX {
        if (type == BOOLEANType) {
            return PBI_BLOADX(index: index, dimensions: dimensions)
        } else if (type == SHORTType) {
            return PBI_SLOADX(index: index, dimensions: dimensions)
        } else if (type == INTEGERType) {
            return PBI_ILOADX(index: index, dimensions: dimensions)
        } else if (type == LONGType) {
            return PBI_LLOADX(index: index, dimensions: dimensions)
        } else if (type == SINGLEType) {
            return PBI_FLOADX(index: index, dimensions: dimensions)
        } else if (type == DOUBLEType) {
            return PBI_DLOADX(index: index, dimensions: dimensions)
        } else if (type == STRINGType) {
            return PBI_TLOADX(index: index, dimensions: dimensions)
        }
        return PBI_ALOADX(index: index, dimensions: dimensions)
    }
}

fileprivate class PBI_BLOADX: PBI_LOADX {
    init(index: Int, dimensions: Int) {
        super.init(opercode: 0x1, index: index, dimensions: dimensions)
    }
}

fileprivate class PBI_SLOADX: PBI_LOADX {
    init(index: Int, dimensions: Int) {
        super.init(opercode: 0x2, index: index, dimensions: dimensions)
    }
}

fileprivate class PBI_ILOADX: PBI_LOADX {
    init(index: Int, dimensions: Int) {
        super.init(opercode: 0x3, index: index, dimensions: dimensions)
    }
}

fileprivate class PBI_LLOADX: PBI_LOADX {
    init(index: Int, dimensions: Int) {
        super.init(opercode: 0x4, index: index, dimensions: dimensions)
    }
}

fileprivate class PBI_FLOADX: PBI_LOADX {
    init(index: Int, dimensions: Int) {
        super.init(opercode: 0x5, index: index, dimensions: dimensions)
    }
}

fileprivate class PBI_DLOADX: PBI_LOADX {
    init(index: Int, dimensions: Int) {
        super.init(opercode: 0x6, index: index, dimensions: dimensions)
    }
}

fileprivate class PBI_TLOADX: PBI_LOADX {
    init(index: Int, dimensions: Int) {
        super.init(opercode: 0x7, index: index, dimensions: dimensions)
    }
}

fileprivate class PBI_ALOADX: PBI_LOADX {
    init(index: Int, dimensions: Int) {
        super.init(opercode: 0x8, index: index, dimensions: dimensions)
    }
}
