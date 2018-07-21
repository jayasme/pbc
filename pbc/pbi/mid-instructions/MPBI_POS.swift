//
//  MPBI_POS.swift
//  pbc
//
//  Created by Scott Rong on 2018/7/21.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class MPBI_POS: PBI {
    init(opercode: Int8) {
        super.init(catecode: 0, opercode: opercode)
    }
    
    static func select(operand: Operand) -> MPBI_POS? {
        let type = operand.type.type
        if (type == SHORTType) {
            return MPBI_POS_S()
        } else if (type == INTEGERType) {
            return MPBI_POS_I()
        } else if (type == LONGType) {
            return MPBI_POS_L()
        } else if (type == SINGLEType) {
            return MPBI_POS_F()
        } else if (type == DOUBLEType) {
            return MPBI_POS_D()
        }
        
        return nil
    }
}

class MPBI_POS_S: MPBI_POS {
    init() {
        super.init(opercode: 0x2)
    }
}

class MPBI_POS_I: MPBI_POS {
    init() {
        super.init(opercode: 0x3)
    }
}

class MPBI_POS_L: MPBI_POS {
    init() {
        super.init(opercode: 0x4)
    }
}

class MPBI_POS_F: MPBI_POS {
    init() {
        super.init(opercode: 0x5)
    }
}

class MPBI_POS_D: MPBI_POS {
    init() {
        super.init(opercode: 0x6)
    }
}
