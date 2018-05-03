//
//  PBI_EQV.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/6.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_EQV: PBI {
    init(opercode: Int8) {
        super.init(catecode: 0x29, opercode: opercode)
    }
    
    static func select(operand1: Operand, operand2: Operand) -> PBI_EQV? {
        let type = Type.mixType(type1: operand1.type.type, type2: operand2.type.type)
        if (type == SHORTType) {
            return PBI_EQV_S()
        }
        
        return nil
    }
}

class PBI_EQV_S: PBI_EQV {
    init() {
        super.init(opercode: 0x1)
    }
}
