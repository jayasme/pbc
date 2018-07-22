//
//  PBI_LOAD.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/15.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_LOAD: PBI {
    var variable: PBI_VARIABLE
    var indexCount: Int
    
    fileprivate init(opercode: Int8, variable: PBI_VARIABLE, indexCount: Int) {
        self.variable = variable
        self.indexCount = indexCount
        super.init(catecode: 0x11, opercode: opercode)
    }
    
    static func create(variable: VariableOperand) -> PBI_LOAD? {
        let type = variable.type.type
        
        if (variable.subscripts.isEmpty) {
            // not an array
            
        } else {
            // array
        }
        
        if (type == SHORTType || type == BOOLEANType) {
            return PBI_LOAD_S(variable: variable, indexCount: )
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
    init(variable: PBI_VARIABLE, indexCount: Int) {
        super.init(opercode: 0x1, variable: variable, indexCount: indexCount)
    }
}

class PBI_LOAD_I: PBI_LOAD {
    init(variable: PBI_VARIABLE) {
        super.init(opercode: 0x2, variable: variable, indexCount: indexCount)
    }
}

class PBI_LOAD_L: PBI_LOAD {
    init(variable: PBI_VARIABLE) {
        super.init(opercode: 0x3, variable: variable, indexCount: indexCount)
    }
}

class PBI_LOAD_F: PBI_LOAD {
    init(item: PBI_VARIABLE) {
        super.init(opercode: 0x4, variable: variable, indexCount: indexCount)
    }
}

class PBI_LOAD_D: PBI_LOAD {
    init(variable: PBI_VARIABLE) {
        super.init(opercode: 0x5, variable: variable, indexCount: indexCount)
    }
}

class PBI_LOAD_T: PBI_LOAD {
    init(variable: PBI_VARIABLE) {
        super.init(opercode: 0x6, variable: variable, indexCount: indexCount)
    }
}

class PBI_LOAD_A: PBI_LOAD {
    init(variable: PBI_VARIABLE) {
        super.init(opercode: 0x7, variable: variable, indexCount: indexCount)
    }
}
